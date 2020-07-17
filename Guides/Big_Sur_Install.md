# Upgrade to macOS Big Sur

## Requirements
For the installation you'll need a few things:  
* At least 12GB USB drive
* A Mac, a Hackintosh, or a VM running macOS to create the installation media
* The Big Sur EFI folder from the repository

## Download the installer
1. Download the [gibMacOs](https://github.com/corpnewt/gibMacOS) tool and open `gibMacOS.command`:  
<img src="../Images/Big_Sur_Installation_1.png" alt="Big Sur Installation 1" height="400">    

2. Hit `M` to change Max macOS and then enter `10.16` to change the catalog to the one containing the Big Sur Installer.  
<img src="../Images/Big_Sur_Installation_2.png" alt="Big Sur Installation 2" height="400">  

3. Hit `C` and than choose `4` to change to the developer catalog.  
<img src="../Images/Big_Sur_Installation_3.png" alt="Big Sur Installation 3" height="400">  

4. Select the number which says Big Sur and hit enter to download it.  
<img src="../Images/Big_Sur_Installation_4.png" alt="Big Sur Installation 4" height="400">  

5. After it finished downloading open the `InstallAssistant.pkg` file that was downloaded. It's located in `gibMacOS/macOS Downloads/developer/XXX-XXXXX - Install macOS Beta` folder. This package wil create the `Install macOS Big Sur Beta.app` in `/Applications` folder.  


Once it's done you should fint your installer located in the `/Applications` folder:  
<img src="../Images/Big_Sur_Installation_5.png" alt="Big Sur Installation 5" height="400">  

## Create the installation media
Open Disk Utility and format your USB Drive as the following: 
* Name: MyVolume
* Format: macOS Journaled
* Scheme: GUID Partition Map  
<img src="../Images/Big_Sur_Installation_6.png" alt="Big Sur Installation 6" height="400">  
Once it finished formatting, open terminal and type in:  
```sh
sudo /Applications/Install\ macOS\ Big\ Sur\ Beta.app/Contents/Resources/createinstallmedia --volume /Volumes/MyVolume
```
This will take around 20 minutes, so sit down and relax...

### Replace your EFI folder with the new one
For the last step before booting, you should replace your EFI folder with the [new Big Sur compatible](../Big-Sur-EFI) one.
* Mount your EFI partition
* Create a Backup of your old EFI folder
* Delete the old EFI folder on the partition, paste the `Big-Sur-EFI` folder and rename it to `EFI`
* *You can edit the config.plist and fill out the SMBios section, and also feel free to use the CPUfriend kext and any other extra kexts or ACPI's that you had in your old EFI folder*  

And now, after you done with everything, restart the computer and boot from `Install macOS Beta (external)`  
From now on this will be the same process as it was before. The installation will take around an hour.

**If the installation stuck at Forcing CS_RUNTIME for entitlement DON'T RESTART YOUR COMPUTER it's totally normal!**

## What is Different from Catalina
Almost everything is the same in case of functionality. In the first hour of usint the new OS I experienced a little thermal throttling, but after a while it just dissapeared, and now everything works as on Older Versions.  

### What is updated in the new EFI 🔁
| Item | Version |
| :--- | ---: |
| MacOS compatibility | 10.15.5 -> 11.0 |
| OpenCore | 0.5.9 -> 6.0 beta |
| Lilu | 1.4.5  -> 1.4.6 beta|
| VirtualSMC | 1.1.4  -> 1.1.5 beta|
| WhateverGreen | 1.4.0  -> 1.4.1 beta|
| AppleALC | 1.5.0 |
| VoodooPS2Controller | 2.1.4 |
| VoodooInput | 1.0.5 |
| IntelMausi | 1.0.3 |
| Sinetek-rtsx.kext | 2.2 |

## Credits
OpenCore Dortania Guide - [link](https://dortania.github.io/OpenCore-Desktop-Guide/extras/big-sur/)