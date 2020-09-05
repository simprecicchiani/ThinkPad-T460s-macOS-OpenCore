# ThinkPad T460s running macOS (OpenCore bootloader)

<img align="right" src="https://imgur.com/sI2Uzel.jpg" alt="T460s macOS" width="300">

[![macOS](https://img.shields.io/badge/macOS-Catalina%20%26%20Big%20Sur-blue)](https://developer.apple.com/documentation/macos-release-notes)
[![OpenCore](https://img.shields.io/badge/OpenCore-0.6.0-green)](https://github.com/acidanthera/OpenCorePkg)
[![Model](https://img.shields.io/badge/Model-20F9003AUS-lightgrey)](https://psref.lenovo.com/Product/ThinkPad_T460s)
[![BIOS](https://img.shields.io/badge/BIOS-1.49-lightgrey)](https://pcsupport.lenovo.com/us/en/products/laptops-and-netbooks/thinkpad-t-series-laptops/thinkpad-t460s/downloads/driver-list/component?name=BIOS%2FUEFI)
[![LICENSE](https://img.shields.io/badge/license-MIT-purple)](/LICENSE)

**DISCLAIMER:**
Read the entire README before you start.
I am not responsible for any damages you may cause.  
Should you find an error or improve anything — whether in the config or in the documentation — please consider opening an issue or pull request.  
If you find my work useful, please consider donating via PayPal.
It would mean a lot to me.

[![donate](https://img.shields.io/badge/-buy%20me%20a%20coffee-orange)](https://www.paypal.com/cgi-bin/webscr?cmd=_s-xclick&hosted_button_id=Y5BE5HYACDERG&source=url)

## Introduction

<details>  
<summary><strong>General knowledge & credits</strong></summary>

- [Why OpenCore](https://dortania.github.io/OpenCore-Install-Guide/why-oc.html)  
- [Dortania's website](https://dortania.github.io)  
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

This EFI will suit any T460s regardless of CPU model<sup>[1](#CPU)</sup>, amount of RAM, display resolution<sup>[2](#Res)</sup>, and internal storage<sup>[3](#NVMe)</sup>.

<a name="CPU">1</a>: Optional custom CPU Power Management guide  
<a name="Res">2</a>: 1440p display models should change `NVRAM -> Add -> 7C436110-AB2A-4BBB-A880-FE41995C9F82 -> UIScale`:`2` to get proper scaling while booting  
<a name="NVMe">3</a>: Some NVMe drives may not work OOTB with MacOS, [NVMeFix](https://github.com/acidanthera/NVMeFix) could resolve some issues

</details>

## Installation
<details>  
<summary><strong>How to install macOS</strong></summary>

Carefully read [Dortania's guide](https://dortania.github.io/OpenCore-Install-Guide/installation/installation-process.html) and come back here to get the [EFI folder](/EFI/).

</details>

<details>  
<summary><strong>BIOS Settings</strong></summary>

| Menu     	| sub-menu          	| sub-menu                        	| setting   	|
|----------	|-------------------	|---------------------------------	|-----------	|
| Config   	| USB               	| UEFI BIOS Support               	| Enable    	|
|          	| Power             	| Intel SpeedStep Technology      	| Enable    	|
|          	|                   	| CPU Power Management            	| Enable    	|
|          	| CPU               	| Hyper-Threading Technology      	| Enable    	|
| Security 	| Security Chip     	|                                 	| Disable   	|
|          	| Memory Protection 	| Execution Prevention            	| Enable    	|
|          	| Virtualization    	| Intel Virtualization Technology 	| Enable    	|
|          	|                   	| Intel VT-d Feature              	| Enable    	|
|          	| Anti-Theft        	| Computrace                      	| Disable   	|
|          	| Secure Boot       	|                                 	| Disable   	|
|          	| Intel SGX         	|                                 	| Disable   	|
|          	| Device Guard      	|                                 	| Disable   	|
| Startup  	| UEFI/Legacy Boot  	|                                 	| UEFI Only 	|
|          	| CSM Support       	|                                 	| No        	|
|          	| Boot Mode         	|                                 	| Quick     	|

</details>

## Post-install

<details>  
<summary><strong>USB ports mapping</strong></summary>

For ThinkPad's dock only, use one of the following methods:

- [USBMap by CorpNewt](https://github.com/corpnewt?tab=repositories)
- [Native USB fix without injector kext](https://www.olarila.com/topic/6878-guide-native-usb-fix-for-notebooks-no-injectorkext-required/?tab=comments#comment-88412)

</details>

<details>  
<summary><strong>Custom CPU Power Management</strong></summary>

If you want to take a step forward and create a custom CPU power profile, follow these steps:

1. Launch Terminal.app
1. Copy the following command, paste it into the Terminal window, then press the ENTER key in the same Terminal window
   ```bash
   bash -c "$(curl -fsSL https://raw.githubusercontent.com/stevezhengshiqi/one-key-cpufriend/master/one-key-cpufriend.sh)"
   ```
1. Copy `CPUFriend.kext` and `CPUFriendDataProvider.kext` from desktop to `/OC/Kexts/`
   ```bash
   cp ~/Desktop/{CPUFriend,CPUFriendDataProvider}.kext /OC/Kexts/
   ```
1. Add `CPUFriend.kext` and `CPUFriendDataProvider.kext` entries in `config.plist` under `Kernel -> Add`
   ```xml
   <dict>
       <key>BundlePath</key>
       <string>CPUFriend.kext</string>
       <key>Comment</key>
       <string>Power management data injector</string>
       <key>Enabled</key>
       <true/>
       <key>ExecutablePath</key>
       <string>Contents/MacOS/CPUFriend</string>
       <key>MaxKernel</key>
       <string></string>
       <key>MinKernel</key>
       <string></string>
       <key>PlistPath</key>
       <string>Contents/Info.plist</string>
   </dict>
   <dict>
       <key>BundlePath</key>
       <string>CPUFriendDataProvider.kext</string>
       <key>Comment</key>
       <string>Power management data</string>
       <key>Enabled</key>
       <true/>
       <key>ExecutablePath</key>
       <string></string>
       <key>MaxKernel</key>
       <string></string>
       <key>MinKernel</key>
       <string></string>
       <key>PlistPath</key>
       <string>Contents/Info.plist</string>
   </dict>
   ```

This my machine's power consumption when idling:

![](/Images/PowerConsumption.png)

</details>

<details>  
<summary><strong>Enable Apple Services</strong></summary>

1. Launch Terminal.app
1. Copy the following script, paste it into the Terminal window, then press ENTER
   ```bash
   git clone https://github.com/corpnewt/GenSMBIOS && cd GenSMBIOS && ./GenSMBIOS.command 
   ```
1. Type `2`, then press ENTER
1. Drag your `config.plist` inside the Terminal window
1. Type `3`, then press ENTER
1. Type `MacbookPro13,1`, then press ENTER

</details>

<details>  
<summary><strong>Enable HiDPI</strong></summary>

1. [Disable SIP](https://dortania.github.io/OpenCore-Install-Guide/troubleshooting/troubleshooting.html#disabling-sip)
1. Launch Terminal.app
1. Copy the following script, paste it into the Terminal window, then press ENTER in the Terminal window
   ```bash
   bash -c "$(curl -fsSL https://raw.githubusercontent.com/xzhih/one-key-hidpi/master/hidpi.sh)"
   ```
1. Follow the script instructions, then reboot
1. Enable SIP (if desired)
</details>

## Other tweaks

<details>  
<summary><strong>Fully functioning multimedia Fn keys</strong></summary>

1. Download and install [ThinkpadAssistant](https://github.com/MSzturc/ThinkpadAssistant/releases)
1. Open the app
1. Check the `launch on login` option

</details>

<details>  
<summary><strong>Use PrtSc key as Screenshot shortcut</strong></summary>

1. Go under `SystemPreferences > Keyboard > Shortcuts > Screenshots` 
1. Click on `Screenshot and recording options` key map
1. Press `PrtSc` on your keyboard (it should came out as `F13`)

![](/Images/Shortcut.png)

</details>

<details>  
<summary><strong>Monitor temperatures and power consumption</strong></summary>

1. Download and install [HWMonitor](https://github.com/kzlekk/HWSensors/releases)
1. Open the app
1. Check the `launch on login` option

</details> 

<details>  
<summary><strong>Faster macOS dock animation</strong></summary>

1. Launch Terminal.app
1. Copy and paste each of the following lines into the Terminal window, pressing the ENTER key in the Terminal window after pasting each line
   ```bash
   defaults write com.apple.dock autohide-delay -float 0
   defaults write com.apple.dock autohide-time-modifier -float 0.5
   killall Dock
   ```
</details>

<details>  
<summary><strong>Mac Bootloader GUI and Boot Chime</strong></summary>

**Setting up OpenCore's GUI**

1. Download [Binary Resources](https://github.com/acidanthera/OcBinaryData) and [OpenCanopy.efi](https://github.com/acidanthera/OpenCorePkg/releases)
1. Copy the [Resources folder](https://github.com/acidanthera/OcBinaryData) to `EFI/OC`
1. Add OpenCanopy.efi to `EFI/OC/Drivers`
1. Make these changes inside `config.plist`:
   `Misc -> Boot -> PickerMode`: `External`
   `Misc -> Boot -> PickerAttributes`:`1`
   `UEFI -> Drivers` and add `OpenCanopy.efi`

**Setting up Boot-chime with AudioDxe**

1. Download [AudioDxe](https://github.com/acidanthera/OpenCorePkg/releases)
1. Copy AudioDxe.efi to `EFI/OC/Drivers`
1. Make these changes inside `config.plist`:
   `UEFI -> Drivers` and add `AudioDxe.efi`
   `NVRAM -> Add -> 7C436110-AB2A-4BBB-A880-FE41995C9F82 -> SystemAudioVolume`:`0x46` (Data)
   `UEFI -> Audio -> AudioSupport`:`True` 
   `UEFI -> Audio -> AudioDevice`:`PciRoot(0x0)/Pci(0x1f,0x3)`
   `UEFI -> Audio -> AudioOut`:`0` (for Speakers or `1` for Headphone Jack)
   `UEFI -> Audio -> MinimumVolume`:`50`
   `UEFI -> Audio -> PlayChime`:`True`
   `UEFI -> Audio -> VolumeAmplifier`:`143`

**Additional settings for visually impaired**

   `Misc -> Boot -> PickerAudioAssist`:`True` to enable picker audio
   `UEFI -> ProtocolOverrides -> AppleAudio`:`True` to enable FileVault voice over

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

| Version                                                                      | [Stable](/EFI)                        | 
|:-----------------------------------------------------------------------------|--------------------------------------:|
| [MacOS](https://www.apple.com/macos/)                                        | 10.15.6 / 11.0                        |
| [OpenCore](https://github.com/acidanthera/OpenCorePkg/releases)              | 0.6.0                                 | 
| [Lilu](https://github.com/acidanthera/Lilu/releases)                         | 1.4.6                                 | 
| [VirtualSMC](https://github.com/acidanthera/VirtualSMC/releases)             | 1.1.5                                 | 
| [WhateverGreen](https://github.com/acidanthera/WhateverGreen/releases)       | 1.4.1                                 | 
| [AppleALC](https://github.com/acidanthera/AppleALC/releases)                 | 1.5.1                                 | 
| [VoodooPS2Controller](https://github.com/acidanthera/VoodooPS2/releases)     | 2.1.6                                 |
| [VoodooRMI](https://github.com/VoodooSMBus/VoodooRMI/releases)               | 1.0.1                                 |
| [IntelMausi](https://github.com/acidanthera/IntelMausi/releases)             | 1.0.3                                 | 
| [Sinetek-rtsx](https://github.com/cholonam/Sinetek-rtsx/releases)            | 2.3                                   | 
| [HibernationFixup](https://github.com/acidanthera/HibernationFixup/releases) | 1.3.4                                 | 
| [CPUFriend](https://github.com/acidanthera/CPUFriend/releases)               | 1.2.3                                 | 

</details>

<details>  
<summary><strong>Changelog</strong></summary>

- 20200822:  
New README for improved readability

</details>

## Thanks to

The hackintosh community on GitHub,
[InsanelyMac](https://www.insanelymac.com/forum/), and
[r/hackintosh](https://www.reddit.com/r/hackintosh/).
