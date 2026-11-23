# Status: what is tested and what is not

Last updated 18 Nov 2026 (release 0.3.0). "Verified" means we did it on our board (one Waveshare ESP32-P4-NANO). "Inherited" means the Helrig Box project reports it and we have not repeated it on this fork.

## Verified on this fork

| What | Result |
|---|---|
| Cold build in WSL2 (Ubuntu, ESP-IDF 5.5.3, pinned stable Rust 1.100.0) | Works, about 60 s with warm downloads |
| Build of the ESP32-C6 firmware by `scripts/build.sh` | Works; rebuild from a clean tree reproduces a working image |
| Flash from Windows with `espflash` 4.7.0 (COM port) | Works |
| C6 co-processor firmware after boot | 2.12.13 (host side 2.12.0) |
| Wi-Fi scan | Lists networks (it was empty before the fix) |
| Join a home 2.4 GHz network | Works; the box answers on the LAN |
| Bluetooth LE | Advertises |
| Direct mode (BOOT held 2 to 4 s) with a secured own network (18 Nov 2026, 0.2.1) | Windows joins `ToneStrand Box e7f7c4` with the password, ToneStrand connects to the HX Stomp through the box, the test page passes and live editing works with no router. A first test (0.2.0) dropped the connection while the setup page was open, because it scanned for Wi-Fi; fixed in 0.2.1 |
| Setting the box's network password from the setup page | Works |
| Box's own network with the router off, held for several minutes of editing; box rejoins the router when the client leaves; setup page scan (0.3.0) | Works |
| ToneStrand follows the box between its Wi-Fi address and `192.168.4.1` | Works (seconds) |
| Faster flashing from the page (460800, 921600) | Fails: "serial data stream stopped", and the half-written board does not boot until it is flashed again. The page stays at 115200 (about 2 minutes); `espflash` over the cable takes about 3 minutes too |
| Flashing from the browser flasher on GitHub Pages (Chrome/Edge, COM port, 18 Nov 2026) | Works; the board then ran the page's firmware |
| HX Stomp plugged into the box, edited from ToneStrand over Wi-Fi (18 Nov 2026) | Connects, the test page passes, live editing works |
| ToneStrand finds and pairs the box by itself | Works (discovery can take several seconds) |

## Not tested yet

- Long editing sessions, and other pedals than the HX Stomp.
- Pairing a phone, iPad or Mac for Bluetooth MIDI, and sending MIDI to the pedal.
- An `httpd_uri handler execution failed` warning in the log: seen once, cause unknown.

## Inherited from the Helrig Box (not repeated here)

Helix LT and HX Stomp tested upstream; Bluetooth MIDI with an HX Stomp, an iPad, a Mac and an Android tablet; pairing by the BOOT button; three saved Wi-Fi networks; factory reset by holding BOOT 5 s. The measurements in [dev/measurements.md](dev/measurements.md) are upstream's.

## Not done yet

- A release build made by GitHub Actions has not been through the pipeline yet (0.3.0 was built locally and published by hand); see [dev/releasing.md](dev/releasing.md).

## Known limitations (read before relying on it)

Found in a code review of the changes and of the inherited firmware, 18 Nov 2026:

- **The box's Wi-Fi settings are not protected by pairing.** Pairing (the BOOT-button token) guards the pedal relay, but the setup commands (`wifi_join`, `wifi_forget`, `wifi_ap_password`, `wifi_scan` through `/api/cmd`) answer to anyone who can reach the box. On your home network, any device could change or forget the box's Wi-Fi or set the password of its own network. On the box's own network, an open network lets anyone nearby do the same until you set a password. This is how the Helrig Box and ToneRelay work. Use the box on networks you trust and set the password of its own network. Fixing it (asking for the pairing token, or a BOOT press, for these commands) is planned.
- **The setup page sends passwords in plain HTTP.** Both the home Wi-Fi password you type there and the box's own network password travel unencrypted on the network you are on.
- **No encryption of the editing traffic.** Same as upstream: pairing proves who may connect, it does not encrypt.
- **Bluetooth MIDI has no pairing window** (upstream): anyone in range can pair with the box. The link is encrypted once paired.
- **Faster flashing from the page stalls** on this board (see above); the page stays at 115200.

## Planned

1. Protect the Wi-Fi setup commands (join, forget, set the own-network password) with the pairing token or a BOOT press.
2. Test Bluetooth MIDI from a phone, iPad or Mac, and give it a pairing window (upstream has none).
3. Bluetooth editing is deferred: direct mode already covers "no router" at Wi-Fi speed. Wi-Fi Direct is not possible on ESP-IDF. If it is ever built: a BLE GATT service carrying the same raw relay, bonding and a BOOT pairing window, with Bluetooth MIDI kept through separate switches.
4. A ToneStrand Box case with our own mark; a status page and over-the-air updates; other pedals and boards.
