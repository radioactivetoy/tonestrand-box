#!/usr/bin/env bash
# Splits the firmware built by scripts/build.sh into the parts the web flasher writes, and describes them in web/firmware/manifest.json.
#
#   scripts/package-web.sh            from the debug build (what the bench uses)
#   scripts/package-web.sh --release  from the release build
#
# The parts are the bootloader (0x2000), the partition table (0x8000) and the app (0x10000). The settings (NVS, 0x9000), the radio data (0xf000) and the
# catalog partition are left alone, so a web update keeps the saved Wi-Fi network.
# Needs espflash and python3. web/firmware is committed and published with the rest of web/ by GitHub Pages (.github/workflows/pages.yml).
set -euo pipefail

HERE="$(cd "$(dirname "$0")/.." && pwd)"
TONERELAY_DIR="${TONERELAY_DIR:-$HERE/firmware}"
KIND=debug; [[ "${1:-}" == "--release" ]] && KIND=release
T="$TONERELAY_DIR/esp32-p4/target/riscv32imafc-esp-espidf/$KIND"
BL="$T/bootloader.bin"; [[ -f "$BL" ]] || BL="$T/build/bootloader.bin"   # esp-idf-sys puts it next to the app (older layouts: build/)
[[ -f "$T/hxbridge-p4" && -f "$BL" ]] || { echo "no $KIND build in $T: run scripts/build.sh first." >&2; exit 1; }

OUT="$HERE/web/firmware"
mkdir -p "$OUT"
MERGED="$(mktemp)"
trap 'rm -f "$MERGED"' EXIT
( cd "$TONERELAY_DIR/esp32-p4" && espflash save-image --chip esp32p4 --merge --skip-padding --flash-size 16mb \
    --bootloader "$BL" --partition-table partitions.csv --partition-table-offset 0x8000 \
    "$T/hxbridge-p4" "$MERGED" )

# Upstream tags (v1.x) belong to the Helrig Box, so the version here is our own: BOX_VERSION, or 0.1.0-dev.<commit>.
VERSION="${BOX_VERSION:-0.1.0-dev.$(git -C "$HERE" rev-parse --short HEAD 2>/dev/null || echo unknown)}"
TR="$(git -C "$HERE" rev-parse --short HEAD)"
python3 -I - "$MERGED" "$OUT" "$VERSION" "$TR" <<'PY'
import hashlib, json, sys
merged, out, version, tr = sys.argv[1:5]
d = open(merged, 'rb').read()
assert d[0x2000] == 0xE9 and d[0x8000:0x8002] == b'\xaa\x50' and d[0x10000] == 0xE9, "unexpected merged layout"
assert d[0x9000:0x10000] == b'\xff' * 0x7000, "settings area is not padding"
parts = [("bootloader.bin", 0x2000, d[0x2000:0x8000]), ("partition-table.bin", 0x8000, d[0x8000:0x9000]), ("app.bin", 0x10000, d[0x10000:])]
man = {"name": "ToneStrand Box", "chip": "ESP32-P4", "version": version, "toneRelay": tr, "parts": []}
for name, off, data in parts:
    open(f"{out}/{name}", "wb").write(data)
    man["parts"].append({"file": name, "offset": off, "size": len(data), "sha256": hashlib.sha256(data).hexdigest()})
open(f"{out}/manifest.json", "w").write(json.dumps(man, indent=2) + "\n")
print(f"{version} (ToneRelay {tr}):", ", ".join(f"{p['file']} {p['size']}" for p in man["parts"]))
PY
