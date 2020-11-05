# How to install a genuine MacBook WLAN card on any laptop (BCM94360CS2 on T460s)

I decided to go for a genuine WLAN card used in Apple's computer because it works plug-and-play on any Hackintosh.

A list of other compatible cards can be found [here](https://dortania.github.io/Wireless-Buyers-Guide/)

## Parts and tools required

- BCM94360CS2 ($10 used)
<img src="/Images/wlan-card.jpg" height="300">

- BCM94360CS2 (M.2) to NGFF adapter ($5 new)
<img src="/Images/wlan-adapter.jpg" height="300">

- Phillips screwdriver 

## Installation

0. Open BIOS Setup and turn off internal batteries
`Config -> Power -> Disable Built-in Battery` **Enter**

1. Open the back plate
<img src="/Images/wlan-install-01.jpeg" height="300">

2. Disconnect antennas cables
<img src="/Images/wlan-install-02.jpeg" height="300">

3. Remove the original WLAN card
<img src="/Images/wlan-install-03.jpeg" height="300">

4. (optional) Cut adapter corner and widen screw hole as shown to save 1mm in height
<img src="/Images/wlan-install-04.jpeg" height="300">

5. Insert the adapter on the board
<img src="/Images/wlan-install-05.jpeg" height="300">

6. Install BCM94360CS2
<img src="/Images/wlan-install-06.jpeg" height="300">

7. Connect antennas cables (as shown)
<img src="/Images/wlan-install-07.jpeg" height="300">

8. Close the back plate and enjoy your wireless life

## The bottom line
### That's a small issue for a laptop,
> Due to adapter's height the back plate will have a small bump, resulting in a (very) small gap on the laptop's right bottom side
<img src="/Images/wlan-install-08.jpeg" height="300">

### One giant leap for your life
All [Continuity features](https://support.apple.com/en-us/HT204681) will work with **no extra kexts nor patches**:
- [x] Handoff
- [x] Universal Clipboard
- [x] iPhone Cellular Calls
- [x] Text Message Forwarding
- [x] Instant Hotspot
- [x] Auto Unlock
- [x] Continuity Camera
- [x] Continuity Sketch
- [x] Continuity Markup
- [x] Sidecar
- [x] AirDrop
- [x] Apple Pay