# Releasing

There is no release process for this fork yet: no web flasher is deployed and no binaries are published. To share a build, run `scripts/build.sh --release` and publish `firmware/esp32-p4/target/riscv32imafc-esp-espidf/release/hxbridge-p4` together with `firmware/esp32-p4/partitions.csv` and the `espflash` command from [flashing.md](../flashing.md).

## Inherited web flasher (not used)

The Helrig Box releases a browser flasher at box.helrig.com: `web/` is a static site built by Vercel (`scripts/package-web.sh --release` writes the bootloader, partition table and app parts; `web/fetch-firmware.sh` downloads them from a GitHub release; `web/build-docs.mjs` turns the docs into pages). That site, its domain and its Vercel project belong to the Helrig project, and `web/` still carries their branding. If we ever publish our own flasher it needs our own domain, project, branding and a review of these files. Writing addresses used by that flasher: bootloader 0x2000, partition table 0x8000, app 0x10000; "start as a new box" also zeroes the settings area at 0x9000 (0x6000 bytes).
