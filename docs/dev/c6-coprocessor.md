# The ESP32-C6 co-processor

The ESP32-P4 has no radio. On the Waveshare ESP32-P4-NANO an **ESP32-C6-MINI-1** provides Wi-Fi 6 and Bluetooth 5, connected over SDIO (CLK 18, CMD 19, D0 to D3 14 to 17, RESET 54). The P4 talks to it with **ESP-Hosted** (host version 2.12.0 here).

## What went wrong in the Helrig Box

1. **Empty Wi-Fi scan.** The C6 must run Espressif's ESP-Hosted slave firmware (`network_adapter`). ToneRelay has a script to build it (`firmware/esp32-p4/build-c6-slave.sh`) and expects the result at `components/tonerelay/slave_fw/network_adapter.bin`, but the file was not in the repository and the normal build never made it. A board whose C6 held another version could not scan.
2. **Bluetooth dead after the C6 was updated.** With ESP-Hosted 2.12 the host has to call `esp_hosted_bt_controller_init()` and `esp_hosted_bt_controller_enable()` before `nimble_port_init()`. `midi_ble.c` did not.

## What we do now

- `scripts/build.sh` builds the P4 firmware, and if `slave_fw/network_adapter.bin` is missing it runs `build-c6-slave.sh` (ESP-IDF must be sourced), then rebuilds so the image is embedded. The image is git-ignored, so each clone builds its own.
- At boot the P4 compares the C6's version with the embedded image and updates the C6 over SDIO when they differ (seen in the log: C6 2.12.13).
- `midi_ble.c` starts the Bluetooth controller before NimBLE.

## Checking it

The serial log (115200, the board's UART USB-C port) shows the C6 version during start-up, then the Wi-Fi scan results. A scan list with your networks means the C6 is running the right firmware. If the list is empty, delete `slave_fw/network_adapter.bin` and run `scripts/build.sh` again.

Only 2.4 GHz networks appear: this C6 radio does not do 5 GHz.
