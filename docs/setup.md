> **Status:** inherited from the Helrig Box guide (see [PROVENANCE](../PROVENANCE.md)) and renamed. Not yet repeated on this fork with a pedal and ToneStrand: see [status](status.md).

# Setting up a ToneStrand Box

You need a box with the [firmware installed](flashing.md).

## Setting up a new box

1. Plug the box in. It starts its own Wi-Fi network called `ToneStrand Box` plus six characters, for example `ToneStrand Box 3fa9c1`. The same six characters show after "ToneStrand Box" in ToneStrand.
2. On your phone, join that network and open `http://192.168.4.1`. The page lists the Wi-Fi networks the box can see. Only 2.4 GHz networks show up.
3. Pick yours, type the password, and press **Connect**. The page says when the box is on your network and shows its address.
4. Open ToneStrand, plug your pedal into the box, and choose the box in the device menu. ToneStrand finds boxes that announce `_helrigbox` or `_tonerelay`; discovery of `_tonestrandbox` is planned, so for now you may need to add the box by its address (see [status](status.md)).
5. The first time, ToneStrand says the box **needs pairing**. Do the steps under [Pairing](#pairing) below. 

About 45 seconds after the box joins your Wi-Fi, it switches its own network off. Your phone may keep showing the name for a few minutes. That is your phone's old list, not the box.

If the box can't join any saved network for 40 seconds (a new router, say), its own network comes back. Repeat steps 2 and 3.

While the box is on your Wi-Fi, the same page is at the box's address, and you can add another network there.

## Pairing

Pairing tells the box which computers and tablets it should trust. A device that hasn't paired can't use your pedal through the box, even if it's on your Wi-Fi. Pairing means pressing a button on the board, so only someone standing at the box can do it.

1. In ToneStrand, choose the box. If it says **Needs pairing**, press **Pair**.
2. Within 30 seconds of pressing Pair, press the **BOOT** button on the board once and let go. Don't hold it. Holding it for 5 seconds is a [factory reset](#factory-reset).
3. ToneStrand remembers the pairing on that device, so you do this once per device, unless you reset the box.

Pair each computer or tablet you use, once. If ToneStrand says the box didn't accept the saved pairing, press **Pair** again. If it says another device is pairing, wait a minute. The box handles one pairing at a time.

This is pairing for ToneStrand. Bluetooth MIDI pairs separately, in the Bluetooth list of your iPad or Mac: see [Bluetooth MIDI](bluetooth-midi.md).

Pairing does not encrypt the traffic between the box and your computer, so use the box on a network you trust, like your home or your rehearsal room. See [Safety](#safety).

## Direct mode: no Wi-Fi at all

To edit where there is no Wi-Fi (a stage, a rehearsal room without a router), put the box in **direct mode**: **hold BOOT for 2 to 4 seconds and let go** (the board has no light, so count). The box raises its own network, `ToneStrand Box` plus six characters, at `192.168.4.1`, and stops joining Wi-Fi. Join that network from your computer and add the box in ToneStrand by the address `192.168.4.1` (automatic discovery may not work there). ToneStrand shows "Direct mode" in the box details, and the box reports `"direct":true` at `http://192.168.4.1/api/relay`.

- Direct mode lasts until the box restarts: unplug it and plug it in again to go back to your Wi-Fi. Nothing is erased, so pairings and saved networks stay.
- Choosing a network on the setup page (while connected to the box's network) also ends direct mode.
- A press shorter than 1.5 seconds still confirms pairing (while a pairing window is open, a press up to 5 seconds confirms it, so a slow press cannot knock the box off your network), and holding for 5 seconds is still a factory reset. This timing is a ToneStrand Box change; in the Helrig Box a press up to 5 seconds confirmed pairing.
- **Set a password for the box's network first**: the setup page has a "Password for the box's own network" section (8 to 63 characters; the box's network restarts, so join it again with the password). Until you do, the network is open and the editing traffic is not encrypted, so anyone nearby could join it.
- In direct mode the setup page does not scan for Wi-Fi (a scan would drop your connection), so its network list is empty; plug the box out and in to choose a network.
- Your computer loses internet while it is on the box's network.

## Several Wi-Fi networks

The box remembers up to three Wi-Fi networks, for example home, the rehearsal room and your phone's hotspot. Add each one from the same setup page you used for the first. If the box is on a network now, the page is at the box's address. If it has no network to join, use the box's own setup network.

- When the box starts, it joins the network it used last, if that one is in range. If not, it picks the strongest saved network it can see. A network that just failed goes to the back of the line.
- The page lists your saved networks, names only, never passwords. **Forget** removes one.
- Save a fourth and it replaces the one the box joined longest ago.
- **Phone hotspot:** the box only does 2.4 GHz, so switch on your hotspot's compatibility option. On an iPhone it is called Maximize Compatibility.
- When the box moves to a different network, your phone is no longer on the same Wi-Fi, so the setup page can't reach it any more. The page tells you after a few seconds. Put your phone on the box's new network and open ToneStrand. Add it again by its address if it is not found.

## Factory reset

(Hold BOOT for 5 seconds. A shorter hold of 2 to 4 seconds is [direct mode](#direct-mode-no-wi-fi-at-all) instead.) To wipe the box and start over, hold the **BOOT** button on the board for 5 seconds while the box is running. It forgets every Wi-Fi network, the password of its own setup network, its pairing token (the key that proves a device is paired) and every Bluetooth pairing. Then it restarts and brings back its setup network. It is still a ToneStrand Box, and every device has to pair again. Your iPad or Mac keeps its side of a Bluetooth pairing, so forget the box there before you connect again. On an iPad, forget it in the Bluetooth MIDI list and in Settings, Bluetooth. See [Bluetooth MIDI](bluetooth-midi.md).

Do not hold BOOT while you plug the power in. That starts the chip's download mode instead of the firmware.

The board has only a power light, so nothing blinks. About 5 seconds after the restart, the setup network reappears. That is how you know it worked.

## Safety

Pairing stops other devices on your Wi-Fi from using the pedal through the box. It does not encrypt the traffic between the box and your computer, so use the box on a network you trust, like your home or your rehearsal room.

Bluetooth MIDI is separate. Anyone within Bluetooth range can pair with the box, because there is no pairing window yet. Once paired, the link is encrypted.
