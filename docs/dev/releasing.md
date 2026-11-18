# Releasing

The flasher is the static site in `web/`, published by GitHub Pages at **https://radioactivetoy.github.io/tonestrand-box/**. `.github/workflows/pages.yml` uploads `web/` as it is on every push to `main` that touches it (no build step). The firmware parts the page flashes are committed in `web/firmware/`.

## One-time setup

Repository Settings, Pages, Source: **GitHub Actions**. (Or: `gh api -X POST repos/radioactivetoy/tonestrand-box/pages -f build_type=workflow`.)

## Each release

1. Build a release image in WSL or Linux: `scripts/build.sh --release` ([build.md](build.md)).
2. Package it: `BOX_VERSION=0.1.0 scripts/package-web.sh --release`. This writes `web/firmware/{bootloader,partition-table,app}.bin` and `manifest.json` (parts with sizes and SHA-256; the page checks them before it writes anything). Without `BOX_VERSION` the version is `0.1.0-dev.<commit>`.
3. Try it locally: `cd web && python3 -m http.server 8765 --bind 127.0.0.1`, open `http://127.0.0.1:8765/` in Chrome or Edge and flash a board. Web Serial works on `localhost` and on https, not on plain http from another host.
4. Commit `web/firmware`, tag it (`git tag v0.1.0`) and push. Pages deploys. A tag named `vX.Y.Z` makes the page link to the GitHub release notes, so create the release too (`gh release create v0.1.0`).

The page writes the bootloader (0x2000), the partition table (0x8000) and the app (0x10000) only, so an update keeps the saved Wi-Fi network. "Start as a new box" also writes empty data over the settings area (0x9000, 0x6000 bytes).

## What the page does and does not do

It runs entirely in the browser with [esptool-js](https://github.com/espressif/esptool-js) (`web/vendor`, Apache-2.0). It sends nothing anywhere: no analytics, no cookies. (The inherited Helrig page used PostHog; that was removed.) The fonts in `web/fonts` are SIL OFL.
