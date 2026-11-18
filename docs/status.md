# Status: what is tested and what is not

Last updated 18 Nov 2026. "Verified" means we did it on our board (one Waveshare ESP32-P4-NANO). "Inherited" means the Helrig Box project reports it and we have not repeated it on this fork.

## Verified on this fork

| What | Result |
|---|---|
| Cold build in WSL2 (Ubuntu, ESP-IDF 5.5.3, pinned Rust nightly) | Works, about 60 s with warm downloads |
| Build of the ESP32-C6 firmware by `scripts/build.sh` | Works; rebuild from a clean tree reproduces a working image |
| Flash from Windows with `espflash` 4.7.0 (COM port) | Works |
| C6 co-processor firmware after boot | 2.12.13 (host side 2.12.0) |
| Wi-Fi scan | Lists networks (it was empty before the fix) |
| Join a home 2.4 GHz network | Works; the box answers on the LAN |
| Bluetooth LE | Advertises |
| HX Stomp plugged into the box, edited from ToneStrand over Wi-Fi (18 Nov 2026) | Connects, the test page passes, live editing works |
| ToneStrand finds and pairs the box by itself | Works (discovery can take several seconds) |

## Not tested yet

- Long editing sessions, and other pedals than the HX Stomp.
- Pairing a phone, iPad or Mac for Bluetooth MIDI, and sending MIDI to the pedal.
- Editing through the box's own network (`192.168.4.1`) with no home Wi-Fi.
- The setup page's remaining behaviour on the renamed profile beyond loading it.
- An `httpd_uri handler execution failed` warning in the log: seen once, cause unknown.

## Inherited from the Helrig Box (not repeated here)

Helix LT and HX Stomp tested upstream; Bluetooth MIDI with an HX Stomp, an iPad, a Mac and an Android tablet; pairing by the BOOT button; three saved Wi-Fi networks; factory reset by holding BOOT 5 s. The measurements in [dev/measurements.md](dev/measurements.md) are upstream's.

## Not ours yet

- Release binaries and a release process: the browser flasher publishes a development build (`0.1.0-dev.<commit>`) and has not yet been run end to end on a board. Treat it as experimental.
- Pairing and discovery from ToneStrand: ToneStrand looks for `_helrigbox` and `_tonerelay` services; adding `_tonestrandbox` is planned. Until then add the box by its address.

## Planned

1. Test the box with a pedal and ToneStrand over Wi-Fi; test BLE MIDI from a phone/iPad; test the box's own network.
2. Bluetooth editing: a BLE GATT service that carries the same raw relay as the Wi-Fi socket, plus a client in ToneStrand. Wi-Fi Direct is not possible on ESP-IDF (it does not support it), so the options for "no Wi-Fi" are the box's own network and BLE. Bluetooth MIDI stays an option, through separate switches.
3. Security for Bluetooth: bonding plus a BOOT-button pairing window (upstream has none for BLE MIDI).
4. Version string and status page; over-the-air updates; replace the remaining Helrig branding.
