#!/usr/bin/env bash
# Builds the ToneStrand Box firmware: ToneRelay's ESP32-P4 firmware with this repository's profile (names, setup page, defaults).
#
#   scripts/build.sh            debug build (what the bench uses)
#   scripts/build.sh --release  release build
#
# Needs ESP-IDF's environment (source its export.sh, so IDF_PATH is set), a rustup toolchain for esp-idf-sys, and ToneRelay's source in
# firmware/ (ToneRelay's source, imported into this repository) or wherever TONERELAY_DIR points.
set -euo pipefail

HERE="$(cd "$(dirname "$0")/.." && pwd)"
TONERELAY_DIR="${TONERELAY_DIR:-$HERE/firmware}"
if [[ ! -d "$TONERELAY_DIR/esp32-p4" ]]; then
  echo "ToneRelay's source is not at $TONERELAY_DIR (or set TONERELAY_DIR)." >&2; exit 1
fi
if [[ -z "${IDF_PATH:-}" ]]; then
  echo "IDF_PATH is not set: source ESP-IDF's export.sh first." >&2; exit 1
fi

export TONERELAY_PROFILE_DIR="$HERE/profile"
# Bluetooth MIDI (ToneRelay's sdkconfig.midi.defaults): the box also shows up as a Bluetooth MIDI device. The link has to be encrypted.
export ESP_IDF_SDKCONFIG_DEFAULTS="${ESP_IDF_SDKCONFIG_DEFAULTS:-sdkconfig.defaults;sdkconfig.midi.defaults}"
cd "$TONERELAY_DIR/esp32-p4"
# The profile is read when the C component is configured; touching this file makes cargo rebuild it, so switching profile takes effect.
touch sdkconfig.defaults
cargo build "$@"

# The onboard C6 runs ESP-Hosted slave firmware that the P4 embeds and updates over the air. Without network_adapter.bin the
# update is skipped and a board with the factory C6 firmware has no Wi-Fi scan. It is built from the ESP-Hosted sources the first
# build downloads, so build once, make it, and build again.
SLAVE="$TONERELAY_DIR/esp32-p4/components/tonerelay/slave_fw/network_adapter.bin"
if [[ ! -f "$SLAVE" ]]; then
  echo "No C6 image yet: building it (needs ESP-IDF for esp32c6), then building the box again."
  "$TONERELAY_DIR/esp32-p4/build-c6-slave.sh"
  touch sdkconfig.defaults
  cargo build "$@"
fi

KIND=debug
for a in "$@"; do [[ "$a" == "--release" ]] && KIND=release; done
echo "built: $TONERELAY_DIR/esp32-p4/target/riscv32imafc-esp-espidf/$KIND/hxbridge-p4 (profile: $TONERELAY_PROFILE_DIR)"
