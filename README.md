# ThinkPad T460s running macOS (OpenCore bootloader)

<img align="right" src="/Images/t460s-monterey.png" alt="Lenovo Thinkpad T460s macOS Hackintosh OpenCore" width="300">

[![macOS](https://img.shields.io/badge/macOS-11.4-blue)](https://developer.apple.com/documentation/macos-release-notes)
[![macOS-beta](https://img.shields.io/badge/macOS–Beta-12_beta–2-orange)](https://developer.apple.com/documentation/macos-release-notes/macos-12-beta-release-notes)
[![OpenCore](https://img.shields.io/badge/OpenCore-0.7.1-green)](https://github.com/acidanthera/OpenCorePkg)
[![Model](https://img.shields.io/badge/Model-20F9*-lightgrey)](https://psref.lenovo.com/Product/ThinkPad_T460s)
[![BIOS](https://img.shields.io/badge/BIOS-1.51-yellow)](https://pcsupport.lenovo.com/us/en/products/laptops-and-netbooks/thinkpad-t-series-laptops/thinkpad-t460s/downloads/driver-list/component?name=BIOS%2FUEFI)
[![License](https://img.shields.io/badge/license-MIT-purple)](/LICENSE)

**DISCLAIMER:**  
Read the entire README before you start.
We are not responsible for any damages you may cause.  
Should you find an error or improve anything — whether in the config or in the documentation — please consider opening an issue or pull request.  
If you find our work useful, please consider donating via PayPal.
It would mean a lot to us.

**This repo has now support for macOS 12 Monterey beta. It isn't a stable version yet, so it's not reccommended for daily use, but there is the option for it. Please read the [discussion about it](https://github.com/simprecicchiani/ThinkPad-T460s-macOS-OpenCore/discussions/118), if you encounter any problems please contribute to that thread. The OS has support from EFI update [0.7.0.1](https://github.com/simprecicchiani/ThinkPad-T460s-macOS-OpenCore/releases/tag/0.7.0.1), and you can install it as you would install a normal update.**

duszmox's donate link:  
[![donate](https://img.shields.io/badge/-buy%20me%20a%20coffee-orange)](https://paypal.me/duszmo?locale.x=en_US)

mhl221135's donate link:  
[![donate](https://img.shields.io/badge/-buy%20me%20a%20coffee-orange)](https://mhl221135.diaka.ua/donate)

## Introduction

<details>  
<summary><strong>Getting started 📖</strong></summary>
</br>

**Meet the bootloader:**

- [Why OpenCore](https://dortania.github.io/OpenCore-Install-Guide/why-oc.html)
- Dortania's [website](https://dortania.github.io)

**Recommended tools:**

- Plist editor [ProperTree](https://github.com/corpnewt/ProperTree)
- Handy-dandy ESP mounting script [MountEFI](https://github.com/corpnewt/MountEFI)

**Resources**

- [OpenCore](https://github.com/acidanthera/OpenCorePkg)
- [OC-little](https://github.com/daliansky/OC-little)
- [X1 Carbon config](https://github.com/tylernguyen/x1c6-hackintosh)
- [T460 config](https://github.com/MSzturc/Lenovo-T460-OpenCore)

</details>

</details>

<details>  
<summary><strong>Tested Hardware 💻</strong></summary>
</br>

| @duszmox's Model | Thinkpad T460s 20FAS2SV00                                                                                 |
| :--------------- | :-------------------------------------------------------------------------------------------------------- |
| Processor        | Core i7-6600U (2C, 2.6 / 3.4GHz, 4MB) vPro                                                                |
| Graphics         | Integrated Intel HD Graphics 520                                                                          |
| Memory           | 4GB Soldered + 8GB DIMM 2133MHz DDR4, dual-channel                                                        |
| Display          | 14" Full HD (1920x1080) IPS, non-touch                                                                    |
| Storage          | Samsung Evo 970 PRO 500GB NVMe SSD                                                                        |
| Ethernet         | Intel Ethernet Connection I219-LM (Jacksonville)                                                          |
| WLAN + Bluetooth | 11ac+BT, [Broadcom BCM94360CS2](/Guides/Replace-WLAN.md), 2x2 card                                        |
| Camera           | HD720p resolution, low light sensitive, fixed focus                                                       |
| Audio support    | HD Audio, Realtek ALC3245 codec, stereo speakers 1Wx2, dual array microphone, combo audio/microphone jack |
| Keyboard         | 6-row, spill-resistant, multimedia Fn keys, LED backlight                                                 |
| Battery          | Front Li-Polymer 3-cell (23Wh) and rear Li-Ion 3-cell (26Wh), both Integrated                             |

| @mhl221135's Model | Thinkpad T460s 20F90002\*\*                                                                               |
| :----------------- | :-------------------------------------------------------------------------------------------------------- |
| Processor          | Core i5-6300U (2C, 2.4 / 3.0GHz, 3MB)                                                                     |
| Graphics           | Integrated Intel HD Graphics 520                                                                          |
| Memory             | 4GB Soldered + 8GB DIMM 2133MHz DDR4, dual-channel                                                        |
| Display            | 14" Full HD (1920x1080) IPS, Touch (currently not supported)                                              |
| Storage            | Western Digital Black SN750 500GB NVMe SSD                                                                |
| Ethernet           | Intel Ethernet Connection I219-LM (Jacksonville)                                                          |
| WLAN + Bluetooth   | 11ac+BT, Intel® Dual Band Wireless-AC 8265, 2x2 card                                                      |
| Camera             | HD720p resolution, low light sensitive, fixed focus                                                       |
| Audio support      | HD Audio, Realtek ALC3245 codec, stereo speakers 1Wx2, dual array microphone, combo audio/microphone jack |
| Keyboard           | 6-row, spill-resistant, multimedia Fn keys, LED backlight                                                 |
| Battery            | Front Li-Polymer 3-cell (23Wh) and rear Li-Ion 3-cell (26Wh), both Integrated                             |

</details>

<details>  
<summary><strong>Hardware compatibility 🧰</strong></summary>
</br>

This EFI will suit any T460s regardless of CPU model<sup>[1](#CPU)</sup>, amount of RAM, display resolution<sup>[2](#Res)</sup> and internal storage<sup>[3](#NVMe)</sup>.

<a name="CPU">1</a>. Optional custom CPU Power Management guide.  
<a name="Res">2</a>. 1440p displays should change `NVRAM -> Add -> 7C436110-AB2A-4BBB-A880-FE41995C9F82 -> UIScale`:`2` to get proper scaling while booting.  
<a name="NVMe">3</a>. Follow NVMe fix guide below for NVMe drives.

This bootloader configuration will probably suit other 6th generation Thinkpads, but there could be some defacts (i. e. not working usb ports, can't connect any displays.. etc.). If you own a model other then a T460s check out these repositories:
| Maintainer | Model | Bootloader |
| :------------ | ----------: | ---------: |
| MSzturc | [T460](https://github.com/MSzturc/Lenovo-T460-OpenCore) | Opencore |
| duszmox | [X1 Carbon Gen 4](https://github.com/duszmox/ThinkPad-X1C4-macOS-OpenCore) | Opencore |
| Tluck | [T560/T460](https://github.com/tluck/Lenovo-T460-Clover) | Clover |

</details>

## Installation

<details>  
<summary><strong>How to install macOS</strong></summary>
</br>

1. [Create an installation media](https://dortania.github.io/OpenCore-Install-Guide/installer-guide/#making-the-installer)
1. Download the [latest EFI folder](https://github.com/simprecicchiani/ThinkPad-T460s-macOS-OpenCore/releases) and copy it into the ESP partiton
1. Change your BIOS settings according to the table below
1. Boot from the USB installer (press `F12` to choose boot volume) and [start the installation process](https://dortania.github.io/OpenCore-Install-Guide/installation/installation-process.html#booting-the-opencore-usb)

| Menu     |                   |                                 | Setting     |
| -------- | ----------------- | ------------------------------- | ----------- |
| Config   | USB               | UEFI BIOS Support               | `Enable `   |
|          | Power             | Intel SpeedStep Technology      | `Enable `   |
|          |                   | CPU Power Management            | `Enable `   |
|          | CPU               | Hyper-Threading Technology      | `Enable `   |
| Security | Security Chip     |                                 | `Disable `  |
|          | Memory Protection | Execution Prevention            | `Enable `   |
|          | Virtualization    | Intel Virtualization Technology | `Enable `   |
|          |                   | Intel VT-d Feature              | `Enable `   |
|          | Anti-Theft        | Computrace                      | `Disable `  |
|          | Secure Boot       |                                 | `Disable `  |
|          | Intel SGX         |                                 | `Disable `  |
|          | Device Guard      |                                 | `Disable `  |
| Startup  | UEFI/Legacy Boot  |                                 | `UEFI Only` |
|          | CSM Support       |                                 | `No`        |
|          | Boot Mode         |                                 | `Quick`     |

</details>

<details>  
<summary><strong>Enable Apple Services</strong></summary>
</br>

1. Run the following script in Terminal

```bash
git clone https://github.com/corpnewt/GenSMBIOS && cd GenSMBIOS && chmod +x GenSMBIOS.command && ./GenSMBIOS.command
```

2. Type `3` to Generate SMBIOS, then press ENTER
3. Type `MacbookPro13,1 5`, then press ENTER. Leave this Terminal window open.
4. Open `/EFI/OC/Config.plist` with any editor and navigate to `PlatformInfo -> Generic`
5. Add the script's last result to `MLB, SystemSerialNumber and SystemUUID`

```diff
<key>PlatformInfo</key>
<dict>
   <key>Generic</key>
   <array>
      </dict>
         <key>AdviseWindows</key>
         <false/>
         <key>SystemMemoryStatus</key>
         <string>Auto</string>
         <key>MLB</key>
+        <string>M0000000000000001</string>
         <key>ProcessorType</key>
         <integer>0</integer>
         <key>ROM</key>
         <data>ESIzRFVm</data>
         <key>SpoofVendor</key>
         <true/>
         <key>SystemProductName</key>
         <string>MacBookPro13,1</string>
         <key>SystemSerialNumber</key>
+        <string>W00000000001</string>
         <key>SystemUUID</key>
+        <string>00000000-0000-0000-0000-000000000000</string>
      </dict>
   </array>
</dict>
```

6. Save and reboot the system

</details>

<details>  
<summary><strong>How to update the bootloader</strong></summary>
</br>

1. Download the [latest release](https://github.com/simprecicchiani/ThinkPad-T460s-macOS-OpenCore/releases)
1. Copy and Paste your `PlatfromInfo`
1. Enable optional kexts if needed (NVMEFix, AirportItlwm, etc.)
1. Test the new bootloader with an USB stick (Set `BootProtect: None` whenever booting with external drives)
1. Customize boot preferences (skip picker, disable verbose, etc.)
1. Mount your ESP partition
1. Backup your old EFI folder and replace it with the new one

</details>

## Post-install (optional)

<details>  
<summary><strong>Enable Intel WLAN cards</strong></summary>
</br>
Two different drivers are under development for Intel WiFi support: `AirportItlwm.kext` and `AirPortOpenBSD.kext`. Do NOT use them both at the same time.

1. Open `/EFI/OC/Config.plist` with any editor
1. Add the content of [#intel-wlan - macOS 11.plist](/EFI/OC/%23intel-wlan%20-%20macOS%2011.plist) or [#intel-wlan - macOS 12.plist](/EFI/OC/%23intel-wlan%20-%20macOS%2012.plist) according to your macOS version
1. Save and reboot the system

**Note:** The drivers provided in this repo are for Big Sur and Monterey only; if you're running a different version of macOS please use the corresponding [AirportItlwm.kext](https://github.com/OpenIntelWireless/itlwm/releases) or [AirPortOpenBSD.kext](https://github.com/a565109863/AirPortOpenBSD/releases/).


Optional: [Remove unnecessary firmware files from OpenIntelWireless drivers](/Guides/Clean-OpenIntelWireless.md).

</details>

<details>
<summary><strong>Enable non-natively supported Broadcom WLAN cards</strong></summary>
</br>

1. Download [AirportBrcmFixup](https://github.com/acidanthera/AirportBrcmFixup/releases) and
   [BrcmPatchRAM](https://github.com/acidanthera/BrcmPatchRAM/releases).
1. Copy AirportBrcmFixup.kext, BrcmBluetoothInjector.kext, BrcmFirmwareData.kext and BrcmPatchRAM3.kext to `/EFI/OC/Kexts`
1. Open `/EFI/OC/Config.plist` with any editor
1. Add the content of [#broadcom-wlan.plist](/EFI/OC/#broadcom-wlan.plist

1. Save and reboot the system

</details>

<details>  
<summary><strong>Fix NVMe power management</strong></summary>
</br>

1. Open `/EFI/OC/Config.plist` with any editor
1. Add the content of [#nvme-fix.plist](/EFI/OC/#nvme-fix.plist)
1. Save and reboot the system

</details>

<details>  
<summary><strong>Custom CPU Power Management</strong></summary>
</br>

1. Run the following script in Terminal

```bash
git clone https://github.com/corpnewt/CPUFriendFriend; cd CPUFriendFriend; chmod +x ./CPUFriendFriend.command; ./CPUFriendFriend.command
```

1. When asked, select preferred values
1. From the pop-up window, copy `ssdt_data.aml` into `/EFI/OC/ACPI/` folder (rename it if you'd like)
1. Open `/EFI/OC/Config.plist` with any editor
1. Add the content of [#cpu-pm.plist](/EFI/OC/#cpu-pm.plist) (make sure SSDT-PLUG.aml is disabled and match your new SSDT filename)
1. Save and reboot the system

</details>

<details>  
<summary><strong>ThinkPad Dock USB ports mapping</strong></summary>
</br>

I've never had one so there's a chance something might not be working. [USB mapping guide](https://dortania.github.io/OpenCore-Post-Install/usb/).

</details>

## Other tweaks

<details>  
<summary><strong>Enable HiDPI</strong></summary>
</br>

1. [Disable SIP](https://dortania.github.io/OpenCore-Install-Guide/troubleshooting/troubleshooting.html#disabling-sip)
1. Run the following script in Terminal
   ```bash
   bash -c "$(curl -fsSL https://raw.githubusercontent.com/xzhih/one-key-hidpi/master/hidpi.sh)"
   ```
1. Follow the instructions, then reboot
1. Re-enable SIP (if desired)

[Alternative method](https://github.com/bbhardin/A-Guide-to-MacOS-Scaled-Resolutions)

</details>

<details>  
<summary><strong>Enable multimedia keys, fan & LEDs control </strong></summary>
</br>

1. Download and install [YogaSMC-App-Release.dmg](https://github.com/zhen-zen/YogaSMC/releases) (both the pref-panel and app itself)
1. Open the app
1. Check the `launch on login` option

</details>

<details>  
<summary><strong>Use PrtSc key as Screenshot shortcut</strong></summary>
</br>

Super useful shortcut that I wish I had it on my previous MBP. Default is `⌘⇧5`.

1. Open SystemPreferences.app
1. Go under `Keyboard > Shortcuts > Screenshots`
1. Click on `Screenshot and recording options` field
1. Press `PrtSc` on your keyboard (it should came out as `F13`)

</details>

<details>  
<summary><strong>Use calibrated display profile</strong></summary>
</br>

NotebookCheck's calibrated profiles. Not all panel are the same, final result may vary.

1. Run one of the following script in Terminal
   - for 1440p displays
     ```bash
     cd ~/Library/ColorSync/Profiles; wget https://github.com/simprecicchiani/ThinkPad-T460s-macOS-OpenCore/raw/master/Files/DisplayColorProfiles/T460s_WQHD_VVX14T058J02.icm
     ```
   - for 1080p displays
     ```bash
     cd ~/Library/ColorSync/Profiles; wget https://github.com/simprecicchiani/ThinkPad-T460s-macOS-OpenCore/raw/master/Files/DisplayColorProfiles/T460s_FHD_N140HCE_EAA.icm
     ```
2. Go under `SystemPreferences > Displays > Colour`
3. Select the profile

<img src="/Images/display-profile.png" alt="Lenovo Thinkpad T460s macOS Hackintosh OpenCore" height="300">

</details>

<details>
<summary><strong>Add Apple Watch authentication to sudo</strong></summary>
</br>

If you have an Apple Watch and you already [replaced the build in WiFi card](/Guides/Replace-WLAN.md), you could enable authenticating as sudo with you Apple Watch using [pam-watch](https://github.com/biscuitehh/pam-watchid).

1. Download the latest [ZIP file](https://github.com/biscuitehh/pam-watchid/archive/main.zip)
2. Unzip, which by default creates a folder called pam-watchid-main.
3. Open Terminal and install it:

   - `$ cd ~/Downloads/pam-watchid-main`
   - `$ sudo make install`

4. Regsiter the new PAM module for sudo:

   - Edit /etc/pam.d/sudo
   - Add a new line under line 1 (which is a comment) containing:
     ```bash
     auth sufficient pam_watchid.so
     ```

That’s it. Now, whenever you use sudo, you have the option of using your Watch to authenticate.
<img src="/Images/AW-sudo.png" alt="Apple Watch authenticating with sudo" height="300">

   </details>

<details>  
<summary><strong>Monitor temperatures and power consumption</strong></summary>
</br>

1. Download and install [HWMonitor](https://github.com/kzlekk/HWSensors/releases)
1. Check `launch on login` (optional)

</details>

<details>  
<summary><strong>Faster macOS dock animation</strong></summary>
</br>

This enables auto-hide and speeds up the animation

1. Run the following script in Terminal
   ```bash
   defaults write com.apple.dock autohide-delay -float 0; defaults write com.apple.dock autohide-time-modifier -float 0.5; killall Dock
   ```
   </details>

<details>  
<summary><strong>Boot process tweaks</strong></summary>
</br>

| Menu |       |            | Setting    | What does it do?     |
| :--- | :---- | :--------- | :--------- | :------------------- |
| Misc | Boot  | ShowPicker | `False`    | Skip bootloader page |
| UEFI | Audio | PlayChime  | `Disabled` | Always silent boot   |

</details>
<details>  
<summary><strong>Setup Hibernatemode & Sleep at low Battery script</strong></summary>
</br>
<a href="https://www.tonymacx86.com/threads/release-sleeponlowbattery-solb.264785">Script that performs auto sleep/hibernate at low battery</a>
<br><br>
1.Open terminal
<br>
2.Enter commands below one by one
<br>
Settings for AC:

```
sudo pmset -c standby 1
sudo pmset -c hibernatemode 0
```

Setting for battery:

```
sudo pmset -b standby 1
sudo pmset -b standbydelayhigh 900
sudo pmset -b standbydelaylow 60
sudo pmset -b hibernatemode 25
sudo pmset -b highstandbythreshold 70
```

Settings for all:

```
sudo pmset -a acwake 0
sudo pmset -a lidwake 1
sudo pmset -a powernap 0
```

To restore default system settings run `pmset restoredefaults ` command

<details>  
<summary><strong>Commands description</strong></summary>
   
`acwake` - wake the machine when power source (AC/battery) is changed (value = 0/1)

`lidwake` - wake the machine when the laptop lid (or clamshell) is opened (value = 0/1)

`powernap` - enable/disable Power Nap on supported machines (value = 0/1)

`standbydelayhigh` and `standbydelaylow` specify the delay, in seconds,
before writing the hibernation image to disk and powering off memory for Standby.
standbydelayhigh is used when the remaining battery capacity is above `highstandbythreshold`(has a default value of 50 percent),
and standbydelaylow is used when the remaining battery capacity is below highstandbythreshold.

hibernatemode supports values of 0, 3, or 25.

To disable hibernation, set hibernatemode to 0.

`hibernatemode` = 0 by default on desktops. The system will not back memory up to persistent storage. The system must wake from the contents of memory; the system will lose context on power loss.

`hibernatemode` = 3 by default on portables. The system will store a copy of memory to persistent storage (the disk), and will power memory during sleep. The system will wake from memory, unless a power loss forces it to restore from hibernate image.

`hibernatemode` = 25 is only settable via pmset. The system will store a copy of memory to persistent storage (the disk), and will remove power to memory. The system will restore from disk image. If you want "hibernation" - slower sleeps, slower wakes, and better battery life, you should use this setting.<br><br>
[pmset Descriptions Source](https://www.dssw.co.uk/reference/pmset.html)

</details> <br><br>
</details>
<details>  
<summary><strong>BIOS Mod</strong></summary>
</br>

I know it can be scary at first but with the right amount of carefulness anyone can do it.  
Is it worth the effort and risk? I don't think so. I enjoyed it? 100%.  
A [brief guide referencing other guides](/Guides/Bios-Mod.md).

</details>

## Status

<details>  
<summary><strong>What's working ✅</strong></summary>
</br>
 
- [x] CPU Power Management `~1W on IDLE`
- [x] Intel HD 520 Graphics `incuding graphics acceleration`
- [x] USB ports
- [x] Internal camera `working fine on FaceTime, Skype, Zoom and others`
- [x] Sleep / Hibernatemode `25 or 3` / Wake / Shutdown / Reboot
- [x] Intel Gigabit Ethernet
- [x] Wifi, Bluetooth, Airdrop, Handoff, Continuity, Sidecar wireless `some functionalities may be buggy or broken on Intel WLAN cards`
- [x] iMessage, FaceTime, App Store, iTunes Store `Please generate your own SMBIOS`
- [x] Speakers and headphones combo jack 
- [x] Batteries
- [x] Keyboard map and hotkeys with [YogaSMC](https://github.com/zhen-zen/YogaSMC)
- [x] [Trackpad, Trackpoint and physical buttons](/Images/VoodooRMI-T460s-trackpad-gestures.gif) `all macOS gestures working thanks to VoodooRMI`
- [x] SIP and FileVault 2 can be turned on
- [x] HDMI `with digital audio passthrough`
- [x] SD Card Reader `slow r/w speed but works`

</details>

<details>  
<summary><strong>What's not working ⚠️</strong></summary>
</br>

- [ ] Some users reported Mini DisplayPort is broken for them with latest updates, but it's working for me just fine
- [ ] Safari DRM `Use Chromium engine to watch Apple TV+, Amazon Prime Video, Netflix and others`
- [ ] WWAN (needs to be implemented)
- [ ] Fingerprint Reader
- [ ] Touchscreen

</details>

<details>  
<summary><strong>Update tracker 🔄</strong></summary>
</br>

| [EFI Release](https://github.com/simprecicchiani/ThinkPad-T460s-macOS-OpenCore/releases)       | 0.7.1 |
| :--------------------------------------------------------------------------------------------- | :---- |
| [MacOS](https://www.apple.com/macos/)                                                          | 11.4 / 12 beta-2  |
| [OpenCore](https://github.com/acidanthera/OpenCorePkg/releases)                                | 0.7.1 |
| [Lilu](https://github.com/acidanthera/Lilu/releases)                                           | 1.5.4 |
| [VirtualSMC](https://github.com/acidanthera/VirtualSMC/releases)                               | 1.2.5 |
| [YogaSMC](https://github.com/zhen-zen/YogaSMC/releases)                                        | 1.5.1 |
| [WhateverGreen](https://github.com/acidanthera/WhateverGreen/releases)                         | 1.5.1 |
| [AppleALC](https://github.com/acidanthera/AppleALC/releases)                                   | 1.6.2 |
| [VoodooPS2Controller](https://github.com/acidanthera/VoodooPS2/releases)                       | 2.2.4 |
| [VoodooRMI](https://github.com/VoodooSMBus/VoodooRMI/releases)                                 | 1.3.3 |
| [IntelMausi](https://github.com/acidanthera/IntelMausi/releases)                               | 1.0.7 |
| [HibernationFixup](https://github.com/acidanthera/HibernationFixup/releases)                   | 1.4.1 |
| [CPUFriend](https://github.com/acidanthera/CPUFriend/releases)                                 | 1.2.4 |
| [NVMeFix](https://github.com/acidanthera/NVMeFix/releases)                                     | 1.0.9 |
| [RTCMemoryFixup](https://github.com/acidanthera/RTCMemoryFixup/releases)                       | 1.0.7 |
| [AirPortOpenBSD](https://github.com/a565109863/AirPortOpenBSD/releases/)                       | 2.0.6 |
| [AirportItlwm](https://github.com/OpenIntelWireless/itlwm/releases)                            | 2.0.0b |
| [IntelBluetoothFirmware](https://github.com/OpenIntelWireless/IntelBluetoothFirmware/releases) | 2.0.0RC-1 |
| [AppleBacklightSmoother](https://github.com/hieplpvip/AppleBacklightSmoother/releases)         | 1.0.2 |
| [BrightnessKeys](https://github.com/acidanthera/BrightnessKeys/releases)                       | 1.0.2 |
| [Sinetek-rtsx](https://github.com/cholonam/Sinetek-rtsx/releases)                              | 9.0   |

</details>

## Performances

<details>  
<summary><strong>Power consumption & thermals 🔥</strong></summary>
</br>

| Idle State                | Max Frequency                 | 2 Thread Frequency            | All Thread Frequency          | GPU Max Frequency             |
| ------------------------- | ----------------------------- | ----------------------------- | ----------------------------- | ----------------------------- |
| ![](/Images/ipg-idle.png) | ![](/Images/ipg-max-freq.png) | ![](/Images/ipg-two-freq.png) | ![](/Images/ipg-all-freq.png) | ![](/Images/ipg-gpu-freq.png) |

</details>

<details>  
<summary><strong>Benchmarks ⏱</strong></summary>
</br>

| CPU            | Single-Core | Multi-Core |
| :------------- | ----------: | ---------: |
| Cinebench r20  |         348 |        842 |
| Geekbench 5    |         809 |       1862 |
| **GPU**        |  **OpenCL** |  **Metal** |
| Geekbench 5    |        4417 |       4179 |
| BruceX Test 5K |             |      104'' |

<small>macOS 10.15.7, EFI release 0.6.2</small>

| CPU           | Single-Core | Multi-Core |
| :------------ | ----------: | ---------: |
| Cinebench r23 |             |       2175 |

<small>macOS 11.1, EFI release 0.6.5</small>

</details>

## Thanks to

[Simone](https://github.com/simprecicchiani), the original maintainer of this repo,
the hackintosh community on GitHub,
[InsanelyMac](https://www.insanelymac.com/forum/), and
[r/hackintosh](https://www.reddit.com/r/hackintosh/).
