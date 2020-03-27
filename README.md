# Thinkpad T460s macOS Catalina (OpenCore bootloader)

> First ever OpenCore build for T460s, everything but SD card reader works 

## Introduction

My Thinkpad T460s (20F9003AUS) specs

- Processor: Intel Core i7-6600U (2C, 2.6 / 3.4GHz, 4MB)vPro
- Graphics: Integrated Intel HD Graphics 520
- Memory: 4GB Soldered + 4GB DIMM
- Display: 14" WQHD (2560x1440) IPS
- Sound Card: Realtek ALC293
- Multi-touch: None
- Storage: 256GB SSD M.2 Opal2
- Optical: None
- WLAN + Bluetooth: ~~Intel 8260 ac, 2x2 + BT4.1~~ **replaced by BCM94360CS2 with NGFF adapter**
- WWAN: WWAN Upgradable (Legacy_Sierra_QMI.kext needed, not tested but should work)
- Smart Card Reader: None
- Camera: 720p
- Keyboard: Backlit
- Fingerprint Reader: Yes
- Battery: 3-cell (23Wh) + 3-cell (26Wh)

## [Why OpenCore](https://khronokernel.github.io/Opencore-Vanilla-Desktop-Guide/#advantages-of-opencore)

## Recomended changes for 100% Macbook experience

- Use [one-key-hidpi](https://github.com/xzhih/one-key-hidpi) to enable HiDPI
- Add `PlatformInfo -> Generic -> MLB, SystemSerialNumber and SystemUUID` in config.plist to enable iCloud account related features

## Tips for MacOS

- Make dock animation faster and zero delay
```
defaults write com.apple.dock autohide-delay -float 0
defaults write com.apple.dock autohide-time-modifier -float 0.5
killall Dock
```
- Mount EFI
```
sudo diskutil list
sudo diskutil mount /dev/diskNsN
```
- Enable HiDPI
```
bash -c "$(curl -fsSL https://raw.githubusercontent.com/xzhih/one-key-hidpi/master/hidpi.sh)"
```
- Monitor temperatures and power consumption with [HWMonitor](https://github.com/kzlekk/HWSensors/releases)
> I know it's old and no longer supported, but it gets the job done and i really like the design

## Bios settings

- `Security -> Security Chip` **Disabled**
- `Memory Protection -> Execution Prevention` **Enabled**
- `Virtualization -> Intel Virtualization Technology` **Enabled**
- `Virtualization -> Intel VT-d Feature` **Disabled**
- `Anti-Theft -> Current Setting` **Disabled**
- `Anti-Theft -> Computrace -> Current Setting` **Disabled**
- `Secure Boot -> Secure Boot` **Disabled**
- `Intel SGX -> Intel SGX Control` **Disabled**
- `Device Guard` **Disabled**
- `UEFI/Legacy Boot` **UEFI Only**
- `CSM Support` **No**

## What works

>Boot time from OC Picker to Desktop is 20s
- Sleep / Wake
- Wifi and Bluetooth
- **Handoff, Continuity, AirDrop, Sidecar ([wireless](https://www.youtube.com/watch?v=D5yButavaWY))**
- iMessage, FaceTime, App Store, iTunes Store **(Add PlatformInfo)**
- Ethernet
- Onboard audio
- All USB 3.0 ports
- Battery **(very stable and precise capacity tracking)**
- Trackpad, Trackpoint, gestures and finally **physical buttons**
- miniDP and HDMI
- SIP and FileVault 2 can be enabled (thanks to OpenCore)

## What doesn't work

> If you have any questions or suggestions feel free to contact me
- SD Card Reader (I will try to make it works sometime in the future)
- Fingerprint Reader

## Update tracker

```
MacOS: 10.15.4
OpenCore: 0.5.6
Lilu: 1.4.3
VirtualSMC: 1.1.1
WhateverGreen: 1.3.8
AppleALC: 1.4.8
VoodooPS2Controller: 2.1.3
USBInjectAll: 0.7.1
IntelMausi: 1.0.2
```
## If you found my work useful please consider a PayPal donation

<a href="https://www.paypal.com/cgi-bin/webscr?cmd=_s-xclick&hosted_button_id=Y5BE5HYACDERG&source=url" target="_blank"><img src="https://raw.githubusercontent.com/Gruppio/Sonoff-Homekit/images/images/buymeacoffee.png" alt="Buy Me A Coffee" width="300" ></a>


## Thanks to

All the hackintosh community, in particular you guys on GitHub.
