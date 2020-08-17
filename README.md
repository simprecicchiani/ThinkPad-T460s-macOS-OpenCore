# Thinkpad T460s running macOS (OpenCore bootloader)

> First OpenCore build for T460s ever

![Thinkpad T460s](/Images/T460s.png)

- [Introduction](#introduction)
	- [General knowledge & credits](#general-knowledge--credits)
	- [Hardware compatibility](#hardware-compatibility)
	- [How to install macOS](https://dortania.github.io/OpenCore-Install-Guide/installation/installation-process.html)
	- [How to upgrade to macOS 11.0 Big Sur](/Guides/Install-Big-Sur.md)
- [Post-installation optional changes](#post-installation-optional-changes)
	- [Unlock CFG Lock](/Users/simoneprecicchiani/GitHub/Thinkpad-T460s-macOS-OpenCore/Guides/Unlock-CFG.md)
	- [USB ports map](#usb-ports-map)
	- [CPU Power Management](#cpu-power-management)
	- [True MacBook experience ](#true-macbook-experience-)
		- [Generate your own SMBIOS](#generate-your-own-smbios)
		- [Enable HiDPI with RDM Utility](#enable-hidpi-with-rdm-utility)
	- [Other tweaks](#other-tweaks)
		- [Install ThinkpadAssistant](#install-thinkpadassistant)
		- [Use PrtSc key as Screenshot shortcut](#use-prtsc-key-as-screenshot-shortcut)
		- [Monitor temperatures and power consumption with HWMonitor](#monitor-temperatures-and-power-consumption-with-hwmonitor)
		- [Make dock animation faster and without delay](#make-dock-animation-faster-and-without-delay)
		- [Mac Bootloader GUI and Boot Chime](#mac-bootloader-gui-and-boot-chime)
- [Bios settings](#bios-settings)
- [Configuration status](#configuration-status)
	- [What's working ✔️](#whats-working-%EF%B8%8F)
	- [What's not working ⚠️](#whats-not-working-%EF%B8%8F)
	- [Update tracker 🔄](#update-tracker-)
- [Thanks to](#thanks-to)


## Introduction

### General knowledge & credits

* [Why OpenCore](https://dortania.github.io/OpenCore-Install-Guide/why-oc.html)

* [Dortania's guide](https://dortania.github.io/OpenCore-Install-Guide/)

* [SSDT patches from OC-little](https://translate.google.it/translate?sl=zh-CN&tl=en&u=https%3A%2F%2Fgithub.com%2Fdaliansky%2FOC-little)

* Useful tools by [@CorpNewt](https://github.com/corpnewt)

* [Acidanthera's OpenCore and kexts development](https://github.com/acidanthera)

* [@MSzturc](https://github.com/MSzturc) for keyboard map and [ThinkpadAssistant](https://github.com/MSzturc/ThinkpadAssistant)

### Hardware compatibility

#### My Hardware

```
Model: Thinkpad T460s (20F9003AUS)  
Processor: Intel Core i7-6600U (2C, 2.6 / 3.4GHz, 4MB)vPro  
Graphics: Integrated Intel HD Graphics 520  
Memory: 4GB Soldered + 4GB DIMM 2133 MHz DDR4  
Display: 14" WQHD (2560x1440) IPS  
Sound Card: Realtek ALC293  
Storage: 256GB SSD M.2 Opal2  
WLAN + Bluetooth: BCM94360CS2  
Camera: 720p  
Keyboard: Backlit  
Fingerprint Reader: Yes  
Battery: 3-cell (23Wh) + 3-cell (26Wh)  
```

This EFI will suit any T460s regardless of CPU model<sup>[1](#CPU)</sup> / RAM amount / Display resolution<sup>[2](#Res)</sup> / Storage drive (SATA or NVMe<sup>[3](#NVMe)</sup>).

<a name="CPU">1</a>: custom [CPU Power Management](#cpu-power-management) guide

<a name="Res">2</a>: 1440p display models should change UIScale to 2 for better resolution while booting
```sh
NVRAM -> Add -> 7C436110-AB2A-4BBB-A880-FE41995C9F82 -> UIScale = 2
```

<a name="NVMe">3</a>: Some NVMe drives may not work OOTB with MacOS, [NVMeFix](https://github.com/acidanthera/NVMeFix) could resolve some issues.

## Post-installation optional changes

### USB ports map

Needed to make TP dock ports working since I don't have one and my EFI doesn't include them. Use one of the following methods:

* [USBMap from CorpNewt](https://github.com/corpnewt?tab=repositories)

* [USBPorts from Hackintool](https://github.com/headkaze/Hackintool)

* [Native USB fix without injector kext](https://www.olarila.com/topic/6878-guide-native-usb-fix-for-notebooks-no-injectorkext-required/?tab=comments#comment-88412)

### CPU Power Management

If you want to take a step forward and create a custom CPU power profile, follow the steps below:

* Use [CPUFriendFriend](https://github.com/corpnewt/CPUFriendFriend) to generate  a `.plist` file with PM data; (settings for i7-6600u):

```sh
Low Frequency Mode (LFM) = 800MHz #(TDP-down frequency for i7-6600u)
Energy Performance Preference (EPP) = 80 #(Balance power)
```
* via `ResourceConverter.sh` inside [CPUFriend](https://github.com/acidanthera/CPUFriend), select the `.plist` to generate either `CPUFriendDataProvider.kext` or `SSDT-DATA.dsl`;

* Load `CPUFriend.kext` and `CPUFriendDataProvider.kext` inside `EFI/OC/config.plist` or

* Alternatively combine `SSDT-DATA.dsl` data with `SSDT-PLUG` and load it with `CPUFriend.kext` inside `EFI/OC/config.plist`.

That's how power consumption looks like on my machine at idle state:

![](/Images/PowerConsumption.png)

### True MacBook experience 

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
![](/Images/HiDPI.png)

### Other tweaks

#### Install [ThinkpadAssistant](https://github.com/MSzturc/ThinkpadAssistant)

Every hotkey will work on macOS with a beautiful, apple like control hud.

```sh
include SSDT-KBRD and relative patches in config.plist
install ThinkpadAssistant app under /Apllication/
check launch on login
```

#### Use PrtSc key as Screenshot shortcut

```sh
set F13 shortcut under SystemPreferences > Keyboard > Shortcuts > Screenshots
```
![](/Images/Shortcut.png)

#### Monitor temperatures and power consumption with [HWMonitor](https://github.com/kzlekk/HWSensors/releases)

This app is relatively old and no longer supported, but it gets the job done and has a nice simple look.

#### Make dock animation faster and without delay
Run these lines in terminal:

```sh
defaults write com.apple.dock autohide-delay -float 0
defaults write com.apple.dock autohide-time-modifier -float 0.5
killall Dock
```

#### Mac Bootloader GUI and Boot Chime

Follow the appropriate [Dortania Guide](https://dortania.github.io/OpenCore-Post-Install/cosmetic/gui.html#setting-up-opencore-s-gui).

Information for Boot Chime setup:  
`AudioDevice : PciRoot(0x0)/Pci(0x1f,0x3)`  
`AudioOut : 0 //Speakers`  
`AudioOut : 1 //Headphone Jack`  

![](/Images/MacBootloaderGUI.png)


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

## Configuration status

### What's working ✔️

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

- [x] [Trackpad, Trackpoint and physical buttons](/Images/VoodooRMI-T460s-trackpad-gestures.gif) `with all macOS gestures working thanks to VoodooRMI`

- [x] SIP and FileVault 2 can be enabled

- [x] miniDP and HDMI `with digital audio passthrough`

- [x] SD Card Reader `slow r/w speed but works`


### What's not working ⚠️

- [ ] Fingerprint Reader

- [ ] Video output not so stable

- [ ] Safari DRM

- [ ] WWAN `not tested`

### Update tracker 🔄

| Version | [Stable](/macOS-10.15.6-Catalina/EFI) | [Development](/macOS-10.15.6-Catalina/EFI-060-VoodooRMI) | [Beta](/macOS-11.0-Big-Sur/EFI) |
| :--- | ---: | ---: | ---: |
| [MacOS](https://www.apple.com/macos/) | 10.15.6 | 10.15.6 | 11.0 |
| [OpenCore](https://github.com/acidanthera/OpenCorePkg/releases) | 0.5.9 | 0.6.0 | 0.6.0 |
| [Lilu](https://github.com/acidanthera/Lilu/releases) | 1.4.5 | 1.4.6 | 1.4.6 |
| [VirtualSMC](https://github.com/acidanthera/VirtualSMC/releases) | 1.1.4 | 1.1.5 | 1.1.5 |
| [WhateverGreen](https://github.com/acidanthera/WhateverGreen/releases) | 1.4.0 | 1.4.1 | 1.4.1 |
| [AppleALC](https://github.com/acidanthera/AppleALC/releases) | 1.5.0 | 1.5.1 | 1.5.1 |
| [VoodooPS2Controller](https://github.com/acidanthera/VoodooPS2/releases) | 2.1.4 | 2.1.6 | 2.1.4 |
| [VoodooRMI](https://github.com/VoodooSMBus/VoodooRMI/releases) | none | 1.0.1 | none |
| [IntelMausi](https://github.com/acidanthera/IntelMausi/releases) | 1.0.3 | 1.0.3 | 1.0.3 |
| [Sinetek-rtsx](https://github.com/cholonam/Sinetek-rtsx/releases) | 2.2 | 2.3 | 2.2 |
| [HibernationFixup](https://github.com/acidanthera/HibernationFixup/releases) | 1.3.3 | 1.3.4 |1.3.3 |
| [CPUFriend](https://github.com/acidanthera/CPUFriend/releases) | 1.2.2 | 1.2.3 | 1.2.2 |

## Thanks to

The hackintosh community from GitHub, [InsanelyMac](https://www.insanelymac.com/forum/) and [r/hackintosh](https://www.reddit.com/r/hackintosh/).

**If you found my work useful please consider a PayPal donation**

<a href="https://www.paypal.com/cgi-bin/webscr?cmd=_s-xclick&hosted_button_id=Y5BE5HYACDERG&source=url" target="_blank"><img src="/Images/buymeacoffee.png" alt="Buy Me A Coffee" width="300" ></a>

