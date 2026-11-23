# Releasing

Development is built locally ([build.md](build.md)). **Releases are built by GitHub Actions**, so the published files come from a clean machine.

## Make a release

1. Update `CHANGELOG.md` and `docs/status.md`. Test the build you intend to release on a board (build locally with `scripts/build.sh --release` and flash it).
2. Tag and push: `git tag -a v0.4.0 -m "ToneStrand Box 0.4.0" && git push origin main v0.4.0`. A tag with a dash (`v0.4.0-rc1`) is published as a pre-release.
3. The **Release** workflow (`.github/workflows/release.yml`) installs ESP-IDF 5.5.3 and the pinned stable Rust (1.100.0), builds the firmware and the ESP32-C6 image with `scripts/build.sh --release`, packages it with `scripts/package-web.sh`, and publishes the release with: `tonestrand-box-web-firmware-<version>.zip` (what the flasher writes), `hxbridge-p4` and `partitions.csv` (for `espflash`). The first build takes a long time (about 30 to 60 minutes, ESP-IDF is installed); later ones reuse the cache.
4. It then starts the **Pages** workflow, which redeploys the flasher page with the firmware from the latest *full* release (pre-releases are not served by the page).

"Run workflow" on the Release workflow (without a tag) only builds, and attaches the files to the run: use it to try the pipeline.

The CI build is not bit-identical to a local one, so flash and test the released file at least once.

## The flasher page

`web/` is a static site published by `.github/workflows/pages.yml` at **https://radioactivetoy.github.io/tonestrand-box/**; `web/firmware/` is not committed (it is git-ignored). For a local try-out: `scripts/package-web.sh --release`, then `cd web && python3 -m http.server 8765 --bind 127.0.0.1` and open `http://127.0.0.1:8765/` in Chrome or Edge (Web Serial needs localhost or https).

The page writes the bootloader (0x2000), the partition table (0x8000) and the app (0x10000) only, so an update keeps the saved Wi-Fi network. "Start as a new box" also writes empty data over the settings area (0x9000, 0x6000 bytes). It checks each file's SHA-256 from `manifest.json` before it writes anything.

It runs entirely in the browser with [esptool-js](https://github.com/espressif/esptool-js) (`web/vendor`, Apache-2.0). It sends nothing anywhere: no analytics, no cookies. The fonts in `web/fonts` are SIL OFL.
