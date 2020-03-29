# Thinkpad T460s macOS Catalina (OpenCore bootloader)

> First ever OpenCore build for T460s, everything but SD card reader works 

<img src="/images/T460s.png" alt="Thinkpad T460s" height="500">

## Introduction

- This EFI will probably work on any T460s regardless of CPU model / RAM amount / Display resolution / Storage drive (SATA or NVMe)
- To install macOS I suggest to follow [this guide](https://khronokernel.github.io/Opencore-Vanilla-Desktop-Guide/)
- Lots of SSDT patches can be found [here](https://translate.google.it/translate?sl=zh-CN&tl=en&u=https%3A%2F%2Fgithub.com%2Fdaliansky%2FOC-little)

### My Hardware
- Model: Thinkpad T460s (20F9003AUS)
- Processor: Intel Core i7-6600U (2C, 2.6 / 3.4GHz, 4MB)vPro
- Graphics: Integrated Intel HD Graphics 520
- Memory: 4GB Soldered + 4GB DIMM
- Display: 14" WQHD (2560x1440) IPS
- Sound Card: Realtek ALC293
- Multi-touch: None
- Storage: 256GB SSD M.2 Opal2
- Optical: None
- WLAN + Bluetooth: ~~Intel 8260 ac, 2x2 + BT4.1~~ **replaced with [BCM94360CS2](/BCM94360CS2_WLAN_card.md)**
- WWAN: WWAN Upgradable (Legacy_Sierra_QMI.kext needed, not tested but should work)
- Smart Card Reader: None
- Camera: 720p
- Keyboard: Backlit
- Fingerprint Reader: Yes
- Battery: 3-cell (23Wh) + 3-cell (26Wh)

## [Why OpenCore](https://khronokernel.github.io/Opencore-Vanilla-Desktop-Guide/#advantages-of-opencore)

## USB ports map
To fix sleep issue I had to built a custom USBPorts.kext wich maps all available ports on the T460s except SD card reader and dock links. In case you need them you would: 
```
Use USBInjectAll.kext instead of USBPorts.kext provided 
Remove SSDT-UIAC and SSDT-USBX
Generate those files using [Hackintool](https://github.com/headkaze/Hackintool) according to your specific needs
```

## Recomended changes for 100% Macbook experience

- Use this [RDM Utility](https://github.com/usr-sse2/RDM/releases) to enable HiDPI
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
Install [RDM Utility](https://github.com/usr-sse2/RDM/releases) 
for 2560x1440 screens I suggest using 1440x810 resolution
to make that simply select 'edit' and use settings as shown below
```
<img src="/images/HiDPI.png" height="300" >

- Monitor temperatures and power consumption with [HWMonitor](https://github.com/kzlekk/HWSensors/releases)
```
I know it's old and no longer supported, but it gets the job done and i really like the simple look
```

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

## What's working

>[Boot time from OC Picker to Desktop is 26s](https://www.youtube.com/watch?v=SnuQjuIrfc0)

- CPU Power Management

`<1W on IDLE`

- All USB ports

`custom USBPorts kext is used, make a new one if using dock`

- Internal camera

- Sleep / Wake / Shutdown / Reboot

`custom USBPorts.kext required`

- Ethernet

- **[Wifi, Bluetooth, Airdrop, Handoff, Continuity, Sidecar](/BCM94360CS2_WLAN_card.md)**

`A guide is provided`

- iMessage, FaceTime, App Store, iTunes Store 

`[Generate your on SMBIOS](https://github.com/corpnewt/GenSMBIOS) and add it to PlatformInfo`

- Audio in/out

`audio trough dock should work too thanks to AppleALC tluck's layout 28`

- Battery **(very stable and precise capacity tracking)**

`Thanks to EchoEsprit work for T450s`

- Keyboard

`audio and brighness hotkeys`

- Trackpad, Trackpoint and physical buttons

`two fingers swipe and tree fingers gestures`

- miniDP and HDMI

`video signal trough dock should work too thank to links added in DevicesProperty`

- Internal camera

`works without additional files`

- SIP and FileVault 2 can be enabled

`Are disabled in config.plist`

## What's not working

> If you have any questions or suggestions feel free to contact me

- SD Card Reader

`I will try to make it works sometime in the future`

- Fingerprint Reader

`Don't think it will ever be working on macOS`

## Update tracker

```
MacOS: 10.15.4
OpenCore: 0.5.6
Lilu: 1.4.3
VirtualSMC: 1.1.1
WhateverGreen: 1.3.8
AppleALC: 1.4.8
VoodooPS2Controller: 2.1.3
IntelMausi: 1.0.2
```
## If you found my work useful please consider a PayPal donation

<a href="https://www.paypal.com/cgi-bin/webscr?cmd=_s-xclick&hosted_button_id=Y5BE5HYACDERG&source=url" target="_blank"><img src="/images/buymeacoffee.png" alt="Buy Me A Coffee" width="300" ></a>

## Thanks to

All the hackintosh community, in particular you guys on GitHub.
