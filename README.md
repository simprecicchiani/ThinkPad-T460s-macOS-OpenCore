# Thinkpad T460s macOS Catalina (OpenCore bootloader)

> First ever OpenCore build for T460s

<img src="/Images/T460s.png" alt="Thinkpad T460s" height="500">

## Introduction

### General knowledge & credits

* [Why OpenCore](https://dortania.github.io/OpenCore-Desktop-Guide/#advantages-of-opencore)

* To install macOS follow the guides provided by [Dortania](https://dortania.github.io)

* Lots of SSDT patches from [OC-little](https://translate.google.it/translate?sl=zh-CN&tl=en&u=https%3A%2F%2Fgithub.com%2Fdaliansky%2FOC-little)

* Useful tools by [CorpNewt](https://github.com/corpnewt)

* [Acidanthera](https://github.com/acidanthera) that make this possible

* @MSzturc for keyboard map and [ThinkpadAssistant](https://github.com/MSzturc/ThinkpadAssistant)


### My Hardware

* Model: Thinkpad T460s (20F9003AUS)
* Processor: Intel Core i7-6600U (2C, 2.6 / 3.4GHz, 4MB)vPro
* Graphics: Integrated Intel HD Graphics 520
* Memory: 4GB Soldered + 4GB DIMM
* Display: 14" WQHD (2560x1440) IPS
* Sound Card: Realtek ALC293
* Storage: 256GB SSD M.2 Opal2
* WLAN + Bluetooth: BCM94360CS2
* Camera: 720p
* Keyboard: Backlit
* Fingerprint Reader: Yes
* Battery: 3-cell (23Wh) + 3-cell (26Wh)


## What if I don't have this exact model?


This EFI will suit any T460s regardless of CPU model[^1] / RAM amount / Display resolution / Storage drive (SATA or NVMe[^2]).

[^1]: non-i7 models follow [CPU Power Management](#cpu-power-management) guide  

[^2]: Some NVMe drives may not work OOTB with MacOS, [NVMeFix](https://github.com/acidanthera/NVMeFix) could resolve some issues.

## Recommended changes

### USB ports map

Needed to make TP dock ports working since I don't have one and my config doesn't include them.

Use one of the following methods:

* [USBMap from CorpNewt](https://github.com/corpnewt?tab=repositories)

* [USBPorts from Hackintool](https://github.com/headkaze/Hackintool)

* [Native USB fix without injector kext](https://www.olarila.com/topic/6878-guide-native-usb-fix-for-notebooks-no-injectorkext-required/?tab=comments#comment-88412)

### CPU Power Management
If you happen to have a different CPU model **remove CPUFriend.kext and replace SSDT-CPUD with plain [SSDT-PLUG](/EFI057Install/OC/ACPI/SSDT-PLUG.aml)**, power management is natively supported by OpenCore. If you want to take a step forward and create a custom profile, follow the steps below:

* Use [CPUFriendFriend](https://github.com/corpnewt/CPUFriendFriend) to generate  a `.plist` file with PM data; (settings for i7-6600u):

```sh
Low Frequency Mode (LFM) = 800MHz #(TDP-down frequency for i7-6600u)
Energy Performance Preference (EPP) = 80 #(Balance power)
```
* via `ResourceConverter.sh` inside [CPUFriend](https://github.com/acidanthera/CPUFriend), select the `.plist` to generate either `CPUFriendDataProvider.kext` or `SSDT-DATA.dsl`;

* Load `CPUFriend.kext` and `CPUFriendDataProvider.kext` inside `EFI/OC/config.plist` or

* Alternatively combine `SSDT-DATA.dsl` data with `SSDT-PLUG` (renamed in [SSDT-CPUD](/EFI/OC/ACPI/SSDT-CPUD.aml)) and load it with `CPUFriend.kext` inside `EFI/OC/config.plist`.

That's how power consumption looks like on my machine at idle state:

<img src="/Images/PowerConsumption.png" height="300" >

### True Macbook experience 

#### [Generate your own SMBIOS](https://github.com/corpnewt/GenSMBIOS)
```sh
run the script with MacbookPro13,1
add results to PlatformInfo > Generic > MLB, SystemSerialNumber and SystemUUID
```

#### Enable HiDPI with [RDM Utility](https://github.com/usr-sse2/RDM/releases)
```sh
install RDM Utility
open it, click on "resolution", then "edit"
for 2560x1440 screens I suggest using 1440x810 resolution
to accomplish that, use the settings below
```
<img src="/Images/HiDPI.png" height="300" >

### Other tweaks

#### Install [ThinkpadAssistant](https://github.com/MSzturc/ThinkpadAssistant)

Every hotkey will work on macOS with a beautiful, apple like control hud.

```sh
include SSDT-KBRD and relatives names patches in config.plist
install ThinkpadAssistant app under /Apllication/
check launch on login
```

#### [Use PrtSc key as Screenshot shortcut](/Guides/PrtSc_to_F13.md)

```sh
set F13 shortcut under SystemPreferences > Keyboard > Shortcuts > Screenshots
```

#### Monitor temperatures and power consumption with [HWMonitor](https://github.com/kzlekk/HWSensors/releases)

This app is relatively old and no longer supported, but it gets the job done and has a nice simple look.

#### Make dock animation faster and without delay
Run these lines in terminal:

```sh
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
* `Security` > `Memory Protection`>`Execution Prevention`>**Enable**
* `Security` > `Virtualization` > `Intel Virtualization Technology` > **Enable**
* `Security` > `Virtualization` > `Intel VT-d Feature` > **Enable**
* `Security` > `Anti-Theft` > `Computrace` > `Current Setting` > **Disable**
* `Security` > `Secure Boot` > **Disable**
* `Security` > `Intel SGX` > **Disable**
* `Security` > `Device Guard` > **Disable**
* `Startup` > `UEFI/Legacy Boot` > **UEFI Only**
* `Startup` > `CSM Support` > **No**
* `Startup` > `Boot Mode` > **Quick**

## What's working ✔️

>[Startup time from OC Picker to Desktop was 26s](https://www.youtube.com/watch?v=SnuQjuIrfc0), now it's 18s

- [x] CPU Power Management `~1W on IDLE`

- [x] Intel HD 520 Graphics `incuding graphics acceleration`

- [x] All USB ports `with custom kext or SSDT`

- [x] Internal camera `working fine on FaceTime, Skype, Webex and others`

- [x] Sleep / Wake / Shutdown / Reboot `with lid sernsor`

- [x] Intel Gigabit Ethernet

- [x] **[Wifi, Bluetooth, Airdrop, Handoff, Continuity, Sidecar wireless](/Guides/BCM94360CS2_WLAN_card.md)**

- [x] iMessage, FaceTime, App Store, iTunes Store `Generate your own SMBIOS`

- [x] DRM support `iTunes Movies, Apple TV+, Amazon Prime, Netflix and others`

- [x] Speakers and headphones jack `fairly good volume`

- [x] Batteries `very stable and precise capacity tracking`

- [x] Keyboard map and hotkeys with [ThinkpadAssistant](https://github.com/MSzturc/ThinkpadAssistant) `thanks to @MSzturc`

- [x] Trackpad, Trackpoint and physical buttons `two fingers swipe and three fingers gestures`

- [x] SIP and FileVault 2 can be enabled

- [x] miniDP and HDMI `with digital audio passthrough`

- [x] SD Card Reader `slow r/w speed but works`


## What's not working ⚠️

- [ ] Fingerprint Reader

- [ ] Video output not so stable

- [ ] WWAN `Legacy_Sierra_QMI.kext needed, not tested but should work`

## Update tracker 🔄

- [x] safe to install macOS Catalina‌ 10.15.5


| Item | Version |
| :--- | ---: |
| MacOS | 10.15.5 |
| OpenCore | 0.5.9 |
| Lilu | 1.4.5 |
| VirtualSMC | 1.1.4 |
| WhateverGreen | 1.4.0 |
| AppleALC | 1.5.0 |
| VoodooPS2Controller | 2.1.4 |
| VoodooInput | 1.0.5 |
| IntelMausi | 1.0.3 |
| Sinetek-rtsx.kext | 2.2 |


## If you found my work useful please consider a PayPal donation

<a href="https://www.paypal.com/cgi-bin/webscr?cmd=_s-xclick&hosted_button_id=Y5BE5HYACDERG&source=url" target="_blank"><img src="/Images/buymeacoffee.png" alt="Buy Me A Coffee" width="300" ></a>

## Thanks to

The hackintosh community from GitHub, [InsanelyMac](https://www.insanelymac.com/forum/) and [r/hackintosh](https://www.reddit.com/r/hackintosh/).
