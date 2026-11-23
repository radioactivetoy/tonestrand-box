# Changelog

Changes since the fork from the [Helrig Box](https://github.com/maveric1977/helrig-box) (see [PROVENANCE.md](PROVENANCE.md)). Dates are 2026.

## 1.3.0 (23 Nov 2026): stable Rust

Numbered 1.3.0 because tags v1.0.0 to v1.2.0 came over from the Helrig Box history.

- Rust toolchain: stable `1.100.0` instead of `nightly-2026-07-01` (`scripts/build.sh` sets `RUSTC_BOOTSTRAP=1` for `build-std`).
- `esp-idf-sys` 0.36.1 → 0.38.1 (supports ESP-IDF 5.5, so the "not officially supported" build warning is gone), `embuild` 0.33.5 → 0.33.7.
- Verified on the test board with a local release build: clean boot, C6 2.12.13, joins Wi-Fi, Bluetooth MIDI advertises, web API answers, works with the pedal.

## 0.3.0 (18 Nov 2026): the first release

- Forked; ToneRelay imported into `firmware/` with its history; single repository, no submodule.
- Renamed the box: `ToneStrand Box`, `tonestrandbox`, `_tonestrandbox`; wordmark and accent colour on the setup page.
- Fix: the ESP32-C6 firmware is built and embedded by `scripts/build.sh` (empty Wi-Fi scan on the P4 board).
- Fix: Bluetooth MIDI starts the ESP-Hosted Bluetooth controller before NimBLE (BLE was dead after a C6 update).
- Pinned the Rust toolchain to `nightly-2026-07-01`.
- `build-c6-slave.sh` stops with a clear message if ESP-IDF is not sourced.
- Browser flasher on GitHub Pages (`web/`): Helrig artwork, Vercel setup, docs generator and analytics removed; `brand/` deleted. `scripts/package-web.sh` finds the bootloader where esp-idf-sys now puts it.
- New: direct mode (hold BOOT 2 to 4 s): own network on, no Wi-Fi joining until restart; reported as `direct` in `/api/relay`. Pairing press is now under 1.5 s. Published as `0.2.0-dev.direct` (a release build, the first on the flasher).
- Fix (found testing direct mode): the setup page scanned for Wi-Fi on load, which takes the radio off the box's own network for seconds, so the connection dropped and the box stopped answering. In direct mode the box no longer scans. New: a "Password for the box's own network" field on the setup page (the op existed, the page had no way to use it). Published as `0.2.1-dev.direct`.
- Verified: direct mode with a password, HX Stomp, test page and live editing over the box's own network.
- The flasher's faster speed options (added and removed the same day) stalled the flash on the test board and left it unbootable until reflashed over the cable; the page stays at 115200.
- Removed the 3D case files (the lid carried the Helrig mark); `hardware/README.md` points to the Helrig Box's files.
- Code review fixes: a press of BOOT held 1.5 to 5 s while a pairing window is open now confirms the pairing instead of starting direct mode; direct mode also wins over a join that was already under way (the join is let go again and the own network is not switched off). Known limitations are listed in `docs/status.md`.
- Fix: while someone is connected to the box's own network, the box no longer scans for a saved Wi-Fi network in the background (a scan takes the radio off the own network's channel and dropped the client every few seconds when the router was off). It looks again when the client leaves. First-time setup is not affected: with no saved network the background retries never run, and the setup page's own Scan and Connect always work.
- GitHub Actions: releases are built in the cloud (`release.yml`, on a tag), and the flasher page serves the firmware of the latest full release (`pages.yml`); `web/firmware` is no longer committed. Development stays local.
- Docs rewritten for the fork: provenance, status, WSL2/Windows build, C6 co-processor notes.
- Verified on one board: cold build in about 60 s, flash with `espflash` 4.7.0 from Windows, C6 2.12.13, Wi-Fi scan and join, BLE advertising.
- Verified: the board flashed from the GitHub Pages flasher works.
- Verified with an HX Stomp: ToneStrand connects through the box over Wi-Fi, the test page passes and live editing works.
