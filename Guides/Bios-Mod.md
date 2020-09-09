## Download

- homebrew  
    ```
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
    ```
- flashrom  
    ```
    brew install flashrom
    ```
- [UEFIPatch](https://github.com/LongSoft/UEFITool/releases/download/0.28.0/UEFIPatch_0.28.0_mac.zip)
- hex-fiend  
    ```
    brew cask install hex-fiend
    ```
- [patch.txt](http://paranoid.anal-slavery.com/files/backup_thinkpads/xx60_patches_v1.txt)
- [brief guide](http://paranoid.anal-slavery.com/biosmods/skylake.html)  

## [Guide](https://notthebe.ee/Removing-the-Wi-Fi-Whiteslit-on-Haswell-Thinkpads-T440p-W540-T540-etc.html)
- Turn off laptop
- Enter BIOS and disable power
- Open bottom lid
- Connect clip to bios chip
- Connect CH341A to other laptop USB
- cd into `UEFIPatch` folder
- dump BIOS  
    ```
    sudo flashrom -p ch341a_spi -r bios1.img
    ```
- dump BIOS again  
    ```
    sudo flashrom -p ch341a_spi -r bios2.img
    ```
- check if images are equal  
    ```
    diff bios1.img bios2.img
    ```  
    should return nothing  
- Patch the BIOS image  
    ```
    ./UEFIPatch bios1.img xx60_patches_v1.txt -o bios_patched.img
    ```
- open `bios_patched.img` with hex-fiend  
- replace  
    ```
    4C 4E 56 42 42 53 45 43 FB
    ```  
    with  
    ```
    4C 4E 56 42 42 53 45 43 FF
    ```  
- flash the patched BIOS  
    ```
    sudo flashrom -p ch341a_spi -w bios_patched.img
    ```  
