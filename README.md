# ThinkPad T460s running macOS (OpenCore bootloader)

<img align="right" src="https://imgur.com/sI2Uzel.jpg" alt="T460s macOS" width="300">

[![macOS](https://img.shields.io/badge/macOS-Catalina%20%26%20Big%20Sur-blue)](https://developer.apple.com/documentation/macos-release-notes)
[![OpenCore](https://img.shields.io/badge/OpenCore-0.6.2-green)](https://github.com/acidanthera/OpenCorePkg)
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
<summary><strong>Getting started</strong></summary>
</br>

**Meet the bootloader:**

- [Why OpenCore](https://dortania.github.io/OpenCore-Install-Guide/why-oc.html)
- Dortania's [website](https://dortania.github.io)

**Recommended tools:**

- Plist editor [ProperTree](https://github.com/corpnewt/ProperTree)
- Handy-dandy ESP partition mounting script [MountEFI](https://github.com/corpnewt/MountEFI)

</details>

<details>  
<summary><strong>My Hardware</strong></summary>
</br>

| Model              | Thinkpad T460s 20F9003AUS                                                                                 |
|:-------------------|:----------------------------------------------------------------------------------------------------------|
| Processor          | Core i7-6600U (2C, 2.6 / 3.4GHz, 4MB) vPro                                                                |
| Graphics           | Integrated Intel HD Graphics 520                                                                          |
| Memory             | 4GB Soldered + 4GB DIMM 2133MHz DDR4, dual-channel                                                        |
| Display            | 14" WQHD (2560x1440) IPS, non-touch                                                                       |
| Storage            | SanDisk SD8TN8U256G1001 256GB SSD M.2 Opal2                                                               |
| Ethernet           | Intel Ethernet Connection I219-LM (Jacksonville)                                                          |
| WLAN + Bluetooth   | 11ac+BT, [Broadcom BCM94360CS2](/Guides/Replace-WLAN.md), 2x2 card                                        |
| Camera             | HD720p resolution, low light sensitive, fixed focus                                                       |
| Audio support      | HD Audio, Realtek ALC3245 codec, stereo speakers 1Wx2, dual array microphone, combo audio/microphone jack |
| Keyboard           | 6-row, spill-resistant, multimedia Fn keys, LED backlight                                                 |
| Battery            | Front Li-Polymer 3-cell (23Wh) and rear Li-Ion 3-cell (26Wh), both Integrated                             |

</details>

<details>  
<summary><strong>Hardware compatibility</strong></summary>
</br>

This EFI will suit any T460s regardless of CPU model<sup>[1](#CPU)</sup>, amount of RAM, display resolution<sup>[2](#Res)</sup> and internal storage<sup>[3](#NVMe)</sup>.

<a name="CPU">1</a>. Optional custom CPU Power Management guide  
<a name="Res">2</a>. 1440p display models should change `NVRAM -> Add -> 7C436110-AB2A-4BBB-A880-FE41995C9F82 -> UIScale`:`2` to get proper scaling while booting  
<a name="NVMe">3</a>. Enable [NVMeFix](https://github.com/acidanthera/NVMeFix) for NVMe drives

</details>

<details>  
<summary><strong>How this repo is updated</strong></summary>
</br>

After many hours of testing back in April and May 2020, I now consider this configuration stable.  
This is the process I go through each time OpenCore gets an update (usually every first monday of the month):

1. Read release article on Dortania's website
1. Download all updated resources
1. Read new Documentation if relevant changes took place
1. Get a fresh Sample.plist to avoid missing new stuff
1. Copy and Paste SSDT, Patches and Kexts
1. Set T460s' config options
1. Booloader test on USB stick
1. Clean my SMBIOS and upload on GitHub
1. Add changelog and update status in README

Basically I do the boring part so one can easily download the EFI folder and play with it in minutes.

</details>

## Installation
<details>  
<summary><strong>How to install macOS</strong></summary>
</br>

1. [Create an installation media](https://dortania.github.io/OpenCore-Install-Guide/installer-guide/#making-the-installer)
1. Download the [latest EFI folder](https://github.com/simprecicchiani/ThinkPad-T460s-macOS-OpenCore/releases) and copy it into the ESP partiton
1. Change your BIOS settings according to the table below
1. Boot from the USB installer and [start the installation process](https://dortania.github.io/OpenCore-Install-Guide/installation/installation-process.html#booting-the-opencore-usb)

| Menu     |                   |                                 | Setting     |
|----------|-------------------|---------------------------------|-------------|
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
<summary><strong>How to update the bootloader</strong></summary>
</br>

1. Download the [latest release](https://github.com/simprecicchiani/ThinkPad-T460s-macOS-OpenCore/releases)
1. Copy and Paste your `PlatfromInfo`
1. Enable optional kexts if needed (NVMEFix, AirportItlwm, etc.)
1. Test the new bootloader with an USB stick
1. Customize boot preferences (skip picker, disable verbose, etc.)
1. Mount your ESP partition
1. Backup your old EFI folder and replace it with the new one

</details>

<details>  
<summary><strong>How to upgrade to macOS 11.0 Big Sur</strong></summary>
</br>

**WARNING**: Big Sur is in beta. While potentially compatible, the configuration is not developed for it.  

Inside `config.plist` set `SecureBootModel=Disabled` as of #35 .

</details>

## Post-install

<details>  
<summary><strong>Enable Apple Services</strong></summary>
</br>

1. Run the following script in Terminal
   ```bash
   git clone https://github.com/corpnewt/GenSMBIOS && cd GenSMBIOS && ./GenSMBIOS.command 
   ```
1. Type `3`, then press ENTER
1. Type `MacbookPro13,1 5`, then press ENTER
1. Open `Config.plist` with any editor, navigate to `PlatformInfo > Generic`
1. From the previous script, add the last results to `MLB, SystemSerialNumber and SystemUUID`

</details>

<details>  
<summary><strong>Enable Intel WLAN (optional)</strong></summary>
<img align="right" src="/Images/enable-intel-wlan.jpg" alt="T460s macOS" height="150">
</br>

1. Open `Config.plist` with any editor
1. Go under `Kernel -> Add`
1. Find and Enable `AirportItlwm.kext`, `IntelBluetoothFirmware.kext` and `IntelBluetoothInjector.kext`
1. Save and reboot the system

</details>

<details>  
<summary><strong>Fix NVMe power management (optional)</strong></summary>
<img align="right" src="/Images/enable-nvme-fix.jpg" alt="T460s macOS" height="150">
</br>

1. Open `Config.plist` with any editor
1. Go under `Kernel -> Add`
1. Find and Enable `NVMeFix.kext`
1. Save and reboot the system

</details>

<details>  
<summary><strong>Custom CPU Power Management (optional)</strong></summary>
<img align="right" src="/Images/add-frequency-ssdt.jpg" alt="T460s macOS" height="150">  
<img align="right" src="/Images/enable-cpu-friend.jpg" alt="T460s macOS" height="150">
</br>

1. Launch Terminal.app
1. Copy the following script, paste it into the Terminal window, then press ENTER  
   ```bash
   git clone https://github.com/fewtarius/CPUFriendFriend; cd CPUFriendFriend; chmod +x ./CPUFriendFriend.command; ./CPUFriendFriend.command
   ```
1. When asked, select preferred values
1. From the pop-up window, copy `ssdt-data.aml` into `/EFI/OC/ACPI/` folder
1. Open `Config.plist` with any editor 
1. Go under `ACPI -> Add` and change `SSDT-PLUG.aml` with `ssdt-data.aml`
1. Go under `Kernel -> Add` and set `CPUFriend.kext` to `Enabled: True`

This my machine's power consumption when idling:

<img src="/Images/PowerConsumption.png" alt="T460s macOS" width="300">

</details>

<details>  
<summary><strong>USB ports mapping (optional)</strong></summary>
</br>

For ThinkPad's dock only, use one of following methods:

- [USBMap by CorpNewt](https://github.com/corpnewt?tab=repositories)
- [Native USB fix without injector kext](https://www.olarila.com/topic/6878-guide-native-usb-fix-for-notebooks-no-injectorkext-required/?tab=comments#comment-88412)

</details>

## Other tweaks

<details>  
<summary><strong>Enable HiDPI</strong></summary>
</br>

1. [Disable SIP](https://dortania.github.io/OpenCore-Install-Guide/troubleshooting/troubleshooting.html#disabling-sip)
1. Launch Terminal.app
1. Copy the following script, paste it into the Terminal window, then press ENTER
   ```bash
   bash -c "$(curl -fsSL https://raw.githubusercontent.com/xzhih/one-key-hidpi/master/hidpi.sh)"
   ```
1. Follow the script instructions, then reboot
1. Enable SIP (if desired)
</details>

<details>  
<summary><strong>Enable multimedia keys</strong></summary>
</br>

Thanks to [@MSzturc](https://github.com/MSzturc) for providing the keyboard map and ThinkpadAssistant app

1. Download and install [ThinkpadAssistant](https://github.com/MSzturc/ThinkpadAssistant/releases)
1. Open the app
1. Check the `launch on login` option

</details>

<details>  
<summary><strong>Use PrtSc key as Screenshot shortcut</strong></summary>
<img align="right" src="/Images/Shortcut.png" alt="T460s macOS" height="150">
</br>

1. Open SystemPreferences.app
1. Go under ` Keyboard > Shortcuts > Screenshots` 
1. Click on `Screenshot and recording options` key map
1. Press `PrtSc` on your keyboard (it should came out as `F13`)

</details>

<details>  
<summary><strong>Use calibrated display profile</strong></summary>
<img align="right" src="/Images/DisplayProfile.png" alt="T460s macOS" height="150">
</br>

These profiles are from NotebookCheck. Not all panel are the same so final result may vary.

1. Launch Terminal.app
1. Copy the following script, paste it into the Terminal window, then press ENTER
    - for 1440p displays
        ```bash
        cd ~/Library/ColorSync/Profiles; wget https://github.com/simprecicchiani/ThinkPad-T460s-macOS-OpenCore/blob/master/Files/DisplayProfiles/T460s_WQHD_VVX14T058J02.icm
        ```
   - for 1080p displays
        ```bash
        cd ~/Library/ColorSync/Profiles; wget https://github.com/simprecicchiani/ThinkPad-T460s-macOS-OpenCore/blob/master/Files/DisplayProfiles/T460s_FHD_N140HCE_EAA.icm
        ```
1. Go under `SystemPreferences > Displays > Colour`
1. Select the calibrated profile

</details>

<details>  
<summary><strong>Monitor temperatures and power consumption</strong></summary>
</br>

1. Download and install [HWMonitor](https://github.com/kzlekk/HWSensors/releases)
1. Open the app
1. Check the `launch on login` option

</details> 

<details>  
<summary><strong>Faster macOS dock animation</strong></summary>
</br>

This enables auto-hide and speeds up the animation

1. Launch Terminal.app
1. Copy the following script, paste it into the Terminal window, then press ENTER
   ```bash
   defaults write com.apple.dock autohide-delay -float 0; defaults write com.apple.dock autohide-time-modifier -float 0.5; killall Dock
   ```
</details>

<details>  
<summary><strong>Speed-up boot process</strong></summary>
</br>

Once you get everything up and running it's possible to disable some options inside `config.plist` to get a faster and cleaner boot.

| Menu  |       |                                      | Setting     |
|-------|-------|--------------------------------------|-------------|
| Misc  | Boot  | ShowPicker                           | `False`     |
|       | Debug | AppleDebug                           | `False`     |
|       |       | ApplePanic                           | `False`     |
|       |       | DisableWatchDog                      | `False`     |
|       |       | Target                               | `0`         |
| NVRAM | Add   | 7C436110-AB2A-4BBB-A880-FE41995C9F82 | Delete `-v` |

</details>

<details>  
<summary><strong>BIOS Mod</strong></summary>
</br>

I know it can be scary at first. But with the right amount of carefulness anyone could do it.  
Is it worth the effort and risk? I don't think so. I enjoyed it? 100%.  
[Guide in progress](/Guides/Bios-Mod.md)

</details>

## Status
<details>  
<summary><strong>What's working ✅</strong></summary>
</br>
 
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
</br>

- [ ] Internal monitor turns black when external is connected
- [ ] Safari DRM
- [ ] WWAN (needs to be implemented)
- [ ] Fingerprint Reader

</details>

<details>  
<summary><strong>Update tracker 🔄</strong></summary>
</br>

| Version                                                                                        | [Stable](/EFI) | 
|:-----------------------------------------------------------------------------------------------|---------------:|
| [MacOS](https://www.apple.com/macos/)                                                          | 10.15.7 / 11.0 |
| [OpenCore](https://github.com/acidanthera/OpenCorePkg/releases)                                | 0.6.2          | 
| [Lilu](https://github.com/acidanthera/Lilu/releases)                                           | 1.4.8          | 
| [VirtualSMC](https://github.com/acidanthera/VirtualSMC/releases)                               | 1.1.7          | 
| [WhateverGreen](https://github.com/acidanthera/WhateverGreen/releases)                         | 1.4.3          | 
| [AppleALC](https://github.com/acidanthera/AppleALC/releases)                                   | 1.5.3          | 
| [VoodooPS2Controller](https://github.com/acidanthera/VoodooPS2/releases)                       | 2.1.7          |
| [VoodooRMI](https://github.com/VoodooSMBus/VoodooRMI/releases)                                 | 1.2            |
| [IntelMausi](https://github.com/acidanthera/IntelMausi/releases)                               | 1.0.4          |
| [HibernationFixup](https://github.com/acidanthera/HibernationFixup/releases)                   | 1.3.6          |
| [CPUFriend](https://github.com/acidanthera/CPUFriend/releases)                                 | 1.2.2          |
| [NVMeFix](https://github.com/acidanthera/NVMeFix/releases)                                     | 1.0.4          |
| [AirportItlwm](https://github.com/OpenIntelWireless/itlwm/releases)                            | 1.0            |
| [IntelBluetoothFirmware](https://github.com/OpenIntelWireless/IntelBluetoothFirmware/releases) | 1.1.2          |
| [Sinetek-rtsx](https://github.com/cholonam/Sinetek-rtsx/releases)                              | 2.2            |

</details>

<details>  
<summary><strong>Benchmarks ⏱</strong></summary>
</br>

| CPU            | Single-Core | Multi-Core |
|:---------------|------------:|-----------:|
| Cinebench r20  | 348         | 842        |
| Geekbench 5    | 809         | 1862       |
| **GPU**        | **OpenCL**  | **Metal**  |
| Geekbench 5    | 4417        | 4179       |
| BruceX Test 5K |             | 104''      |

<small>macOS 10.15.7, EFI release 0.6.2</small>
</details>

## Thanks to

The hackintosh community on GitHub,
[InsanelyMac](https://www.insanelymac.com/forum/), and
[r/hackintosh](https://www.reddit.com/r/hackintosh/).
