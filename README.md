# Thinkpad T460s macOS Catalina (OpenCore bootloader)

> First ever OpenCore build for T460s

<img src="/Images/T460s.png" alt="Thinkpad T460s" height="500">

## Introduction

### General knowledge & credits

* [Why OpenCore](https://dortania.github.io/OpenCore-Desktop-Guide/#advantages-of-opencore)

- To install macOS follow the guides provided by [Dortania](https://dortania.github.io)

- Lots of SSDT patches from [OC-little](https://translate.google.it/translate?sl=zh-CN&tl=en&u=https%3A%2F%2Fgithub.com%2Fdaliansky%2FOC-little)

- Useful tools by [CorpNewt](https://github.com/corpnewt)

- [Acidanthera](https://github.com/acidanthera) that make this possible


### My Hardware

* Model: Thinkpad T460s (20F9003AUS)
* Processor: Intel Core i7-6600U (2C, 2.6 / 3.4GHz, 4MB)vPro
* Graphics: Integrated Intel HD Graphics 520
* Memory: 4GB Soldered + 4GB DIMM
* Display: 14" WQHD (2560x1440) IPS
* Sound Card: Realtek ALC293
* Multi-touch: None
* Storage: 256GB SSD M.2 Opal2
* Optical: None
* WLAN + Bluetooth: BCM94360CS2
* WWAN: WWAN Upgradable (Legacy_Sierra_QMI.kext needed, not tested but should work)
* Smart Card Reader: None
* Camera: 720p
* Keyboard: Backlit
* Fingerprint Reader: Yes
* Battery: 3-cell (23Wh) + 3-cell (26Wh)


## What if I don't have this exact model?


This EFI will suit any T460s regardless of CPU model[^1] / RAM amount / Display resolution / Storage drive (SATA or NVMe[^2]).

[^1]: i5 model follows CPU Power Management guide  

[^2]: Some NVMe drives may not work OOTB with MacOS, do your own researches

-  [EFI](/EFI) contains my current setup w/o SMBIOS

- [**EFI057Install**](/EFI057Install) is what you want to use to install MacOS

If you happen to have a similar Thinkpad with 6th gen Skylake Intel processor (like X260, T460, T460p, T560, E560), there is a good chance that `EFI057Install` will work on it **with some precaution**:

1. double check your DSDT naming (like EC, LPC, KBD, etc.) with provided SSDTs naming

2. change iGPU inside cofing.plist according to your model (default is HD520)

3. follow USB ports map and CPU Power Management below

Thanks to @nijhawank from InsanelyMac that [switched from Clover to OpenCore on his T460](https://www.insanelymac.com/forum/topic/315451-guide-lenovo-t460t470-macos-with-clover/?do=findComment&comment=2715459) using [EFI057Install](/EFI057Install)!


## Recommended changes

### USB ports map

USBPorts.kext is used to map T460s ports and prevent it from shutdown issues. Alternatively, SSDT-UIAC & SSDT-USBX can be used as well. These files are configured to map all T460s ports *except TP dock links*.
If you need a different configuration, e.g. to use Thinkpad dock, easily generate it with [Hackintool](https://github.com/headkaze/Hackintool):

```
use EFI (first boot) which contains USBInjectAll.kext
generate custom USB map according to your specific needs with Hackintool
place USBPort.kext in OC/Kexts or SSDT-UIAC & SSDT_USBX in OC/ACPI (reflect these changes in config.plist)
finally remove USBInjectAll.kext (reflect this change in config.plist)
```

### CPU Power Management
If you happen to have a different CPU model **remove CPUFriend.kext and replace SSDT-CPUD with plain [SSDT-PLUG](/EFI057Install/OC/ACPI/SSDT-PLUG.aml)**, power management is natively supported by OpenCore. If you want to take a step forward and create a custom profile, follow the steps below:

* Use [CPUFriendFriend](https://github.com/corpnewt/CPUFriendFriend) to generate  a `.plist` file with PM data; (settings for i7-6600u):

```
Low Frequency Mode (LFM) = 800MHz #(TDP-down frequency for i7-6600u)
Energy Performance Preference (EPP) = 80 #(Balance power)
```
* via `ResourceConverter.sh` inside [CPUFriend](https://github.com/acidanthera/CPUFriend), select the `.plist` to generate either `CPUFriendDataProvider.kext` or `SSDT-DATA.dsl`;

* Load `CPUFriend.kext` and `CPUFriendDataProvider.kext` inside `EFI/OC/config.plist` or

* Alternatively combine `SSDT-DATA.dsl` data with `SSDT-PLUG` (renamed in [SSDT-CPUD](/EFI/OC/ACPI/SSDT-CPUD.aml)) and load it with `CPUFriend.kext` inside `EFI/OC/config.plist`.

That's how power consumption looks like on my machine at idle state:

<img src="/Images/PowerConsumption.png" height="300" >

### True Macbook experience

#### [Generate your own SMBIOS](https://github.com/corpnewt/GenSMBIOS)
```
run the script with MacbookPro13,1
add results to PlatformInfo > Generic > MLB, SystemSerialNumber and SystemUUID
```

#### Enable HiDPI with [RDM Utility](https://github.com/usr-sse2/RDM/releases)
```
install RDM Utility
open it, click on "resolution", then "edit"
for 2560x1440 screens I suggest using 1440x810 resolution
to accomplish that, use the settings below
```
<img src="/Images/HiDPI.png" height="300" >

### Other tweaks 

#### [Use PrtSc key as Screenshot shortcut](/Guides/PrtSc_to_F13.md)

```
set the shortcut under SystemPreferences > Keyboard > Shortcuts > Screenshots
```
#### Disable Wake on Wi-Fi
Wi-Fi transfer rate happen to be reduced after wake from sleep. To fix that, set:

```
SystemPreferences > Energy Saver > Power Adapter > Wake for Wi-Fi network access > Disable
```

#### Monitor temperatures and power consumption with [HWMonitor](https://github.com/kzlekk/HWSensors/releases)

This app is relatively old and no longer supported, but it gets the job done and has a nice simple look.

#### Make dock animation faster and without delay
Run these lines in terminal:

```bash
defaults write com.apple.dock autohide-delay -float 0
defaults write com.apple.dock autohide-time-modifier -float 0.5
killall Dock
```

## Bios settings
* `Config` > `USB` > `UEFI BIOS Support` > **Enable**
* `Config` > `Power` > `Intel SpeedStep Technology` > **Enable**
* `Config` > `Power` > `CPU Power Management` > **Enable**
* `Config` > `CPU` > `Hyper-Threading Technology` > **Enable**
* `Security` > `Security Chip` > **Disable**
* `Security` > `Virtualization` > `Intel Virtualization Technology` > **Enable**
* `Security` > `Virtualization` > `Intel VT-d Feature` > **Enable**
* `Security` > `Secure Boot` > **Disable**
* `Security` > `Intel SGX` > **Disable**
* `Startup` > `UEFI/Legacy Boot` > **UEFI Only**
* `Startup` > `CSM Support` > **No**
* `Startup` > `Boot Mode` > **Quick**

## What's working

>[Startup time from OC Picker to Desktop was 26s](https://www.youtube.com/watch?v=SnuQjuIrfc0), now it's 18s

- [x] CPU Power Management `~1W on IDLE`

- [x] All USB ports `custom USBPorts kext is used, make a new one if using dock`

- [x] Internal camera

- [x] Sleep / Wake / Shutdown / Reboot `custom USBPorts.kext or SSDT-EXT1 required`

- [x] Ethernet

- [x] **[Wifi, Bluetooth, Airdrop, Handoff, Continuity, Sidecar wireless](/Guides/BCM94360CS2_WLAN_card.md)**

- [x] iMessage, FaceTime, App Store, iTunes Store `Generate your own SMBIOS`

- [x] Audio in/out `audio trough dock should work too thanks to AppleALC tluck's layout 28`

- [x] Battery **(very stable and precise capacity tracking)** `Thanks to EchoEsprit work for T450s`

- [x] Keyboard `volume and brightness hotkeys`

- [x] Trackpad, Trackpoint and physical buttons `two fingers swipe and tree fingers gestures`

- [x] Internal camera `works without additional files`

- [x] SIP and FileVault 2 can be enabled

- [x] miniDP `not already tested` and HDMI `with digital audio passthrough`

- [x] SD Card Reader `slow r/w speed but works`


## What's not working ⚠️

- [ ] Fingerprint Reader

- [ ] Video output not so stable

## Update tracker

- [x] safe to install macOS Catalina‌ 10.15.4 supplemental update


| Item | Version |
| :--- | ---: |
| MacOS | 10.15.4 |
| OpenCore | 0.5.8 |
| Lilu | 1.4.4 |
| VirtualSMC | 1.1.3 |
| WhateverGreen | 1.3.9 |
| AppleALC | 1.4.9 |
| VoodooPS2Controller | 2.1.4 |
| VoodooInput | 1.0.5 |
| IntelMausi | 1.0.2 |
| Sinetek-rtsx.kext | 2.2 |


## If you found my work useful please consider a PayPal donation

<a href="https://www.paypal.com/cgi-bin/webscr?cmd=_s-xclick&hosted_button_id=Y5BE5HYACDERG&source=url" target="_blank"><img src="/Images/buymeacoffee.png" alt="Buy Me A Coffee" width="300" ></a>

## Thanks to

All the hackintosh community, especially the guys on GitHub.
