# Where this project comes from

ToneStrand Box is a **fork**. We did not start from nothing, and we want that to be clear to anyone reading this repository.

## The chain

1. **ToneRelay** (Aug 2026): a Rust + ESP-IDF firmware that turns a Raspberry Pi, and later an ESP32-P4 board, into a Wi-Fi relay for Line 6 Helix pedals.
   Written by **Mark Peskett** (GitHub `mpeskett88`) with **maveric1977** (Yashar Moradi). MIT licence, "Copyright (c) 2026 the ToneRelay authors".
   Upstream: <https://github.com/maveric1977/ToneRelay> (earlier at `mpeskett88/ToneRelay`).
2. **Helrig Box** (2026): a ready-to-build product around ToneRelay for the Waveshare ESP32-P4-NANO: a profile (names, setup page, defaults), a web flasher,
   docs, a 3D-printable case and branding, for the editor Helrig. By **maveric1977** (Yashar Moradi). MIT licence for the code and docs.
   Upstream: <https://github.com/maveric1977/helrig-box>.
3. **ToneStrand Box** (Nov 2026, this repository): a fork of the Helrig Box by **radioactivetoy**, to work with the editor
   [ToneStrand](https://github.com/radioactivetoy/ToneStrand), to fix problems we hit on the board, and to add things (see below).

The history of both upstream projects is kept in this repository (`git log`): about 100 commits are by Yashar Moradi / maveric1977 and Mark Peskett. Our
commits are the ones by `radioactivetoy`. ToneRelay was imported into `firmware/` with its history, not copied as a snapshot.

## What is theirs

- All of the firmware: the relay, the USB host code for the pedal, the Wi-Fi/SoftAP/mDNS handling, the BLE MIDI module, the protocol. (`firmware/`, MIT.)
- The idea and design of the box, the profile mechanism, the setup page's structure, the pairing-by-BOOT-button design, the guides and the measurements in `docs/`.
- The web flasher in `web/` and the artwork in `brand/` (not ours to reuse, see [NOTICE.md](NOTICE.md)).
- The hardware case adaptation, itself an adaptation of a CC BY 4.0 model by MartinFaustMayer (see [hardware/casing/ATTRIBUTION.md](hardware/casing/ATTRIBUTION.md)).
- `firmware/vendor/tonepush`: protocol crates from [crmne/tonepush](https://github.com/crmne/tonepush) (MIT), bundled with ToneRelay.

## What we changed

- **Names.** The box presents itself as `ToneStrand Box`, `tonestrandbox.local`, service `_tonestrandbox`; the setup page shows a wordmark instead of the Helrig logo and a different accent colour. (`profile/`)
- **Empty Wi-Fi scan on the ESP32-P4-NANO.** The firmware the ESP32-C6 needs (ESP-Hosted `network_adapter`) was not part of the build, so a board whose C6 had an older image
  could scan nothing. ToneRelay already had the script that builds that C6 image (`firmware/esp32-p4/build-c6-slave.sh`, from Espressif's ESP-Hosted example), but nothing ran it. `scripts/build.sh` now runs it when the image is missing and embeds it, and the P4 updates the C6 on boot. We also made the script fail with a clear message when ESP-IDF is not sourced. See [docs/dev/c6-coprocessor.md](docs/dev/c6-coprocessor.md).
- **Bluetooth MIDI dead after a C6 update.** With ESP-Hosted 2.12 the Bluetooth controller has to be started explicitly before NimBLE; `midi_ble.c` now calls
  `esp_hosted_bt_controller_init()` and `esp_hosted_bt_controller_enable()`.
- **Toolchain pin.** `firmware/esp32-p4/rust-toolchain.toml` pins `nightly-2026-07-01` so the build does not break when `nightly` moves.
- **One repository.** ToneRelay lives in `firmware/` (no submodule, no second fork to keep in step), and the scripts and docs look there.
- **Documentation** for building on Windows with WSL2, flashing with `espflash`, and an honest account of what has and has not been tested.

Everything else is unchanged and still theirs. If you only want the original, use the originals; if a fix here is useful to them, it is MIT and theirs to take.

## What we did not do

- We did not ask for, and do not have, permission to use the **Helrig** name or logo. This product does not use them as its identity. A few files inherited from the fork still
  contain them (`brand/`, the debossed lid in the case files, `web/`); they are marked in [NOTICE.md](NOTICE.md) and are being replaced or removed.
- The **web flasher** at box.helrig.com belongs to the Helrig project. Firmware built here is not published there.
- We have not been endorsed by Helrig, Mark Peskett, MartinFaustMayer, Line 6 or Yamaha Guitar Group.

## Keeping up with upstream

`firmware/` was imported with `git merge -s ours` followed by `read-tree --prefix=firmware/`, so upstream ToneRelay changes can be brought in with:

```bash
git remote add toneRelay https://github.com/maveric1977/ToneRelay.git
git fetch toneRelay
git merge -X subtree=firmware toneRelay/main
```

Check for conflicts in `midi_ble.c`, `build-c6-slave.sh` and `rust-toolchain.toml`, which we changed.
