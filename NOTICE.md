# Notices

## Where this project comes from

ToneStrand Box is a fork of the [Helrig Box](https://github.com/maveric1977/helrig-box) (MIT, Copyright (c) 2026 Yashar Moradi), whose firmware is
ToneRelay. See [PROVENANCE.md](PROVENANCE.md) for who did what and what we changed. The root `LICENSE` is the Helrig Box's, unchanged.

## ToneRelay

The firmware in this product is [ToneRelay](https://github.com/maveric1977/ToneRelay) by Mark Peskett and maveric1977 (MIT licence, Copyright (c) 2026 the ToneRelay
authors), built with the profile in `profile/`. ToneRelay's source is included in `firmware/`, with its licence
file. The relay protocol the editor speaks is ToneRelay's `docs/raw-relay-protocol.md`. `firmware/vendor/tonepush` is [crmne/tonepush](https://github.com/crmne/tonepush) (MIT), bundled with ToneRelay. Our changes to ToneRelay are listed in PROVENANCE.md.

## The web flasher (inherited, not used)

`web/vendor/esptool-js.js` is [esptool-js](https://github.com/espressif/esptool-js) 0.7.0 (Apache-2.0, Copyright Espressif Systems; the licence is in
`web/vendor/LICENSE-esptool-js`). The file is Espressif's published bundle, unmodified, and it includes pako (MIT and Zlib) and atob-lite (MIT).

## The 3D-printable case

The files in `hardware/casing/` are an adaptation of the [Waveshare ESP32-P4-NANO case and board model](https://www.printables.com/model/1497431-waveshare-esp32-p4-nano-case-and-board-model)
by MartinFaustMayer (@MartinFaustMa_212591) on Printables, licensed under [CC BY 4.0](https://creativecommons.org/licenses/by/4.0/), and are shared under the same licence, not under
this repository's MIT licence. `hardware/casing/ATTRIBUTION.md` has the credit and the list of changes; keep it with the files if you share them. The Helrig symbol and wordmark
debossed in the lid files are Helrig's (see "Helrig name and logo" below) and will be replaced: the licence covers the model, not the Helrig name or logo.

## Fonts

The web flasher and the docs use **Oxanium** (Copyright 2019 The Oxanium Project Authors) and **Geist Mono** (Copyright 2024 The Geist Project Authors), the fonts
the Helrig site uses, under the SIL Open Font License 1.1. `web/fonts/` holds their Latin subsets, as served on helrig.com, with the licence texts. The colours and font
choices in `web/site.css` follow helrig.com's dark theme.

## Helrig name and logo

"Helrig", "Helrig Box" and the Helrig logo and badge (the files in `brand/`, the diagrams, `web/` and the logo in the case files) are Helrig's and are
**not** covered by the MIT licence. They are in this repository only because it is a fork and have not been removed yet. ToneStrand Box does not use them as its identity,
and you must not use them for another product. They will be replaced or removed.

## Line 6

ToneStrand Box is not affiliated (nor is the Helrig Box) with, authorized, endorsed or sponsored by Line 6 or Yamaha Guitar Group. "Line 6", "Helix",
"HX" and "HX Stomp" are trademarks of their respective owners and are used only to say which hardware the box works with.
