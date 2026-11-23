# ToneStrand Box

A small box that puts your Helix or HX pedal on Wi-Fi (and Bluetooth MIDI), so [ToneStrand](https://github.com/radioactivetoy/ToneStrand) can edit it without a cable to your computer. Where there is no Wi-Fi at all, it makes its own network and you edit over that.

> **This is a fork.** It starts from the [Helrig Box](https://github.com/maveric1977/helrig-box) by maveric1977 (Yashar Moradi), and its firmware is
> [ToneRelay](https://github.com/maveric1977/ToneRelay) by Mark Peskett and maveric1977. Almost all of the hard work is theirs.
> What we changed, and what is still theirs, is written down in [PROVENANCE.md](PROVENANCE.md). This project is not Helrig, is not made by
> Helrig, and is not endorsed by them.

The pedal plugs into the box by USB. The box joins your Wi-Fi, or makes its own network. ToneStrand finds it and edits the pedal as it would over a cable.
For editing, the box only passes the pedal's USB signal along; it never reads or changes your presets. It is also a Bluetooth MIDI device, so a setlist
app such as OnSong can change presets on the pedal.

Hardware: a [Waveshare ESP32-P4-NANO](https://www.waveshare.com/esp32-p4-nano.htm?sku=29026) (an ESP32-P4 that talks to the pedal over USB-A, plus an ESP32-C6
that does Wi-Fi and Bluetooth).

**Latest release: [0.3.0](https://github.com/radioactivetoy/tonestrand-box/releases/latest)** (the first). Install it from your browser at
**https://radioactivetoy.github.io/tonestrand-box/** (desktop Chrome or Edge, about 2 minutes), or with `espflash` ([flashing](docs/flashing.md)).

## What is different from the Helrig Box

| | Helrig Box | ToneStrand Box |
|---|---|---|
| Names | `Helrig Box xxxxxx`, `helrigbox.local` | `ToneStrand Box xxxxxx`, `tonestrandbox.local`, mDNS service `_tonestrandbox` |
| Wi-Fi scan on the P4 board | Empty list unless the C6 radio was flashed by hand | **Fixed**: `scripts/build.sh` builds and embeds the C6 firmware |
| Bluetooth MIDI after a C6 update | Dead (controller never started) | **Fixed**: the Bluetooth controller is started before NimBLE |
| No Wi-Fi available | Setup network only, for setup | **Direct mode**: hold BOOT 2 to 4 s and the box keeps its own network up (with a password you set) and stops looking for a router, for editing with none ([setup](docs/setup.md#direct-mode-no-wi-fi-at-all)) |
| Own network while a client is on it | Background scans for the router could drop the client | The box waits until the client leaves |
| Rust toolchain | Floating `nightly` (breaks with time) | **Pinned stable release** (`1.100.0`) |
| Build | macOS notes | macOS notes **plus Windows/WSL2**, one repository (no submodule) |
| Releases | Built on a maintainer's machine | Built by GitHub Actions on a tag; development is built locally |
| Editing client | Helrig | ToneStrand |
| Web flasher | box.helrig.com | [GitHub Pages](https://radioactivetoy.github.io/tonestrand-box/), no analytics |

Editing over Bluetooth is deferred: direct mode already covers "no router" at Wi-Fi speed. See [docs/status.md](docs/status.md).

## Status, honestly

Verified on one board with an HX Stomp and ToneStrand (18 Nov 2026): the firmware builds from a cold start and flashes (from the browser page and with `espflash`),
the C6 reports firmware 2.12.13, the Wi-Fi scan lists networks, the box joins Wi-Fi, ToneStrand finds and pairs it, the test page passes and live editing works, over
your Wi-Fi **and over the box's own network (direct mode, with a password)**, and ToneStrand follows the box between the two.

**Not tested:** Bluetooth MIDI from a phone, tablet or Mac (the box advertises; nothing has paired with it on this fork), other pedals than the HX Stomp, other boards.
Guides inherited from the Helrig Box and not yet repeated on this fork say so. There are also known security limitations (the box's Wi-Fi setup commands are not
protected by pairing, and the setup page uses plain HTTP): read [docs/status.md](docs/status.md) before relying on it.

## Get one running

1. **Get the parts.** The board, a USB-C cable that carries data, a USB-C power source, and the cable you use to connect your pedal to a computer.
   A 3D-printed case is optional (this repository has none; [where to get one](hardware/README.md)). [Full list](docs/flashing.md#what-you-need).
2. **Flash the firmware** from your browser at **https://radioactivetoy.github.io/tonestrand-box/**, or build it yourself with `scripts/build.sh` and flash it with `espflash`.
   [Flashing](docs/flashing.md) · [Build from source (Windows/WSL2, macOS, Linux)](docs/dev/build.md).
3. **Set it up.** Join the Wi-Fi network the box makes (`ToneStrand Box` plus six characters), open `http://192.168.4.1` and pick your home Wi-Fi. The same page lets
   you set a password for the box's own network. [Setup and factory reset](docs/setup.md).
4. **Use it.** Plug the pedal into the box's **USB-A** port, open ToneStrand and pick the box (it is found automatically). The first time, press **Pair** and then **BOOT** on the board once.
5. **No Wi-Fi where you play?** Hold **BOOT** for 2 to 4 seconds: the box raises its own network, you join it from the computer, and ToneStrand finds the box there. Unplug and replug the
   box to go back to your Wi-Fi. [Direct mode](docs/setup.md#direct-mode-no-wi-fi-at-all).
6. **Switch presets from a setlist app** over Bluetooth MIDI: [Bluetooth MIDI](docs/bluetooth-midi.md) (inherited, not yet tested on this fork).

The box works on 2.4 GHz Wi-Fi only and remembers up to three networks. Pairing does not encrypt the traffic, so use the box on a network you trust.

## Documentation

- [PROVENANCE.md](PROVENANCE.md): where the project comes from, who did what, what we changed
- [NOTICE.md](NOTICE.md): licences and credits for everything included
- [CHANGELOG.md](CHANGELOG.md): changes since the fork
- [docs/status.md](docs/status.md): what is tested, what is not, known limitations, what is planned
- [docs/flashing.md](docs/flashing.md) · [docs/setup.md](docs/setup.md) · [docs/bluetooth-midi.md](docs/bluetooth-midi.md)
- Developers: [architecture](docs/dev/architecture.md) · [build](docs/dev/build.md) · [the C6 co-processor](docs/dev/c6-coprocessor.md) · [releasing](docs/dev/releasing.md) · [measurements](docs/dev/measurements.md) · [setup page](docs/dev/setup-page.md)

## Licence

Code and docs are MIT ([LICENSE](LICENSE), copyright Yashar Moradi; the imported firmware in `firmware/` keeps its own MIT licence). The Helrig name and artwork are not ours and not covered; we removed them, and the 3D case files with them (see [NOTICE.md](NOTICE.md)). Not affiliated with Line 6 or Yamaha Guitar Group.
