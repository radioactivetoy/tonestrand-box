# How this repository is put together

ToneStrand Box is a fork of the [Helrig Box](https://github.com/maveric1977/helrig-box); the firmware is [ToneRelay](https://github.com/maveric1977/ToneRelay) by Mark Peskett and maveric1977. See [PROVENANCE.md](../../PROVENANCE.md). What makes a ToneRelay build a ToneStrand Box is a small **profile** (`profile/`): the names the box shows (`ToneStrand Box e7fb0b`, `tonestrandbox.local`, `_tonestrandbox`), the setup page, and the defaults (relay-only on). The relay, the USB handling and the Wi-Fi code are ToneRelay's.

For editing, the box carries the pedal's USB transfers and does not interpret them; the editor (ToneStrand) is the only thing that speaks the pedal's protocol. The contract is `firmware/docs/raw-relay-protocol.md`: a `/raw` WebSocket with a bearer token, one client at a time, 512-byte messages, plus `/api/relay` and `/api/cmd`. For Bluetooth MIDI the box receives MIDI over Bluetooth LE (NimBLE) and sends it to the pedal's USB MIDI interface; see the [Bluetooth MIDI guide](../bluetooth-midi.md).

Hardware: ESP32-P4 (USB host, application) plus ESP32-C6 (Wi-Fi/Bluetooth over SDIO with ESP-Hosted): [c6-coprocessor.md](c6-coprocessor.md).

| Path | What it is |
|---|---|
| `firmware/` | ToneRelay (MIT), imported with its history, carrying our fixes: `esp32-p4/` is the P4 firmware, `esp32-p4/components/tonerelay/midi_ble.c` the Bluetooth MIDI module, `vendor/tonepush` the Helix protocol crates. |
| `profile/profile.c` | The box's names and defaults. |
| `profile/setup.html` | The setup and status page the box serves (no network requests, wordmark inline). |
| `scripts/build.sh`, `scripts/flash.sh` | Build with this profile (and the C6 image); flash, optionally clearing the saved settings. |
| `scripts/package-web.sh` | Split the build into the parts the web flasher writes (`web/firmware/`). |
| `hardware/` | Only a pointer to the Helrig Box's case files: see [hardware/README.md](../../hardware/README.md). |
| `web/` | The browser flasher (one page, `index.html`, with esptool-js and the firmware parts in `web/firmware/`), published by GitHub Pages: see [releasing](releasing.md). Derived from the Helrig Box's flasher; its Helrig artwork, docs generator, Vercel setup and analytics were removed. |

See also: [build](build.md), [releasing](releasing.md), [setup page](setup-page.md), [measurements](measurements.md).
