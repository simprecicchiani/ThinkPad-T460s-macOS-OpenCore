# Upgrade to macOS Big Sur

## Requirements
For the installation you'll need a few things:  
* At least 12GB USB drive
* A Mac, a Hackintosh, or a VM running macOS to create the installation media


## Download the installer
1. Download the [gibMacOs](https://github.com/corpnewt/gibMacOS) tool and open `gibMacOS.command`:  
![](/Images/BigSurInstallation1.png)

2. Hit `M` to change Max macOS and then enter `10.16` to change the catalog to the one containing the Big Sur Installer.  
![](/Images/BigSurInstallation2.png)

3. Hit `C` and than choose `4` to change to the developer catalog.  
![](/Images/BigSurInstallation3.png)

4. Select the number which says Big Sur and hit enter to download it.  
![](/Images/BigSurInstallation4.png)

5. After it finished downloading open the `InstallAssistant.pkg` file that was downloaded. It's located in `gibMacOS/macOS Downloads/developer/XXX-XXXXX - Install macOS Beta` folder. This package wil create the `Install macOS Big Sur Beta.app` in `/Applications` folder.  


Once it's done you should find your installer located in the `/Applications` folder:  
![](/Images/BigSurInstallation5.png)

## Create the installation media
Open Disk Utility and format your USB Drive as the following: 
* Name: MyVolume
* Format: macOS Journaled
* Scheme: GUID Partition Map  
![](/Images/BigSurInstallation6.png)

Once it finished formatting, open terminal and type in:  

```sh
sudo /Applications/Install\ macOS\ Big\ Sur\ Beta.app/Contents/Resources/createinstallmedia --volume /Volumes/MyVolume
```

This will take around 20 minutes, so sit back and relax...

### Check if you have the latest OC version and the latest kexts installed
For the last step before booting, you should check if your OC configuration is up to date.
You have to have ateast these versions:  
| Name                                                                   | Version |
|:-----------------------------------------------------------------------|--------:|
| [OpenCore](https://github.com/acidanthera/OpenCorePkg/releases)        | 0.6.0   |
| [Lilu](https://github.com/acidanthera/Lilu/releases)                   | 1.4.6   |
| [VirtualSMC](https://github.com/acidanthera/VirtualSMC/releases)       | 1.1.5   |
| [WhateverGreen](https://github.com/acidanthera/WhateverGreen/releases) | 1.4.1   |   
If you don't have one of these you have to update it. You can download the latest kexts from the EFI folder on the repository. After you downloaded them, you just have to replace them in EFI/OC/Kexts. Updating OpenCore is a bit harder but if you follow [this guide](https://dortania.github.io/OpenCore-Post-Install/universal/update.html) you can do it in 5-10 minutes.



### Booting
And now, after you done with everything, restart the computer and boot from `Install macOS Beta (external)`  
From now on this will be the same process as it was before. The installation will take around an hour.

**If the installation stuck at Forcing CS_RUNTIME for entitlement DON'T RESTART YOUR COMPUTER it's totally normal!**

### Post-Install
Because Big Sur is still in beta the thermals aren't the best without CPU friend. So if you want a cooler and quiter experience you should use CPU-Friend. You can find the tutorial for it in the [Readme.md file](../README.MD).

## Credits
OpenCore Dortania [Big Sur Guide](https://dortania.github.io/OpenCore-Install-Guide/extras/big-sur/)
