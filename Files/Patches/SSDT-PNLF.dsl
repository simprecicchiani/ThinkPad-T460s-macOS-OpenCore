// Adding PNLF device for AppleBacklightSmoother.kext
DefinitionBlock("", "SSDT", 2, "T460s", "PNLF", 0)
{
    External(_SB.PCI0.GFX0, DeviceObj)

    // For backlight control
    Scope(_SB.PCI0.GFX0)
    {
        Device(PNLF)
        {
            Name(_HID, EisaId("APP0002"))
            Name(_CID, "backlight")
            
            // _UID is set depending on device ID to match profiles in WhateverGreen
            //  0x0E - 14: Arrandale/Sandy/Ivy
            //  0x0F - 15: Haswell/Broadwell
            //  0x10 - 16: Skylake/KabyLake
            //  0x11 - 17: custom LMAX=0x7a1
            //  0x12 - 18: custom LMAX=0x1499
            //  0x13 - 19: CoffeeLake 0xffff
            Name(_UID, 0x10)
            
            Method (_STA, 0, NotSerialized)
            {
                If (_OSI ("Darwin"))
                {
                    Return (0x0B)
                }

                Return (Zero)
            }
        }
    }
}
