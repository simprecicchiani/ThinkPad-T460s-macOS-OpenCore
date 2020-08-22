# Thinkpad T460s running macOS (OpenCore bootloader)

<img align="right" src="https://imgur.com/sI2Uzel.jpg" alt="T460s macOS" width="300">

[![macOS](https://img.shields.io/badge/macOS-Catalina_10.15.6-blue.svg)](https://support.apple.com/en-us/HT210642)
[![OpenCore](https://img.shields.io/badge/OpenCore-0.6.0-green)](https://github.com/acidanthera/OpenCorePkg)
[![MODEL](https://img.shields.io/badge/Model-20F9003AUS-lightgrey)](https://psref.lenovo.com/Product/ThinkPad_T460s)
[![BIOS](https://img.shields.io/badge/BIOS-1.49-lightgrey)](https://pcsupport.lenovo.com/us/en/products/laptops-and-netbooks/thinkpad-t-series-laptops/thinkpad-t460s/downloads/driver-list/component?name=BIOS%2FUEFI)
[![LICENSE](https://img.shields.io/badge/license-MIT-purple)](/LICENSE)

**DISCLAIMER:**
Read the entire README before you start. I am not responsible for any damages you may cause.

Should you find an error, or improve anything, be it in the config itself or in the my documentation, please consider opening an issue or a pull request to contribute.

Lastly, if you found my work useful please consider a PayPal donation, it would mean a lot to me.

[![donate](https://img.shields.io/badge/-buy%20me%20a%20coffee-orange)](https://www.paypal.com/cgi-bin/webscr?cmd=_s-xclick&hosted_button_id=Y5BE5HYACDERG&source=url)

## Introduction

<details>  
<summary><strong>General knowledge & credits</strong></summary>

- [Why OpenCore](https://dortania.github.io/OpenCore-Install-Guide/why-oc.html)

- [Dortania's guide](https://dortania.github.io/OpenCore-Install-Guide/)

- [SSDT patches from OC-little](https://translate.google.it/translate?sl=zh-CN&tl=en&u=https%3A%2F%2Fgithub.com%2Fdaliansky%2FOC-little)

- Useful tools by [@CorpNewt](https://github.com/corpnewt)

- [Acidanthera's OpenCore and kexts development](https://github.com/acidanthera)

- [@MSzturc](https://github.com/MSzturc) keyboard map and [ThinkpadAssistant](https://github.com/MSzturc/ThinkpadAssistant)

</details>


<details>  
<summary><strong>My Hardware</strong></summary>

| Product            | ThinkPad T460s                                                                                            |
|:-------------------|:----------------------------------------------------------------------------------------------------------|
| Model              | 20F9003AUS                                                                                                |
| Region             | US                                                                                                        |
| Machine Type       | 20F9                                                                                                      |
| Processor          | Core i7-6600U (2C, 2.6 / 3.4GHz, 4MB)                                                                     |
| vPro               | Intel vPro Technology                                                                                     |
| Graphics           | Integrated Intel HD Graphics 520                                                                          |
| Memory             | 4GB Soldered + 4GB DIMM 2133MHz DDR4, dual-channel                                                        |
| Display            | 14" WQHD (2560x1440) IPS                                                                                  |
| Multi-touch        | None                                                                                                      |
| Storage            | SanDisk SD8TN8U256G1001 256GB SSD M.2 Opal2                                                               |
| Optical            | None                                                                                                      |
| Ethernet           | Intel Ethernet Connection I219-LM (Jacksonville)                                                          |
| WLAN + Bluetooth   | 11ac+BT, [Broadcom BCM94360CS2](/Guides/Replace-WLAN.md), 2x2 card                                        |
| WWAN               | WWAN Upgradable                                                                                           |
| SIM Card           | None                                                                                                      |
| Smart Card Reader  | None                                                                                                      |
| Dock               | None                                                                                                      |
| Camera             | HD720p resolution, low light sensitive, fixed focus                                                       |
| Audio support      | HD Audio, Realtek ALC3245 codec, stereo speakers 1Wx2, dual array microphone, combo audio/microphone jack |
| Keyboard           | 6-row, spill-resistant, multimedia Fn keys, LED backlight                                                 |
| Fingerprint Reader | Fingerprint Reader                                                                                        |
| Battery            | Front Li-Polymer 3-cell (23Wh) and rear Li-Ion 3-cell (26Wh), both Integrated                             |
| Power Adapter      | 45W                                                                                                       |

</details>

<details>  
<summary><strong>Hardware compatibility</strong></summary>

This EFI will suit any T460s regardless of CPU model<sup>[1](#CPU)</sup> / RAM amount / Display resolution<sup>[2](#Res)</sup> / Storage drive (SATA or NVMe<sup>[3](#NVMe)</sup>).

<a name="CPU">1</a>: Optional custom CPU Power Management guide

<a name="Res">2</a>: 1440p display models should change `NVRAM -> Add -> 7C436110-AB2A-4BBB-A880-FE41995C9F82 -> UIScale = 2` to get proper scaling while booting

<a name="NVMe">3</a>: Some NVMe drives may not work OOTB with MacOS, [NVMeFix](https://github.com/acidanthera/NVMeFix) could resolve some issues.

</details>

## Installation
<details>  
<summary><strong>How to install macOS</strong></summary>

- Download [EFI folder](/macOS-10.15.6-Catalina/EFI-060-VoodooRMI/)
- Follow [Dortania's guide](https://dortania.github.io/OpenCore-Install-Guide/installation/installation-process.html)

</details>

<details>  
<summary><strong>How to upgrade to macOS 11.0 Big Sur</strong></summary>

- Download [EFI folder](/macOS-11.0-Big-Sur/EFI/)
- Follow [duszmox's guide](/Guides/Install-Big-Sur.md)

</details>

<details>  
<summary><strong>BIOS Settings</strong></summary>

- `Config` > `USB` > `UEFI BIOS Support` > **Enable**
- `Config` > `Power` > `Intel SpeedStep Technology` > **Enable**
- `Config` > `Power` > `CPU Power Management` > **Enable**
- `Config` > `CPU` > `Hyper-Threading Technology` > **Enable**
- `Security` > `Security Chip` > **Disable**
- `Security` > `Memory Protection`>`Execution Prevention`>**Enable**
- `Security` > `Virtualization` > `Intel Virtualization Technology` > **Enable**
- `Security` > `Virtualization` > `Intel VT-d Feature` > **Enable**
- `Security` > `Anti-Theft` > `Computrace` > `Current Setting` > **Disable**
- `Security` > `Secure Boot` > **Disable**
- `Security` > `Intel SGX` > **Disable**
- `Security` > `Device Guard` > **Disable**
- `Startup` > `UEFI/Legacy Boot` > **UEFI Only**
- `Startup` > `CSM Support` > **No**
- `Startup` > `Boot Mode` > **Quick**

</details>

## Post-install

<details>  
<summary><strong>USB ports mapping</strong></summary>

Needed to make TP dock ports working since I don't have one and my EFI doesn't include them. Use one of the following methods:

- [USBMap from CorpNewt](https://github.com/corpnewt?tab=repositories)

- [USBPorts from Hackintool](https://github.com/headkaze/Hackintool)

- [Native USB fix without injector kext](https://www.olarila.com/topic/6878-guide-native-usb-fix-for-notebooks-no-injectorkext-required/?tab=comments#comment-88412)

</details>

<details>  
<summary><strong>Custom CPU Power Management</strong></summary>

If you want to take a step forward and create a custom CPU power profile, follow the steps below:

- Use [CPUFriendFriend](https://github.com/corpnewt/CPUFriendFriend) to generate  a `.plist` file with PM data; (settings for i7-6600u):

```
$ Low Frequency Mode (LFM) = 800MHz #(TDP-down frequency for i7-6600u)
$ Energy Performance Preference (EPP) = 80 #(Balance power)
```
- via `ResourceConverter.sh` inside [CPUFriend](https://github.com/acidanthera/CPUFriend), select the `.plist` to generate either `CPUFriendDataProvider.kext` or `SSDT-DATA.dsl`;

- Load `CPUFriend.kext` and `CPUFriendDataProvider.kext` inside `EFI/OC/config.plist` or

- Alternatively combine `SSDT-DATA.dsl` data with `SSDT-PLUG` and load it with `CPUFriend.kext` inside `EFI/OC/config.plist`.

That's how power consumption looks like on my machine idle state:

![](/Images/PowerConsumption.png)

</details>

<details>  
<summary><strong>Enable Apple Services</strong></summary>

- Download [GenSMBIOS](https://github.com/corpnewt/GenSMBIOS)

- Run the script with `MacbookPro13,1`

- Add results to `PlatformInfo > Generic > MLB, SystemSerialNumber and SystemUUID`

</details>

<details>  
<summary><strong>Enable HiDPI</strong></summary>

- Disable SIP (just for this process, you can enable it once finished)

- Download and install [RDM Utility](https://github.com/usr-sse2/RDM/releases)

- Launch the app, click on "resolution", then "edit"

- Type 2880x1620, check HiDPI (will look like 1440x810)

- Reboot the system

- Re-launch RDM, click on "resolution", select 1444x810⚡️

![](/Images/HiDPI.png)

</details>

## Other tweaks

<details>  
<summary><strong>Fully functioning multimedia Fn keys</strong></summary>

- Install [ThinkpadAssistant](https://github.com/MSzturc/ThinkpadAssistant)
- Check launch on login

</details>

<details>  
<summary><strong>Use PrtSc key as Screenshot shortcut</strong></summary>

- PrtSc is mapped to F13, just go under SystemPreferences > Keyboard > Shortcuts > Screenshots and record the shortcut

![](/Images/Shortcut.png)

</details>

<details>  
<summary><strong>Monitor temperatures and power consumption</strong></summary>

- Download and install [HWMonitor](https://github.com/kzlekk/HWSensors/releases)
- Check launch on login

</details> 

<details>  
<summary><strong>Make dock animation faster and without delay</strong></summary>

- Run these lines in terminal:

```
$ defaults write com.apple.dock autohide-delay -float 0
$ defaults write com.apple.dock autohide-time-modifier -float 0.5
$ killall Dock
```
</details>

<details>  
<summary><strong>Mac Bootloader GUI and Boot Chime</strong></summary>

- Follow the appropriate [Guide](https://dortania.github.io/OpenCore-Post-Install/cosmetic/gui.html#setting-up-opencore-s-gui).

Information for Boot Chime setup:  
`AudioDevice : PciRoot(0x0)/Pci(0x1f,0x3)`  
`AudioOut : 0 //Speakers`  
`AudioOut : 1 //Headphone Jack`  

![](/Images/MacBootloaderGUI.png)

</details>

## Status
<details>  
<summary><strong>What's working ✅</strong></summary>


- [x] CPU Power Management `~1W on IDLE`

- [x] Intel HD 520 Graphics `incuding graphics acceleration`

- [x] All USB ports `with custom kext or SSDT`

- [x] Internal camera `working fine on FaceTime, Skype, Webex and others`

- [x] Sleep / Wake / Shutdown / Reboot `with lid sernsor`

- [x] Intel Gigabit Ethernet

- [x] [Wifi, Bluetooth, Airdrop, Handoff, Continuity, Sidecar wireless](/Guides/Replace-WLAN.md)

- [x] iMessage, FaceTime, App Store, iTunes Store `Generate your own SMBIOS`

- [x] DRM support `iTunes Movies, Apple TV+, Amazon Prime, Netflix and others`

- [x] Speakers and headphones jack `fairly good volume`

- [x] Batteries `very stable and precise capacity tracking`

- [x] Keyboard map and hotkeys with [ThinkpadAssistant](https://github.com/MSzturc/ThinkpadAssistant) `thanks to @MSzturc`

- [x] [Trackpad, Trackpoint and physical buttons](/Images/VoodooRMI-T460s-trackpad-gestures.gif) `with all macOS gestures working thanks to VoodooRMI`

- [x] SIP and FileVault 2 can be enabled

- [x] miniDP and HDMI `with digital audio passthrough`

- [x] SD Card Reader `slow r/w speed but works`

</details>

<details>  
<summary><strong>What's not working ⚠️</strong></summary>

- [ ] Fingerprint Reader

- [ ] Video output not so stable

- [ ] Safari DRM

- [ ] WWAN `not tested`

</details>

<details>  
<summary><strong>Update tracker 🔄</strong></summary>

| Version | [Stable](/macOS-10.15.6-Catalina/EFI) | [Dev](/macOS-10.15.6-Catalina/EFI-060-VoodooRMI) | [Beta](/macOS-11.0-Big-Sur/EFI) |
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

</details>

<details>  
<summary><strong>Changelog</strong></summary>

- 20200822:  
New README for improved readability

</details>

## Thanks to

The hackintosh community from GitHub, [InsanelyMac](https://www.insanelymac.com/forum/) and [r/hackintosh](https://www.reddit.com/r/hackintosh/).
