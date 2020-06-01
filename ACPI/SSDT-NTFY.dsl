// SSDT for Notify BAT0 and BAT1 to BATC
// ACPI binary patches required to function
//
// Change _Q22 to XQ22:
// Find:    X1EyMg==	Replace: WFEyMg==
//
// Change _Q24 to XQ24:
// Find:    X1EyNA==	Replace: WFEyNA==
//
// Change _Q25 to XQ25:
// Find:    X1EyNQ==	Replace: WFEyNQ==
//
// Change _Q4A to XQ4A:
// Find:    X1E0QQ==	Replace: WFE0QQ==
//
// Change _Q4B to XQ4B:
// Find:    X1E0Qg==	Replace: WFE0Qg==
//
// Change _Q4C to XQ4C:
// Find:    X1E0Qw==	Replace: WFE0Qw==
//
// Change _Q4D to XQ4D:
// Find:    X1E0RA==	Replace: WFE0RA==
//
// Change BATW to WBAT:
// Find:    TwdCQVRXAQ==	Replace: TwdXQkFUAQ==

DefinitionBlock ("", "SSDT", 2, "T460", "NTFY", 0)
{
	// Common definitions
    External (\_SB.PCI0.LPC.EC, DeviceObj)
    External (\_SB.PCI0.LPC.EC.BAT1, DeviceObj)
    External (\_SB.PCI0.LPC.EC.BATC, DeviceObj)
    External (\_SB.PCI0.LPC.EC.HB0A, FieldUnitObj)
    External (\_SB.PCI0.LPC.EC.HB1A, FieldUnitObj)
    External (\_SB.PCI0.LPC.EC.CLPM, MethodObj)     // 0 Argugements
    External (\_SB.PCI0.LPC.EC.HKEY.MHKQ, MethodObj)    // 1 Arguments

    // BAT1 definitions
    External (\BT2T, FieldUnitObj)
    External (\_SB.PCI0.LPC.EC.SLUL, FieldUnitObj)
    External (\_SB.PCI0.LPC.EC.BAT1.B1ST, IntObj)
    External (\_SB.PCI0.LPC.EC.BAT1.SBLI, IntObj)
    External (\_SB.PCI0.LPC.EC.BAT1.XB1S, IntObj)
    External (\_SB.PCI0.LPC.EC.BAT0.B0ST, IntObj)

    // Notify BAT0 and BAT1 to BATC
    External (\_SB.PCI0.LPC.EC.XQ22, MethodObj)
    External (\_SB.PCI0.LPC.EC.XQ4A, MethodObj)
    External (\_SB.PCI0.LPC.EC.XQ4B, MethodObj)
    External (\_SB.PCI0.LPC.EC.BAT1.XQ4C, MethodObj)
    External (\_SB.PCI0.LPC.EC.XQ24, MethodObj)

    External (\_SB.PCI0.LPC.EC.XQ4D, MethodObj)
    External (\_SB.PCI0.LPC.EC.XQ25, MethodObj)
    External (\_SB.PCI0.LPC.EC.WBAT, MethodObj)

    Scope (\_SB.PCI0.LPC.EC)
    {
        Method (_Q22, 0, NotSerialized)  // _Qxx: EC Query, xx=0x00-0xFF
        {
            If (_OSI ("Darwin"))
            {
                CLPM ()
                If (HB0A)
                {
                    Notify (BATC, 0x80) // Status Change
                }

                If (HB1A)
                {
                    Notify (BATC, 0x80) // Status Change
                }
            }
            Else
            {
                \_SB.PCI0.LPC.EC.XQ22 ()
            }
        }

        Method (_Q4A, 0, NotSerialized)  // _Qxx: EC Query, xx=0x00-0xFF
        {
            If (_OSI ("Darwin"))
            {
                CLPM ()
                Notify (BATC, 0x81) // Information Change
            }
            Else
            {
                \_SB.PCI0.LPC.EC.XQ4A ()
            }
        }

        Method (_Q4B, 0, NotSerialized)  // _Qxx: EC Query, xx=0x00-0xFF
        {
            If (_OSI ("Darwin"))
            {
                CLPM ()
                Notify (BATC, 0x80) // Status Change
            }
            Else
            {
                \_SB.PCI0.LPC.EC.XQ4B ()
            }
        }

        Method (_Q24, 0, NotSerialized)  // _Qxx: EC Query, xx=0x00-0xFF
        {
            If (_OSI ("Darwin"))
            {
                CLPM ()
                Notify (BATC, 0x80) // Status Change
            }
            Else
            {
                \_SB.PCI0.LPC.EC.XQ24 ()
            }
        }

        Method (_Q4D, 0, NotSerialized)  // _Qxx: EC Query, xx=0x00-0xFF
        {
            If (_OSI ("Darwin"))
            {
                CLPM ()
                If (\BT2T)
                {
                    If ((^BAT1.SBLI == One))
                    {
                        Sleep (0x0A)
                        If ((HB1A && (SLUL == Zero)))
                        {
                            ^BAT1.XB1S = One
                            Notify (\_SB.PCI0.LPC.EC.BATC, One) // Device Check
                        }
                    }
                    ElseIf ((SLUL == One))
                    {
                        ^BAT1.XB1S = Zero
                        Notify (\_SB.PCI0.LPC.EC.BATC, 0x03) // Eject Request
                    }
                }

                If ((^BAT1.B1ST & ^BAT1.XB1S))
                {
                    Notify (BATC, 0x80) // Status Change
                }
            }
            Else
            {
                \_SB.PCI0.LPC.EC.XQ4D ()
            }
        }

        Method (_Q25, 0, NotSerialized)  // _Qxx: EC Query, xx=0x00-0xFF
        {
            If (_OSI ("Darwin"))
            {
                If ((^BAT1.B1ST & ^BAT1.XB1S))
                {
                    CLPM ()
                    Notify (BATC, 0x80) // Status Change
                }
            }
            Else
            {
                \_SB.PCI0.LPC.EC.XQ25 ()
            }
        }

        Method (BATW, 1, NotSerialized)
        {
            If (_OSI ("Darwin"))
            {
                If (\BT2T)
                {
                    Local0 = \_SB.PCI0.LPC.EC.BAT1.XB1S
                    If ((HB1A && !SLUL))
                    {
                        Local1 = One
                    }
                    Else
                    {
                        Local1 = Zero
                    }

                    If ((Local0 ^ Local1))
                    {
                        \_SB.PCI0.LPC.EC.BAT1.XB1S = Local1
                        Notify (\_SB.PCI0.LPC.EC.BATC, One) // Device Check
                    }
                }
            }
            Else
            {
                \_SB.PCI0.LPC.EC.WBAT (Arg0)
            }
        }
    }

    Scope (\_SB.PCI0.LPC.EC.BAT1)
    {
        Method (_Q4C, 0, NotSerialized)  // _Qxx: EC Query, xx=0x00-0xFF
        {

            \_SB.PCI0.LPC.EC.CLPM ()
            If (\_SB.PCI0.LPC.EC.HB1A)
            {
                \_SB.PCI0.LPC.EC.HKEY.MHKQ (0x4010)
            }
            Else
            {
                \_SB.PCI0.LPC.EC.HKEY.MHKQ (0x4011)
                If (\_SB.PCI0.LPC.EC.BAT1.XB1S)
                {
                    If (_OSI ("Darwin"))
                    {
                        Notify (\_SB.PCI0.LPC.EC.BATC, 0x03) // Eject Request
                    }
                    Else
                    {
                        Notify (\_SB.PCI0.LPC.EC.BAT1, 0x03)
                    }
                }
            }
        }
    }
}

