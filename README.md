# ThinkPad T460s running macOS (OpenCore bootloader)

<img align="right" src="https://imgur.com/sI2Uzel.jpg" alt="Lenovo Thinkpad T460s macOS Hackintosh OpenCore" width="300">

[![macOS](https://img.shields.io/badge/macOS-11.1-blue)](https://developer.apple.com/documentation/macos-release-notes)
[![OpenCore](https://img.shields.io/badge/OpenCore-0.6.5-green)](https://github.com/acidanthera/OpenCorePkg)
[![Model](https://img.shields.io/badge/Model-20F9003AUS-lightgrey)](https://psref.lenovo.com/Product/ThinkPad_T460s)
[![BIOS](https://img.shields.io/badge/BIOS-1.49-lightgrey)](https://pcsupport.lenovo.com/us/en/products/laptops-and-netbooks/thinkpad-t-series-laptops/thinkpad-t460s/downloads/driver-list/component?name=BIOS%2FUEFI)
[![License](https://img.shields.io/badge/license-MIT-purple)](/LICENSE)

**DISCLAIMER:**
Read the entire README before you start.
I am not responsible for any damages you may cause.  
Should you find an error or improve anything — whether in the config or in the documentation — please consider opening an issue or pull request.  
If you find my work useful, please consider donating via PayPal.
It would mean a lot to me.

[![donate](https://img.shields.io/badge/-buy%20me%20a%20coffee-orange)](https://www.paypal.com/cgi-bin/webscr?cmd=_s-xclick&hosted_button_id=Y5BE5HYACDERG&source=url)

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
<summary><strong>My Hardware 💻</strong></summary>
</br>

| Model              | Thinkpad T460s 20F9003AUS                                                                                 |
|:-------------------|:----------------------------------------------------------------------------------------------------------|
| Processor          | Core i7-6600U (2C, 2.6 / 3.4GHz, 4MB) vPro                                                                |
| Graphics           | Integrated Intel HD Graphics 520                                                                          |
| Memory             | 4GB Soldered + 4GB DIMM 2133MHz DDR4, dual-channel                                                        |
| Display            | 14" WQHD (2560x1440) IPS, non-touch                                                                       |
| Storage            | WD Black SN750 500GB NVMe SSD                                                                             |
| Ethernet           | Intel Ethernet Connection I219-LM (Jacksonville)                                                          |
| WLAN + Bluetooth   | 11ac+BT, [Broadcom BCM94360CS2](/Guides/Replace-WLAN.md), 2x2 card                                        |
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
<a name="Res">2</a>. 1440p display models should change `NVRAM -> Add -> 7C436110-AB2A-4BBB-A880-FE41995C9F82 -> UIScale`:`2` to get proper scaling while booting.  
<a name="NVMe">3</a>. Enable [NVMeFix](https://github.com/acidanthera/NVMeFix) for NVMe drives.

</details>

## Installation
<details>  
<summary><strong>How to install macOS</strong></summary>
</br>

1. [Create an installation media](https://dortania.github.io/OpenCore-Install-Guide/installer-guide/#making-the-installer)
1. Download the [latest EFI folder](https://github.com/simprecicchiani/ThinkPad-T460s-macOS-OpenCore/releases) and copy it into the ESP partiton
1. Change your BIOS settings according to the table below
1. Boot from the USB installer (F12 to choose boot volume) and [start the installation process](https://dortania.github.io/OpenCore-Install-Guide/installation/installation-process.html#booting-the-opencore-usb)

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
1. Test the new bootloader with an USB stick (Set `BootProtect: None` whenever booting with external drives)
1. Customize boot preferences (skip picker, disable verbose, etc.)
1. Mount your ESP partition
1. Backup your old EFI folder and replace it with the new one

</details>

## Post-install

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
<summary><strong>Enable Intel WLAN & BLUETOOTH (optional) method 1</strong></summary>

</br>

1. Open `/EFI/OC/Config.plist` with any editor 
2. Go under `Kernel -> Add` and enable `AirportItlwm.kext`, `IntelBluetoothFirmware.kext` and `IntelBluetoothInjector.kext`
```diff
<key>Kernel</key>
<dict>
   <key>Add</key>
   <array>
      </dict>
         <key>Arch</key>
         <string>x86_64</string>
         <key>BundlePath</key>
         <string>AirportItlwm.kext</string>
         <key>Comment</key>
         <string>Intel WiFi driver</string>
         <key>Enabled</key>
-        <false/>
+        <true/>
         <key>ExecutablePath</key>
         <string>Contents/MacOS/AirportItlwm</string>
         <key>MaxKernel</key>
         <string></string>
         <key>MinKernel</key>
         <string></string>
         <key>PlistPath</key>
         <string>Contents/Info.plist</string>
      </dict>
      </dict>
         <key>Arch</key>
         <string>x86_64</string>
         <key>BundlePath</key>
         <string>IntelBluetoothFirmware.kext</string>
         <key>Comment</key>
         <string>Intel Bluetooth driver</string>
         <key>Enabled</key>
-        <false/>
+        <true/>
         <key>ExecutablePath</key>
         <string>Contents/MacOS/IntelBluetoothFirmware</string>
         <key>MaxKernel</key>
         <string></string>
         <key>MinKernel</key>
         <string></string>
         <key>PlistPath</key>
         <string>Contents/Info.plist</string>
      </dict>
      </dict>
         <key>Arch</key>
         <string>x86_64</string>
         <key>BundlePath</key>
         <string>IntelBluetoothInjector.kext</string>
         <key>Comment</key>
         <string>Intel Bluetooth driver companion</string>
         <key>Enabled</key>
-        <false/>
+        <true/>
         <key>ExecutablePath</key>
         <string></string>
         <key>MaxKernel</key>
         <string></string>
         <key>MinKernel</key>
         <string></string>
         <key>PlistPath</key>
         <string>Contents/Info.plist</string>
      </dict>
   </array>
</dict>
```
3. Save and reboot the system

Note: The driver provided in this repo is for Big Sur only; if you're running a different version of macOS please use the corresponding [AirportItlwm.kext](https://github.com/OpenIntelWireless/itlwm/releases).

<details>  
<summary><strong>Remove unnecessary WIFI firmware files from method 1(optional)</strong></summary>

</br>
This steps help you a little speed up boot process (if you use `itlwm` or `AirportItlwm`)

1. Clone the repo: `git clone https://github.com/OpenIntelWireless/itlwm.git`
2. Open the folder where it's cloned to
3. Open Xcode, press File -New -File.. on the Search bar/Filter type `shell` and choose to create a new shell script file
4. Copy this code below into it;

```shell
#!/bin/bash

# remove all local changes
git reset --hard HEAD
rm -rf build

# pull latest code
git pull

# remove generated firmware
rm include/FwBinary.cpp

# remove firmware for other wifi cards - DELETE OR CHANGE TO YOUR CARD
find itlwm/firmware/ -type f ! -name 'iwm-7265-*' -delete


# generate firmware
xcodebuild -project itlwm.xcodeproj -target fw_gen -configuration Release -sdk macosx

# build the kexts
## 1. itlwm.kext
xcodebuild -project itlwm.xcodeproj -target itlwm -configuration Release -sdk macosx

## 2. AirportItlwm Mojave
xcodebuild -project itlwm.xcodeproj -target AirportItlwm-Mojave -configuration Release -sdk macosx

## 3. AirportItlwm Catalina
xcodebuild -project itlwm.xcodeproj -target AirportItlwm-Catalina -configuration Release -sdk macosx

## 4. AirportItlwm Big Sur
xcodebuild -project itlwm.xcodeproj -target AirportItlwm-Big\ Sur -configuration Release -sdk macosx

# Location of Kexts
echo "You kexts are in build/Release!!"
echo " "
```

5. Change line 14: `find itlwm/firmware/ -type f ! -name 'iwm-7265-*' -delete`

    change `iwm-7265` to your firmware name and save the file.

    If your card is AC8260 you need to replace 
    `find itlwm/firmware/ -type f ! -name 'iwm-7265-*' -delete`
    by
    `find itlwm/firmware/ -type f ! -name 'iwm-8000C*' -delete`
    
    This part of code remove other firmware files from `/itlwm/itlwm/firmware`
    
    Also [here](https://www.intel.com/content/www/us/en/support/articles/000005511/network-and-io/wireless.html) you can find your card firmware name

6. Place the file in the root directory of the cloned itlwm folder.
7. Clone MacKernelSDK `git clone https://github.com/acidanthera/MacKernelSDK.git` and place it's folder inside itlwm folder
8. Run the script with sh command.
   Ex: `sh script-name.sh` where 'script-name' is the name of the shell script you made.

Done, you'll find your kexts under build/Release

DON'T USE BOTH `itlwm` and `airportitlwm` IN THE SAME TIME.

Thanks: [@racka98](https://github.com/racka98)
Source issue: [#353](https://github.com/OpenIntelWireless/itlwm/issues/353#issuecomment-727190996)

</details>

<details>  
<summary><strong>Remove unnecessary Bluetooth firmware files from method 1 (optional)</strong></summary>

</br>
This steps help you a little speed up boot process (if you use <a href="https://github.com/OpenIntelWireless/IntelBluetoothFirmware">IntelBluetoothFirmware</a> kexts)

1. Clone the repo: `git clone https://github.com/OpenIntelWireless/IntelBluetoothFirmware.git`
2. Open the folder where it's cloned to
3. Open Xcode, press File -New -File.. on the Search bar/Filter type `shell` and choose to create a new shell script file
4. Copy this code below into it;

```shell
#!/bin/bash

# remove all local changes
git reset --hard HEAD
rm -rf build

# pull latest code
git pull

# remove generated firmware
rm IntelBluetoothFirmware/FwBinary.cpp

# remove firmware for other wifi cards - DELETE OR CHANGE TO YOUR CARD
find IntelBluetoothFirmware/fw/ -type f ! -name 'ibt-11-5*' -delete


# generate firmware
xcodebuild -project IntelBluetoothFirmware.xcodeproj -target fw_gen -configuration Release -sdk macosx

# build the kexts
## 1. IntelBluetoothFirmware.kext
xcodebuild -project IntelBluetoothFirmware.xcodeproj -target IntelBluetoothFirmware -configuration Release -sdk macosx

# build the kexts
## 2. IntelBluetoothInjector.kext
xcodebuild -project IntelBluetoothFirmware.xcodeproj -target IntelBluetoothInjector -configuration Release -sdk macosx

# Location of Kexts
echo "You kexts are in build/Release!!"
echo " "
```

5. Change line 14: `find IntelBluetoothFirmware/fw/ -type f ! -name 'ibt-11-5*' -delete`

    change `ibt-11-5*` to your firmware name and save the file.

    If your card is AC8260 you no need to change this line 

    This part of code remove other firmware files from `IntelBluetoothFirmware/IntelBluetoothFirmware/fw/`
    
    Also [here](https://packages.debian.org/sid/firmware-iwlwifi) you can find your bluetooth firmware name

6. Place the file in the root directory of the cloned IntelBluetoothFirmware folder.
7. Clone MacKernelSDK `git clone https://github.com/acidanthera/MacKernelSDK.git` and place it's folder inside itlwm folder
8. Run the script with sh command.
   Ex: `sh script-name.sh` where 'script-name' is the name of the shell script you made.

Done, you'll find your kexts under build/Release

Thanks [@racka98](https://github.com/racka98) for the idea.

</details>

</details>

</details>

<details>
<summary><strong>Enable Intel WLAN (optional) method 2</strong></summary>
</br>

1. Open `/EFI/OC/Config.plist` with any editor 
2. Go under `Kernel -> Add`
3. change `AirportItlwm.kext` to `AirPortOpenBSD.kext`
4. change `Contents/MacOS/AirportItlwm` to `Contents/MacOS/AirPortOpenBSD`
```diff
<key>Kernel</key>
<dict>
   <key>Add</key>
   <array>
      </dict>
         <key>Arch</key>
         <string>x86_64</string>
         <key>BundlePath</key>
-        <string>AirportItlwm.kext</string>
+	       <string>AirPortOpenBSD.kext</string>
         <key>Comment</key>
         <string>Intel WiFi driver</string>
         <key>Enabled</key>
-        <false/>
+        <true/>
         <key>ExecutablePath</key>
-        <string>Contents/MacOS/AirportItlwm</string>
+	       <string>Contents/MacOS/AirPortOpenBSD</string>
         <key>MaxKernel</key>
         <string></string>
         <key>MinKernel</key>
         <string></string>
         <key>PlistPath</key>
         <string>Contents/Info.plist</string>
      </dict>

   </array>
</dict>
```
5. Save and reboot the system

Note: The driver provided in this repo is for Big Sur only; if you're running a different version of macOS please use the corresponding [AirPortOpenBSD.kext](https://github.com/a565109863/AirPortOpenBSD/releases/).

</details>

<details>
<summary><strong>Enable non-natively supported Broadcom WLAN cards (optional)</strong></summary>
</br>

1. Download [AirportBrcmFixup](https://github.com/acidanthera/AirportBrcmFixup/releases) and
[BrcmPatchRAM](https://github.com/acidanthera/BrcmPatchRAM/releases).
1. Copy AirportBrcmFixup.kext, BrcmBluetoothInjector.kext, BrcmFirmwareData.kext and BrcmPatchRAM3.kext to `EFI\OC\kexts`
1. Open `/EFI/OC/Config.plist` with any editor 
1. Go under `Kernel -> Add` and add the following entries

```
<key>Kernel</key>
<dict>
   <key>Add</key>
   <array>
		<dict>
			<key>Arch</key>
			<string>Any</string>
			<key>BundlePath</key>
			<string>AirportBrcmFixup.kext</string>
			<key>Comment</key>
			<string>DW1560 WiFi driver</string>
			<key>Enabled</key>
			<true/>
			<key>ExecutablePath</key>
			<string>Contents/MacOS/AirportBrcmFixup</string>
			<key>MaxKernel</key>
			<string></string>
			<key>MinKernel</key>
			<string></string>
			<key>PlistPath</key>
			<string>Contents/Info.plist</string>
		</dict>
		<dict>
			<key>Arch</key>
			<string>Any</string>
			<key>BundlePath</key>
			<string>AirportBrcmFixup.kext/Contents/PlugIns/AirPortBrcm4360_Injector.kext</string>
			<key>Comment</key>
			<string>DW1560 WiFi 4360 plug-in</string>
			<key>Enabled</key>
			<false/>
			<key>ExecutablePath</key>
			<string></string>
			<key>MaxKernel</key>
			<string></string>
			<key>MinKernel</key>
			<string></string>
			<key>PlistPath</key>
			<string>Contents/Info.plist</string>
		</dict>
		<dict>
			<key>Arch</key>
			<string>Any</string>
			<key>BundlePath</key>
			<string>AirportBrcmFixup.kext/Contents/PlugIns/AirPortBrcmNIC_Injector.kext</string>
			<key>Comment</key>
			<string>DW1560 WiFi NIC plug-in</string>
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
		<dict>
			<key>Arch</key>
			<string>x86_64</string>
			<key>BundlePath</key>
			<string>BrcmBluetoothInjector.kext</string>
			<key>Comment</key>
			<string>DW1560 BT 1 of 3</string>
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
		<dict>
			<key>Arch</key>
			<string>x86_64</string>
			<key>BundlePath</key>
			<string>BrcmFirmwareData.kext</string>
			<key>Comment</key>
			<string>DW1560 BT 2 of 3</string>
			<key>Enabled</key>
			<true/>
			<key>ExecutablePath</key>
			<string>Contents/MacOS/BrcmFirmwareData</string>
			<key>MaxKernel</key>
			<string></string>
			<key>MinKernel</key>
			<string></string>
			<key>PlistPath</key>
			<string>Contents/Info.plist</string>
		</dict>
		<dict>
			<key>Arch</key>
			<string>x86_64</string>
			<key>BundlePath</key>
			<string>BrcmPatchRAM3.kext</string>
			<key>Comment</key>
			<string>DW1560 BT 3 of 3</string>
			<key>Enabled</key>
			<true/>
			<key>ExecutablePath</key>
			<string>Contents/MacOS/BrcmPatchRAM3</string>
			<key>MaxKernel</key>
			<string></string>
			<key>MinKernel</key>
			<string></string>
			<key>PlistPath</key>
			<string>Contents/Info.plist</string>
		</dict>
   </array>
</dict>
```


</details>


<details>  
<summary><strong>Fix NVMe power management (optional)</strong></summary>
</br>

1. Open `/EFI/OC/Config.plist` with any editor 
2. Go under `Kernel -> Add` and enable `NVMeFix.kext`
```diff
<key>Kernel</key>
<dict>
   <key>Add</key>
   <array>
      </dict>
         <key>Arch</key>
         <string>x86_64</string>
         <key>BundlePath</key>
         <string>NVMeFix.kext</string>
         <key>Comment</key>
         <string>NVMe power management</string>
         <key>Enabled</key>
-        <false/>
+        <true/>
         <key>ExecutablePath</key>
         <string>Contents/MacOS/NVMeFix</string>
         <key>MaxKernel</key>
         <string></string>
         <key>MinKernel</key>
         <string></string>
         <key>PlistPath</key>
         <string>Contents/Info.plist</string>
      </dict>
   </array>
</dict>
```
3. Save and reboot the system

</details>

<details>  
<summary><strong>Custom CPU Power Management (optional)</strong></summary>
</br>

1. Run the following script in Terminal  
```bash
git clone https://github.com/fewtarius/CPUFriendFriend; cd CPUFriendFriend; chmod +x ./CPUFriendFriend.command; ./CPUFriendFriend.command
```
2. When asked, select preferred values
3. From the pop-up window, copy `ssdt_data.aml` into `/EFI/OC/ACPI/` folder
4. Open `/EFI/OC/Config.plist` with any editor 
5. Go under `ACPI -> Add` and replace `SSDT-PLUG.aml` with `ssdt_data.aml`
```diff
<key>ACPI</key>
<dict>
   <key>Add</key>
   <array>
      <dict>
         <key>Comment</key>
         <string>X86 Injector</string>
         <key>Enabled</key>
         <true/>
         <key>Path</key>
-        <string>SSDT-PLUG.aml</string>
+        <string>ssdt_data.aml</string>
      </dict>
   </array>
</dict>
```
6. Go under `Kernel -> Add` and enable `CPUFriend.kext`
```diff
<key>Kernel</key>
<dict>
   <key>Add</key>
   <array>
      </dict>
         <key>Arch</key>
         <string>x86_64</string>
         <key>BundlePath</key>
         <string>CPUFriend.kext</string>
         <key>Comment</key>
         <string>Frequency data injector</string>
         <key>Enabled</key>
-        <false/>
+        <true/>
         <key>ExecutablePath</key>
         <string>Contents/MacOS/CPUFriend</string>
         <key>MaxKernel</key>
         <string></string>
         <key>MinKernel</key>
         <string></string>
         <key>PlistPath</key>
         <string>Contents/Info.plist</string>
      </dict>
   </array>
</dict>
```
7. Save and reboot the system

</details>

<details>  
<summary><strong>USB ports mapping (optional)</strong></summary>
</br>

Maybe needed for ThinkPad's dock only, use one of following methods:

- [USBMap by CorpNewt](https://github.com/corpnewt?tab=repositories)
- [Native USB fix without injector kext](https://www.olarila.com/topic/6878-guide-native-usb-fix-for-notebooks-no-injectorkext-required/?tab=comments#comment-88412)

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

1. Download and install [YogaSMC-App-Release.dmg
](https://github.com/zhen-zen/YogaSMC/releases) (both the pref-panel and app itself)
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
<summary><strong>Import calibrated display profile</strong></summary>
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

I know it can be scary at first but with the right amount of carefulness anyone can do it.  
Is it worth the effort and risk? I don't think so. I enjoyed it? 100%.  
A [Brief guide](/Guides/Bios-Mod.md).

</details>

## Status
<details>  
<summary><strong>What's working ✅</strong></summary>
</br>
 
- [x] CPU Power Management `~1W on IDLE`
- [x] Intel HD 520 Graphics `incuding graphics acceleration`
- [x] USB ports
- [x] Internal camera `working fine on FaceTime, Skype, Zoom and others`
- [x] Sleep / Wake / Shutdown / Reboot
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

- [ ] Some kexts crash in standby mode, please disable it with `sudo pmset -a standby 0`
- [ ] Mini DisplayPort seems to be broken with latest updates
- [ ] Safari DRM `Use Chromium engine to watch Apple TV+, Amazon Prime Video, Netflix and others`
- [ ] WWAN (needs to be implemented)
- [ ] Fingerprint Reader

</details>

<details>  
<summary><strong>Update tracker 🔄</strong></summary>
</br>

| [EFI Release](https://github.com/simprecicchiani/ThinkPad-T460s-macOS-OpenCore/releases)       | 0.6.5 |
|:-----------------------------------------------------------------------------------------------|:------|
| [MacOS](https://www.apple.com/macos/)                                                          | 11.1  |
| [OpenCore](https://github.com/acidanthera/OpenCorePkg/releases)                                | 0.6.5 |
| [Lilu](https://github.com/acidanthera/Lilu/releases)                                           | 1.5.1 |
| [VirtualSMC](https://github.com/acidanthera/VirtualSMC/releases)                               | 1.1.9 |
| [YogaSMC](https://github.com/zhen-zen/YogaSMC/releases)                                        | 1.4.1 |
| [WhateverGreen](https://github.com/acidanthera/WhateverGreen/releases)                         | 1.4.6 |
| [AppleALC](https://github.com/acidanthera/AppleALC/releases)                                   | 1.5.6 |
| [VoodooPS2Controller](https://github.com/acidanthera/VoodooPS2/releases)                       | 2.2.0 |
| [VoodooRMI](https://github.com/VoodooSMBus/VoodooRMI/releases)                                 | 1.3   |
| [IntelMausi](https://github.com/acidanthera/IntelMausi/releases)                               | 1.0.5 |
| [HibernationFixup](https://github.com/acidanthera/HibernationFixup/releases)                   | 1.3.9 |
| [CPUFriend](https://github.com/acidanthera/CPUFriend/releases)                                 | 1.2.3 |
| [NVMeFix](https://github.com/acidanthera/NVMeFix/releases)                                     | 1.0.4 |
| [RTCMemoryFixup](https://github.com/acidanthera/RTCMemoryFixup/releases)                       | 1.0.7 |
| [AirPortOpenBSD](https://github.com/a565109863/AirPortOpenBSD/releases/)                       | 2.0.6 |
| [AirportItlwm](https://github.com/OpenIntelWireless/itlwm/releases)                            | 1.2.0 |
| [IntelBluetoothFirmware](https://github.com/OpenIntelWireless/IntelBluetoothFirmware/releases) | 1.1.2 |
| [AppleBacklightSmoother](https://github.com/hieplpvip/AppleBacklightSmoother/releases)         | 1.0.2 |
| [BrightnessKeys](https://github.com/acidanthera/BrightnessKeys/releases)                       | 1.0.1 |
| [Sinetek-rtsx](https://github.com/cholonam/Sinetek-rtsx/releases)                              | 2.2   |

</details>

## Performances

<details>  
<summary><strong>Power consumption & thermals 🔥</strong></summary>
</br>

| Idle State                | Max Frequency                 | 2 Thread Frequency            | All Thread Frequency          | GPU Max Frequency             |
|---------------------------|-------------------------------|-------------------------------|-------------------------------|-------------------------------|
| ![](/Images/ipg-idle.png) | ![](/Images/ipg-max-freq.png) | ![](/Images/ipg-two-freq.png) | ![](/Images/ipg-all-freq.png) | ![](/Images/ipg-gpu-freq.png) |

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
