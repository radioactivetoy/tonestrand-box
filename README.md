# ToneStrand Box

A small box that puts your Helix or HX pedal on Wi-Fi (and Bluetooth MIDI), so [ToneStrand](https://github.com/radioactivetoy/ToneStrand) can edit it without a cable to your computer.

> **This is a fork.** It starts from the [Helrig Box](https://github.com/maveric1977/helrig-box) by maveric1977 (Yashar Moradi), and its firmware is
> [ToneRelay](https://github.com/maveric1977/ToneRelay) by Mark Peskett and maveric1977. Almost all of the hard work is theirs.
> What we changed, and what is still theirs, is written down in [PROVENANCE.md](PROVENANCE.md). This project is not Helrig, is not made by
> Helrig, and is not endorsed by them.

The pedal plugs into the box by USB. The box joins your Wi-Fi (or makes its own network). ToneStrand finds it and edits the pedal as it would over a cable.
For editing, the box only passes the pedal's USB signal along; it never reads or changes your presets. It is also a Bluetooth MIDI device, so a setlist
app such as OnSong can change presets on the pedal.

Hardware: a [Waveshare ESP32-P4-NANO](https://www.waveshare.com/esp32-p4-nano.htm?sku=29026) (an ESP32-P4 that talks to the pedal over USB-A, plus an ESP32-C6
that does Wi-Fi and Bluetooth).

## What is different from the Helrig Box

| | Helrig Box | ToneStrand Box |
|---|---|---|
| Names | `Helrig Box xxxxxx`, `helrigbox.local` | `ToneStrand Box xxxxxx`, `tonestrandbox.local`, mDNS service `_tonestrandbox` |
| Wi-Fi scan on the P4 board | Empty list unless the C6 radio was flashed by hand | **Fixed**: `scripts/build.sh` builds and embeds the C6 firmware |
| Bluetooth MIDI after a C6 update | Dead (controller never started) | **Fixed**: the Bluetooth controller is started before NimBLE |
| Rust toolchain | Floating `nightly` (breaks with time) | **Pinned** (`nightly-2026-07-01`) |
| Build | macOS notes | macOS notes **plus Windows/WSL2**, one repository (no submodule) |
| Editing client | Helrig | ToneStrand |
| Web flasher | box.helrig.com | [GitHub Pages](https://radioactivetoy.github.io/tonestrand-box/) (experimental), or `espflash` ([flashing](docs/flashing.md)) |

Planned, not done: editing over Bluetooth (no Wi-Fi needed). See [docs/status.md](docs/status.md).

## Status, honestly

Tested on one board: the firmware builds from a cold start, flashes, boots, the C6 reports firmware 2.12.13, the Wi-Fi scan lists networks, the box joins
Wi-Fi, and Bluetooth LE advertises. **Not yet tested with a pedal plugged in, with a phone or tablet paired over Bluetooth MIDI, or from the box's own
network.** Guides inherited from the Helrig Box and not yet repeated on this fork say so. Read [docs/status.md](docs/status.md) before relying on it.

## Get one running

1. **Get the parts.** The board, a USB-C cable that carries data, a USB-C power source, and the cable you use to connect your pedal to a computer.
   A [3D-printable case](hardware/casing/README.md) is optional. [Full list](docs/flashing.md#what-you-need).
2. **Flash the firmware** from your browser (desktop Chrome or Edge) at **https://radioactivetoy.github.io/tonestrand-box/**, or build it yourself with `scripts/build.sh` and flash it with `espflash`. [Flashing](docs/flashing.md) · [Build from source (Windows/WSL2, macOS, Linux)](docs/dev/build.md).
3. **Set it up.** Join the Wi-Fi network the box makes (`ToneStrand Box` plus six characters), open `http://192.168.4.1` and pick your home Wi-Fi.
   [Setup and factory reset](docs/setup.md).
4. **Use it.** Plug the pedal into the box's **USB-A** port, open ToneStrand and pick the box. Pairing is by pressing **BOOT** on the board once.
5. **Switch presets from a setlist app** over Bluetooth MIDI: [Bluetooth MIDI](docs/bluetooth-midi.md).

The box works on 2.4 GHz Wi-Fi only and remembers up to three networks. Pairing does not encrypt the traffic, so use it on a network you trust.

## Documentation

- [PROVENANCE.md](PROVENANCE.md): where the project comes from, who did what, what we changed
- [NOTICE.md](NOTICE.md): licences and credits for everything included
- [CHANGELOG.md](CHANGELOG.md): changes since the fork
- [docs/status.md](docs/status.md): what is tested, what is not, what is planned
- [docs/flashing.md](docs/flashing.md) · [docs/setup.md](docs/setup.md) · [docs/bluetooth-midi.md](docs/bluetooth-midi.md)
- Developers: [architecture](docs/dev/architecture.md) · [build](docs/dev/build.md) · [the C6 co-processor](docs/dev/c6-coprocessor.md) · [releasing](docs/dev/releasing.md) · [measurements](docs/dev/measurements.md) · [setup page](docs/dev/setup-page.md)

## Licence

Code and docs are MIT ([LICENSE](LICENSE), copyright Yashar Moradi; the imported firmware in `firmware/` keeps its own MIT licence). The 3D case is
CC BY 4.0. The Helrig name and artwork are not ours and not covered (we removed them from the software; see [NOTICE.md](NOTICE.md) for what remains in the case files). Not affiliated with Line 6 or Yamaha Guitar Group.
