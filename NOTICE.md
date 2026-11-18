# Notices

## Where this project comes from

ToneStrand Box is a fork of the [Helrig Box](https://github.com/maveric1977/helrig-box) (MIT, Copyright (c) 2026 Yashar Moradi), whose firmware is
ToneRelay. See [PROVENANCE.md](PROVENANCE.md) for who did what and what we changed. The root `LICENSE` is the Helrig Box's, unchanged.

## ToneRelay

The firmware in this product is [ToneRelay](https://github.com/maveric1977/ToneRelay) by Mark Peskett and maveric1977 (MIT licence, Copyright (c) 2026 the ToneRelay
authors), built with the profile in `profile/`. ToneRelay's source is included in `firmware/`, with its licence
file. The relay protocol the editor speaks is ToneRelay's `docs/raw-relay-protocol.md`. `firmware/vendor/tonepush` is [crmne/tonepush](https://github.com/crmne/tonepush) (MIT), bundled with ToneRelay. Our changes to ToneRelay are listed in PROVENANCE.md.

## The web flasher

`web/index.html` is derived from the Helrig Box's flasher page (MIT); the Helrig branding and the analytics it carried were removed.

`web/vendor/esptool-js.js` is [esptool-js](https://github.com/espressif/esptool-js) 0.7.0 (Apache-2.0, Copyright Espressif Systems; the licence is in
`web/vendor/LICENSE-esptool-js`). The file is Espressif's published bundle, unmodified, and it includes pako (MIT and Zlib) and atob-lite (MIT).

## The 3D-printable case

Not included. We removed the case files that came with the fork (they carried the Helrig mark); [hardware/README.md](hardware/README.md) points to the Helrig Box's files, which are an
adaptation of a [Waveshare ESP32-P4-NANO case and board model](https://www.printables.com/model/1497431-waveshare-esp32-p4-nano-case-and-board-model) by MartinFaustMayer
(@MartinFaustMa_212591) on Printables, licensed under [CC BY 4.0](https://creativecommons.org/licenses/by/4.0/). The files remain in this repository's git history, under that licence.

## Fonts

The web flasher and the docs use **Oxanium** (Copyright 2019 The Oxanium Project Authors) and **Geist Mono** (Copyright 2024 The Geist Project Authors), the fonts
the Helrig site uses, under the SIL Open Font License 1.1. `web/fonts/` holds their Latin subsets, as served on helrig.com, with the licence texts. The colours and font
choices in `web/site.css` follow helrig.com's dark theme.

## Helrig name and logo

"Helrig", "Helrig Box" and the Helrig logo and badge are Helrig's and are **not** covered by the MIT licence. We removed them from the software, the web flasher and the docs.
They remain only in this repository's git history (the fork's earlier commits).
Do not use them for another product.

## Line 6

ToneStrand Box is not affiliated (nor is the Helrig Box) with, authorized, endorsed or sponsored by Line 6 or Yamaha Guitar Group. "Line 6", "Helix",
"HX" and "HX Stomp" are trademarks of their respective owners and are used only to say which hardware the box works with.
