# Install the firmware

> There is no web flasher for ToneStrand Box yet (the one at box.helrig.com belongs to the Helrig project and flashes Helrig's build). Build the firmware yourself ([build guide](dev/build.md), it takes a few minutes) and flash it with `espflash`.

## What you need

| Part | Notes |
|---|---|
| **[Waveshare ESP32-P4-NANO](https://www.waveshare.com/esp32-p4-nano.htm?sku=29026)** ([wiki](https://www.waveshare.com/wiki/ESP32-P4-NANO)) | The board this firmware is built and tested on. Its main chip, an ESP32-P4, talks to the pedal through the **USB-A** port. A second chip, an ESP32-C6, does Wi-Fi and Bluetooth ([details](dev/c6-coprocessor.md)). Order the **Basic Kit**; the camera, PoE and display kits are not used. |
| **A USB-C cable that carries data** | For power and flashing. A charge-only cable will not show a serial device. |
| **A USB-C power source** | A 5 V phone charger or a computer port. |
| **The pedal's USB cable** | The end that goes into the box must be USB-A, the box's pedal port. |
| **A case** (optional) | A 3D-printable [lid and bottom](../hardware/casing/README.md). |

Upstream tried a Helix LT and an HX Stomp; we have an HX Stomp. Other pedals and other ESP32-P4 boards are untested. Wi-Fi is **2.4 GHz only**.

You also need [ToneStrand](https://github.com/radioactivetoy/ToneStrand) on your computer to edit the pedal. Bluetooth MIDI does not use it.

## Flash with espflash

1. Build the firmware: see [build.md](dev/build.md). The result is the file `hxbridge-p4` plus the partition table `firmware/esp32-p4/partitions.csv`.
2. Connect the board's **UART USB-C** port to your computer and find the port (a COM port on Windows, `/dev/ttyACM0` on Linux, `/dev/cu.usbmodem...` on macOS).
3. Flash (the partition table is needed, otherwise the layout is wrong and the catalog partition is not created):

```bash
espflash flash -p COM5 --chip esp32p4 --partition-table partitions.csv --partition-table-offset 0x8000 hxbridge-p4
```

On Linux or macOS from the repository, `scripts/flash.sh -p <port>` does the same; add `--fresh` to also clear the saved Wi-Fi networks and pairings. Install espflash with `cargo install espflash` (or download the release for Windows). We used 4.7.0.

4. Power-cycle the board, then continue with [Setting up a ToneStrand Box](setup.md).

Flashing over a box you already set up keeps its Wi-Fi networks and pairings, unless you use `--fresh`.

## Drivers

None to install in the cases seen upstream (macOS, Windows 11, Ubuntu): the board is a standard USB serial device. On Linux your user must be in the `dialout` group (`sudo usermod -aG dialout $USER`, then log out and in). On Windows with WSL2, flash from Windows (`espflash.exe`) because WSL does not see the COM port without extra tools.

## Troubleshooting

- **espflash cannot connect.** Unplug and replug the board. If that does not help, hold **BOOT**, tap **RESET**, release **BOOT**, and run the command again. Close any other program using the port.
- **No port.** Try another cable (it must carry data) and use the **UART USB-C** port, not the USB-A one.
- **The setup network does not appear.** Wait about 10 seconds after power-up. Phones can also keep an old list for a few minutes.
- **The Wi-Fi scan list is empty.** The C6 may have the wrong firmware; see [the C6 notes](dev/c6-coprocessor.md).
- **ToneStrand does not find the pedal.** Replug the pedal's USB cable; if it is still stuck, unplug its 9 V power for a moment.
- **Do not hold BOOT while the board powers up.** That starts the chip's download mode instead of the firmware.
- **The iPad or Mac lists the box but will not connect (Bluetooth MIDI).** See [Bluetooth MIDI](bluetooth-midi.md#if-the-ipad-lists-the-box-but-will-not-connect).
