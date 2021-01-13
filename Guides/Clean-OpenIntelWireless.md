<details>  
<summary><strong>Remove unnecessary WiFi firmware files</strong></summary>

</br>
This steps help you to speed-up a little the boot process (if you use `itlwm` or `AirportItlwm`)

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
<summary><strong>Remove unnecessary Bluetooth firmware files</strong></summary>

</br>
This steps help you to speed-up a little the boot process (if you use [IntelBluetoothFirmware](https://github.com/OpenIntelWireless/IntelBluetoothFirmware) kexts)

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
