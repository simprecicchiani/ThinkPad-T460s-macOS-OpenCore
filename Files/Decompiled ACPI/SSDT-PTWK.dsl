// SSDT for T460 Sleep - Wake and Shutdown fixup
//
// OperationRegion (ECOR, EmbeddedControl, 0x00, 0x0100)
// 1. declaration accessed:
// HWAC,   16 (Accessed on _WAK and GPE _L17)
// Binary patches are required to make it work on macOS
//
// change \_SB..EC.HWAC to \_SB..EC.WACH
// in both _WAK and GPE _L17 method by binary patching.
// Find: X0VDX19IV0FD    Replace: X0VDX19XQUNI
//
// change _PTS to ZPTS
// Find: X1BUUwE=   Replace: WlBUUwE=
//
// change _WAK to ZWAK
// Find: X1dBSwE=   Replace: WldBSwE=

DefinitionBlock ("", "SSDT", 2, "T460", "PTWK", 0)
{
    External (ZPTS, MethodObj)    // 1 Arguments
    External (ZWAK, MethodObj)    // 1 Arguments
    External (\_SI._SST, MethodObj)         // 1 Arguments
    External (\_SB.PCI0, DeviceObj)
    External (\_SB.PCI0.LPC, DeviceObj)
    External (\_SB.PCI0.LPC.EC, DeviceObj)
    External (\_SB.PCI0.XHCI.PMEE, FieldUnitObj)

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

    Method (_PTS, 1, NotSerialized)  // _PTS: Prepare To Sleep
    {
        If (_OSI ("Darwin"))
        {
            If (0x05 == Arg0)
            {
                // fix "auto start after shutdown"
                \_SB.PCI0.XHCI.PMEE = Zero
            }
        }

        ZPTS (Arg0)
    }

    Method (_WAK, 1, NotSerialized)  // _WAK: Wake
    {


        If (_OSI ("Darwin"))
        {
            If ((Arg0 < One) || (Arg0 > 0x05))
            {
                Arg0 = 0x03
            }
        	If (0x03 == Arg0)
        	{
        		\_SI._SST (One)
        	}
        }

        Local0 = ZWAK (Arg0)
        Return (Local0)
    }
}

