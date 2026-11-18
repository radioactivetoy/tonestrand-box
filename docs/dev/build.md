# Build the firmware yourself

For development, build locally (this page); releases are built by GitHub Actions ([releasing.md](releasing.md)). Most people should use the [browser flasher](../flashing.md) instead. What to buy and troubleshooting are in [flashing.md](../flashing.md).

## What you need

- **ESP-IDF v5.5.3** ([Espressif's install guide](https://docs.espressif.com/projects/esp-idf/en/v5.5.3/esp32p4/get-started/)), with its `export.sh` sourced in the shell you build from.
- **Rust** through `rustup`. `firmware/esp32-p4/rust-toolchain.toml` pins `nightly-2026-07-01` with `rust-src`; `rustup` installs it on the first build.
- **`ldproxy`** and **`espflash`**: `cargo install ldproxy espflash`.
- **`git`**, **Python 3**, and **libclang** (`export LIBCLANG_PATH=...`).

## Windows (WSL2, how we build it)

1. Install WSL2 with Ubuntu, then inside Ubuntu: `sudo apt install git wget flex bison gperf python3 python3-venv cmake ninja-build ccache libffi-dev libssl-dev dfu-util libusb-1.0-0 clang libclang-dev`.
2. Install ESP-IDF 5.5.3: `git clone -b v5.5.3 --recursive https://github.com/espressif/esp-idf.git ~/esp/esp-idf-v5.5.3 && ~/esp/esp-idf-v5.5.3/install.sh esp32p4,esp32c6`.
3. Install Rust: `curl https://sh.rustup.rs -sSf | sh`, then `cargo install ldproxy`.
4. Keep the repository **inside the Linux filesystem** (`~/box`), not under `/mnt/c`: the build is much slower and file modes break on the Windows drive.
5. Build as below. The cold build took about 60 s with downloads cached.
6. **Flash from Windows**, not from WSL: copy `hxbridge-p4` and `partitions.csv` to a Windows folder and run `espflash.exe` ([flashing](../flashing.md)). WSL does not see the COM port by default.

## macOS and Linux

Same steps with your package manager. On macOS with the command line tools: `export LIBCLANG_PATH=/Library/Developer/CommandLineTools/usr/lib`. `firmware/esp32-p4/.cargo/config.toml` sets a Linux path; the environment variable overrides it. Upstream built on macOS (Apple silicon); Linux is expected to work but see the WSL notes, which is what we ran.

## Build

```bash
git clone https://github.com/radioactivetoy/tonestrand-box.git
cd tonestrand-box
. ~/esp/esp-idf-v5.5.3/export.sh
export LIBCLANG_PATH=$(ls -d /usr/lib/llvm-*/lib | tail -1)   # Linux/WSL
scripts/build.sh                                              # or: scripts/build.sh --release
```

`scripts/build.sh`:

1. builds ToneRelay (`firmware/`) with this repository's `profile/` through `TONERELAY_PROFILE_DIR`, including the Bluetooth MIDI module;
2. if `firmware/esp32-p4/components/tonerelay/slave_fw/network_adapter.bin` (the ESP32-C6 firmware) is missing, builds it with `build-c6-slave.sh`, touches `sdkconfig.defaults` and builds again so it is embedded ([why](c6-coprocessor.md)).

To build without Bluetooth MIDI: `ESP_IDF_SDKCONFIG_DEFAULTS=sdkconfig.defaults scripts/build.sh`. The result is `firmware/esp32-p4/target/riscv32imafc-esp-espidf/debug/hxbridge-p4`.

## Flash

See [flashing.md](../flashing.md). On Linux/macOS: `scripts/flash.sh -p /dev/ttyACM0 --fresh` (`--fresh` clears saved settings; add `--release` if you built with it). Power-cycle afterwards.

Then follow [Setting up a ToneStrand Box](../setup.md).
