# The setup page

`profile/setup.html` is one file of about 9 KB. It makes no network request, so it looks the same on the box's own network and on a home network.

## Look

Dark ground, light text, a teal accent (`#2ec4b6`) for actions and focus, the system font, and a plain "ToneStrand Box" wordmark. The Helrig logo and yellow of the original page were replaced.

## What it does

Lists the 2.4 GHz networks and joins one (up to three are saved), shows and forgets saved networks, and has a section to set a password for the box's own network. In direct mode it does not scan (a scan would drop the client that is using the box's own network) and says so; the Connect button is disabled there. Passwords go in plain HTTP, on whatever network you are on.

## Handing a box over

`scripts/flash.sh -p <port> --fresh` flashes the firmware and clears the saved settings, so the box starts as a blank ToneStrand Box.
