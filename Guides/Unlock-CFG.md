# How to unlock Thinkpad T460s CFG Lock

Although the T460s has locked CFG setting and `modGrubShell.efi` method doesn't works, [this method](https://www.reddit.com/r/hackintosh/comments/hz2rtm/cfg_lockunlocking_alternative_method/) appears to work.

**WARNING: This entire process is tested on BIOS ver 1.49 only**

### 0. Check/update BIOS version
Go into your BIOS and check your running version. If you need to update it go to [Lenovo Website](https://pcsupport.lenovo.com/us/en/products/laptops-and-netbooks/thinkpad-t-series-laptops/thinkpad-t460s/downloads/driver-list/component?name=BIOS%2FUEFI) or, if like me you don't have neither Win10 nor Linux on your T460s and don't want to install them, download the [extracted BIOS](/Files/T460s-BIOS-1.49/extracted-1.49) and follow the [provided guide](/Files/T460s-BIOS-1.49/extracted-1.49/InstructionUS-BIOSflashUSBmemorykey.txt) to make a USB BIOS installer (another windows computer is required).

### 1. Download the BIOS

[Skip this step, I already did this]
Go to [T460s Support Page](https://pcsupport.lenovo.com/us/en/products/laptops-and-netbooks/thinkpad-t-series-laptops/thinkpad-t460s/downloads/driver-list/component?name=BIOS%2FUEFI) and grab the 1.49 version (22/06/2020).

### 2. extract the BIOS

[Skip this step, I already did this]
[This guide](https://forums.lenovo.com/t5/Gaming-Laptops/GUIDE-How-to-extract-BIOS-from-Lenovo-BIOS-Update-Package-such-as-ATCN37WW-exe/m-p/5008973) shows how to do it on Windows with `innoextract`.

### 3. Found CFG-lock variable name

[Skip this step, I already did this]

Open the [extracted firmware](/Files/T460s-BIOS-1.49/extracted-1.49/N1CET81W/$0AN1C00.FL1) with [UEFITool](https://github.com/LongSoft/UEFITool)

Found the right firmware section:
![](/Images/BIOSSetupSection.png)

Export it, convert it as txt file.

Look for CFG Lock VarName: **0x3A**
![](/Images/CFGLockVarName.png)

### 4. Download RU.efi tool

The version I tested and worked properly [here](/Files/T460s-BIOS-1.49/tools/RU-5.25.0379/RU.efi).

### 5. Make a bootable USB with RU.efi

- Grab an USB drive, 100mb is enough but it needs to be empty. Format it as `MBR`, `FAT32`.

- Create a folder called `EFI` and in that folder, create another folder called `BOOT`. In `BOOT`, paste `RU.efi` and rename it to **bootx64.efi**. The file tree should thus look like this: `/YOUR_USB/EFI/BOOT/bootx64.efi`.

### 6. Change CFG Lock value to 0

- Make sure `Secure Boot` is disabled in your BIOS and boot to the USB drive. You'll be greeted with a screen like this. Just press **Enter**.
![](/Images/Ru.efi1.bmp)

- Now, we'll go to a screen to edit UEFI variables. Press **Alt** + **=**. You should get a screen like this.
![](/Images/Ru.efi2.bmp)

- Now, search the list till you find `CPUSetup`. Press **Enter**.
![](/Images/Ru.efi3.bmp)

- If everything's right, you should get a screen that looks like this.
![](/Images/Ru.efi4.bmp)

- Now we'll need the CFG Lock offset value, for BIOS ver 1.49 is *0x3A*. Finding that value is easy: `0030` is for the **3**, and `0A` is for the **A**. In the upper left corner you should be able to comfirm it's the right value: it's displayed as `003A`.
![](/Images/Ru.efi5.bmp)

- The value set is `01`. Setting that to `00` will disable CFG Lock. So press **Enter**, and just type **0** (numlock might be enabled, be aware of that). If everything goes right, that value should be highlighted now. Press again Enter to finish the editing.
![](/Images/Ru.efi6.bmp)

- Press **Ctrl** + **W** to save. Press **Alt** + **Q** to quit and turn the computer off. If it display an error message it's all right: it did that to me and it worked anyway.

Done!

### 7. Reboot without quirks

Disable `AppleCpuPmCfgLock` and `AppleXcpmCfgLock` in your `Config.plist` under `Kernel>Quirks`. It's good practice to try this on an external boot drive first, just in case the previous process went wrong.

Be aware that resetting your BIOS will also reset the CFG Lock, and you will need to do this over again.