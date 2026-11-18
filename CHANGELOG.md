# Changelog

Changes since the fork from the [Helrig Box](https://github.com/maveric1977/helrig-box) (see [PROVENANCE.md](PROVENANCE.md)). Dates are 2026.

## Unreleased (Nov 2026)

- Forked; ToneRelay imported into `firmware/` with its history; single repository, no submodule.
- Renamed the box: `ToneStrand Box`, `tonestrandbox`, `_tonestrandbox`; wordmark and accent colour on the setup page.
- Fix: the ESP32-C6 firmware is built and embedded by `scripts/build.sh` (empty Wi-Fi scan on the P4 board).
- Fix: Bluetooth MIDI starts the ESP-Hosted Bluetooth controller before NimBLE (BLE was dead after a C6 update).
- Pinned the Rust toolchain to `nightly-2026-07-01`.
- `build-c6-slave.sh` stops with a clear message if ESP-IDF is not sourced.
- Browser flasher on GitHub Pages (`web/`): Helrig artwork, Vercel setup, docs generator and analytics removed; `brand/` deleted. `scripts/package-web.sh` finds the bootloader where esp-idf-sys now puts it.
- Docs rewritten for the fork: provenance, status, WSL2/Windows build, C6 co-processor notes.
- Verified on one board: cold build in about 60 s, flash with `espflash` 4.7.0 from Windows, C6 2.12.13, Wi-Fi scan and join, BLE advertising.
- Verified: the board flashed from the GitHub Pages flasher works.
- Verified with an HX Stomp: ToneStrand connects through the box over Wi-Fi, the test page passes and live editing works.
