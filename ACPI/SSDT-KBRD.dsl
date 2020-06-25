// SSDT for T460 Keyboard Map & Configuration.

DefinitionBlock("", "SSDT", 2, "T460", "KBRD", 0)
{
    // External references to EC, keyboard, and original methods.
    External (\_SB.PCI0.LPC.EC, DeviceObj)
    External (\_SB.PCI0.LPC.KBD, DeviceObj)
    External (\_SB.PCI0.LPC.EC.XQ6A, MethodObj)
    External (\_SB.PCI0.LPC.EC.XQ15, MethodObj)
    External (\_SB.PCI0.LPC.EC.XQ14, MethodObj)
    External (\_SB.PCI0.LPC.EC.XQ16, MethodObj)
    External (\_SB.PCI0.LPC.EC.XQ64, MethodObj)
    External (\_SB.PCI0.LPC.EC.XQ66, MethodObj)
    External (\_SB.PCI0.LPC.EC.XQ67, MethodObj)
    External (\_SB.PCI0.LPC.EC.XQ68, MethodObj)
    External (\_SB.PCI0.LPC.EC.XQ69, MethodObj)
    External (\_SB.PCI0.LPC.EC.XQ1F, MethodObj)
    External (\_SB.PCI0.LPC.EC.XQ74, MethodObj)
    External (\_SB.PCI0.LPC.EC.HKEY.MMTS, MethodObj)
    External (\_SB.PCI0.LPC.EC.HKEY.MLCS, MethodObj)
    External (\_SB.PCI0.LPC.EC.HKEY.MHKQ, MethodObj)
    External (_SI._SST, MethodObj)
    
    Scope (\)
    {

        // This ACPI reserved method is run once before sleep and once after awakened
        Method (_TTS, 1, NotSerialized)
        {
            If (_OSI ("Darwin"))
            {
                // Arg0 contains the system state of transition
                // for wake state it is Zero.
                If (Arg0 == Zero & \_SB.PCI0.LPC.EC.LED1 == One)
                {
                    \_SB.PCI0.LPC.EC.HKEY.MMTS (0x02)
                }
                
            }
        }
    }

    Scope (\_SB.PCI0.LPC.EC)
    {
        Name (LED1, Zero)
        // _Q6A - (Fn+F4) microphone mute key.
        Method(_Q6A, 0, NotSerialized)
        {
            If (_OSI ("Darwin"))
          	{
                // Toggle Mute Microphone LED
                If ((LED1 == Zero))
                {
                    // Right Shift + F20
                    Notify (\_SB.PCI0.LPC.KBD, 0x0136)
                    Notify (\_SB.PCI0.LPC.KBD, 0x036b)
                    Notify (\_SB.PCI0.LPC.KBD, 0x01b6)

                    // 0x02 = Enable LED
                    \_SB.PCI0.LPC_.EC.HKEY.MMTS (0x02)
                    LED1 = One
                }
                Else
                {
                    // Left Shift + F20
                    Notify (\_SB.PCI0.LPC.KBD, 0x012a)
                    Notify (\_SB.PCI0.LPC.KBD, 0x036b)
                    Notify (\_SB.PCI0.LPC.KBD, 0x01aa)

                    // 0x00 = Disable LED
                    \_SB.PCI0.LPC_.EC.HKEY.MMTS (Zero)
                    LED1 = Zero
                }
          	}
          	Else
          	{
                // Call original _Q6A method.
                \_SB.PCI0.LPC_.EC.XQ6A()
          	}
        }

        // _Q15 - (Fn+F5) brightness down key.
        Method (_Q15, 0, NotSerialized)
        {
          	If (_OSI ("Darwin"))
          	{
                // Send a one-shot event (down then up) for scancode e0 05 to keyboard device. This
                // is picked up by VoodooPS2 and sent to macOS as the F14 (brightness down) key.
              	Notify (\_SB.PCI0.LPC.KBD, 0x0405)
          	}
          	Else
          	{
                // Call original _Q15 method.
          	    \_SB.PCI0.LPC.EC.XQ15 ()
          	}
        }

        // _Q14 - (Fn+F6) brightness up key.
        Method (_Q14, 0, NotSerialized)
        {
          	If (_OSI ("Darwin"))
          	{
                // Send a one-shot event (down then up) for scancode e0 06 to keyboard device. This
                // is picked up by VoodooPS2 and sent to macOS as the F15 (brightness up) key.
              	Notify (\_SB.PCI0.LPC.KBD, 0x0406)
          	}
          	Else
          	{
                // Call original _Q14 method.
          		  \_SB.PCI0.LPC.EC.XQ14 ()
          	}
        }

        // _Q16 - (Fn+F7) projector key.
        Method(_Q16, 0, NotSerialized)
        {
            If (_OSI ("Darwin"))
          	{
                // Send a one-shot event (down then up) for scancode 67 to keyboard device. This
                // is picked up by VoodooPS2 and sent to macOS as the F16 key.
              	Notify (\_SB.PCI0.LPC.KBD, 0x0367)
          	}
          	Else
          	{
                // Call original _Q16 method.
          		  \_SB.PCI0.LPC.EC.XQ16 ()
          	}
        }

        // _Q64 - (Fn+F8) Wireless disable key.
        Method(_Q64, 0, NotSerialized)
        {
            If (_OSI ("Darwin"))
            {
                // Send a one-shot event (down then up) for scancode 68 to keyboard device. This
                // is picked up by VoodooPS2 and sent to macOS as the F17 key.
                Notify (\_SB.PCI0.LPC.KBD, 0x0368)
            }
            Else
            {
                // Call original _Q64 method.
                \_SB.PCI0.LPC.EC.XQ64 ()
            }
        }


        // _Q66 - (Fn+F9) Settings key.
        Method(_Q66, 0, NotSerialized)
        {
            If (_OSI ("Darwin"))
            {
                // Send a one-shot event (down then up) for scancode 69 to keyboard device. This
                // is picked up by VoodooPS2 and sent to macOS as the F18 key.
                Notify (\_SB.PCI0.LPC.KBD, 0x0369)
            }
            Else
            {
                // Call original _Q66 method.
                \_SB.PCI0.LPC.EC.XQ66 ()
            }
        }

        // _Q67 - (Fn+F10) Search key.
        Method(_Q67, 0, NotSerialized)
        {

            If (_OSI ("Darwin"))
            {
                // Send a down event for the Alt key (scancode e0 5b), then a one-shot event (down then up) for
                // the spacebar (scancode 39), and finally an up event for the Alt key (break scancode e0 db).
                // This is picked up by VoodooPS2 and sent to macOS as the Command+Space key combo for Spotlight.
                Notify (\_SB.PCI0.LPC.KBD, 0x0138)
                Notify (\_SB.PCI0.LPC.KBD, 0x0339)
                Notify (\_SB.PCI0.LPC.KBD, 0x01b8)
            }
            Else
            {
                // Call original _Q67 method.
                \_SB.PCI0.LPC.EC.XQ67 ()
            }
        }

        // _Q68 - (Fn+F11) App switcher key.
        Method(_Q68, 0, NotSerialized)
        {

            If (_OSI ("Darwin"))
            {
                // Send a down event for the Control key (scancode 1d), then a one-shot event (down then up) for
                // the up arrow key (scancode 0e 48), and finally an up event for the Control key (break scancode 9d).
                // This is picked up by VoodooPS2 and sent to macOS as the Control+Up key combo for Mission Control.
                Notify (\_SB.PCI0.LPC.KBD, 0x011d)
                Notify (\_SB.PCI0.LPC.KBD, 0x0448)
                Notify (\_SB.PCI0.LPC.KBD, 0x019d)
            }
            Else
            {
                // Call original _Q68 method.
                \_SB.PCI0.LPC.EC.XQ68 ()
            }
        }

        // _Q69 - (Fn+F12) Start screen key.
        Method(_Q69, 0, NotSerialized)
        {
            If (_OSI ("Darwin"))
            {
                // Send a one-shot event (down then up) for scancode 6a to keyboard device. This
                // is picked up by VoodooPS2 and sent to macOS as the F19 key.
                Notify (\_SB.PCI0.LPC.KBD, 0x036a)
            }
            Else
            {
                // Call original _Q69 method.
                \_SB.PCI0.LPC.EC.XQ69 ()
            }
        }
        
        Name (LED2, Zero)
        
        // _Q1F - (Fn+Space) Toggle Keyboard Backlight.
        Method (_Q1F, 0, NotSerialized) // cycle keyboard backlight
        {
            If (_OSI ("Darwin"))
          	{
                // Cycle keyboard backlight states

                If ((LED2 == Zero))
                {
                    // Right Shift + F16.
                    Notify (\_SB.PCI0.LPC.KBD, 0x0136)
                    Notify (\_SB.PCI0.LPC.KBD, 0x0367)
                    Notify (\_SB.PCI0.LPC.KBD, 0x01b6)
                    //  Off to dim
                    \_SB.PCI0.LPC.EC.HKEY.MLCS (One)
                    LED2 = One
                }
                Else
                {
                    If ((LED2 == One))
                    {
                        // Left Shift + F19.
                        Notify (\_SB.PCI0.LPC.KBD, 0x012a)
                        Notify (\_SB.PCI0.LPC.KBD, 0x036a)
                        Notify (\_SB.PCI0.LPC.KBD, 0x01aa)
                        //  dim to bright
                        \_SB.PCI0.LPC.EC.HKEY.MLCS (0x02)
                        LED2 = 2
                    }
                    Else
                    {
                        If ((LED2 == 2))
                        {
                            // Left Shift + F16.
                            Notify (\_SB.PCI0.LPC.KBD, 0x012a)
                            Notify (\_SB.PCI0.LPC.KBD, 0x0367)
                            Notify (\_SB.PCI0.LPC.KBD, 0x01aa)
                            // bright to off
                            \_SB.PCI0.LPC.EC.HKEY.MLCS (Zero)
                            LED2 = Zero
                        }
          	            Else
          	            {
                            // Call original _Q6A method.
                            \_SB.PCI0.LPC.EC.XQ1F()
          	            }
                    }
                }
            }
        }
        
        Name (LED3, Zero)
        
        Method (_Q74, 0, NotSerialized) // FnLock (Fn + Esc)
        {
            If (_OSI ("Darwin"))
            {
                // Toggle FnLock LED
                If ((LED3 == Zero))
                {
                    // Right Shift + F18
                    Notify (\_SB.PCI0.LPC.KBD, 0x012A)
                    Notify (\_SB.PCI0.LPC.KBD, 0x0369)
                    Notify (\_SB.PCI0.LPC.KBD, 0x01aa)

                    // 0x02 = Enable LED
                    \_SB.PCI0.LPC.EC.HKEY.MHKQ (0x02)
                    LED3 = One
                }
                Else
                {
                    // Left Shift + F18
                    Notify (\_SB.PCI0.LPC.KBD, 0x0136)
                    Notify (\_SB.PCI0.LPC.KBD, 0x0369)
                    Notify (\_SB.PCI0.LPC.KBD, 0x01b6)

                    // 0x00 = Disable LED
                    \_SB.PCI0.LPC.EC.HKEY.MHKQ (Zero)
                    LED3 = Zero
                }

            }
            Else
            {
                // Call original _Q74 method.
                \_SB.PCI0.LPC.EC.XQ74()
            }
        }
        
    }

    Scope (\_SB.PCI0.LPC.KBD)
    {
        If (_OSI ("Darwin"))
        {
            // Lenovo ThinkPad T460 Configuration Load
            // Select specific items in VoodooPS2Controller
            Method(_DSM, 4, NotSerialized)
            {
                If (!Arg2)
                {
                    Return (Buffer ()
                    {
                        0x03
                    })
                }

                Return (Package ()
                {
                    "RM,oem-id", "LENOVO",
                    "RM,oem-table-id", "T460",
                })
            }

            // Overrides for settings in the Info.plist files
            Name(RMCF, Package()
            {
                "Keyboard", Package ()
                {
                    "ActionSwipeLeft",  "37 d, 21 d, 21 u, 37 u",
                    "ActionSwipeRight", "37 d, 1e d, 1e u, 37 u",
                    "SleepPressTime",   "1500",
                    "Swap command and option", ">y",
                    "Custom PS2 Map", Package()
                    {
                        Package(Zero) { },
                        "e037=64", // PrtSc=F13,via SysPrefs->Keyboard->Shortcuts
                    },
                },
            })
        }
    }
}
