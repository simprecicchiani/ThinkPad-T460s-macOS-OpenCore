// Overriding _PTS and _WAK
// In config ACPI, _PTS to ZPTS(1,N)
// Find:     5F50545301
// Replace:  5A50545301
//
// In config ACPI, _WAK to ZWAK(1,N)
// Find:     5F57414B01
// Replace:  5A57414B01
//
// change \_SB..EC.HWAC to \_SB..EC.WACH
// in both _WAK and GPE _L17 method by binary patching.
// Find: X0VDX19IV0FD    Replace: X0VDX19XQUNI

DefinitionBlock("", "SSDT", 2, "T460s", "PTWK", 0)
{
    External(ZPTS, MethodObj)
    External(ZWAK, MethodObj)
    External(_SB.LID, DeviceObj)
    External(\_SB.PCI0, DeviceObj)
    External(\_SB.PCI0.LPC, DeviceObj)
    External(\_SB.PCI0.LPC.EC, DeviceObj)
    External(\_SB.PCI0.XHCI.PMEE, FieldUnitObj)
    External(_SB.PCI0._LPC.EC.HKEY.MMTS, MethodObj)
    External(_SB.PCI0._LPC.EC._LED, IntObj)
//  External(_SI._SST, MethodObj)

    Scope (_SB)
    {
        Device (PCI9)
        {
            Name (_ADR, Zero)
            Name (FNOK, Zero)
            Name (MODE, Zero)
            //
            Name (TPTS, Zero)
            Name (TWAK, Zero)
            Method (_STA, 0, NotSerialized)
            {
                If (_OSI ("Darwin"))
                {
                    Return (0x0F)
                }
                Else
                {
                    Return (Zero)
                }
            }
        }
    }
    
    Scope (\_SB.PCI0.LPC.EC)
    {
        OperationRegion (WRAM, EmbeddedControl, Zero, 0x0100)
        Field (WRAM, ByteAcc, NoLock, Preserve)
        {
            Offset (0x36),
            WAC0,   8,
            WAC1,   8
        }

        Method (WACH, 0, NotSerialized)
        {
        	Return ((WAC0 | (WAC1 << 0x08)))
        }
    }
    
    Method (_PTS, 1, NotSerialized)
    {
        If (_OSI ("Darwin"))
        {
            \_SB.PCI9.TPTS = Arg0
            
            if(\_SB.PCI9.FNOK ==1)
            {
                Arg0 = 3
            }
            
            If ((5 == Arg0) && CondRefOf (\_SB.PCI0.XHCI.PMEE)) {
            \_SB.PCI0.XHCI.PMEE = 0
            }
        }

        ZPTS(Arg0)

    }

    Method (_WAK, 1, NotSerialized)
    {
        If (_OSI ("Darwin"))
        {
            \_SB.PCI9.TWAK = Arg0
            
            if(\_SB.PCI9.FNOK ==1)
            {
                \_SB.PCI9.FNOK =0
                Arg0 = 3
            }
            If (Arg0 < 1 || Arg0 > 5)
            { Arg0 = 3 }

            If (3 == Arg0)
            {
                Notify (\_SB.LID, 0x80)
             }
        }

        Local0 = ZWAK(Arg0)

        Return (Local0)
    }

    Method (_TTS, 1, NotSerialized) //Method (_TTS, 1, Serialized)
    {
        If (_OSI ("Darwin"))
        {
            If (CondRefOf (\_SB.PCI0._LPC.EC._LED))
            {
                If (Arg0 == Zero & \_SB.PCI0._LPC.EC._LED == One)
                {
                    \_SB.PCI0._LPC.EC.HKEY.MMTS (0x02)
                }
            }
//          If (Arg0 == Zero)
//          {
//              \_SI._SST(One)
//          }
        }

    }
}
//EOF
