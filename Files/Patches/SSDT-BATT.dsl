// Lenovo ThinkPad T460 Dual Battery Configuration
// created by shmilee -- adapted by tluck for T460
// converted to Hotpatch with help of T450's SSDT
// from jsassu20 By Junaed.
// fixes Improper Battery Level and Status Reporting
// for further info refer to T440p, X220, Guide
// 'How to patch DSDT for working battery status'
//
// OperationRegion (ECOR, EmbeddedControl, 0x00, 0x0100)
// 1. declaration accessed:
// SBRC,   16, SBFC,   16, SBAC,   16, SBVO,   16, SBBM,   16,
// SBDC,   16, SBDV,   16, SBSN,   16,
// HWAC,   16 (Accessed on _WAK and GPE _L17)
// HSPD,   16 (Accessed on custom SMCD Device for fan readings)
// SBCH,   32
// SBMN,  128
// SBDN,  128
// 2. declaration not accessed:
// HWAK,   16, HDEN,   32, HDEP,   32,
// SBAE,   16, SBRS,   16, SBAF,   16, SBBS,   16
// SBMD,   16, SBCC,   16
// SBOM,   16, SBSI,   16, SBDT,   16,
//
// Binary patch required to change GBIF and GBST to XBIF and XBST
// change (GBIF,3,N) to XBIF (Battery)
// Find: R0JJRgM=	Replace: WEJJRgM=
//
// change (GBST,4,N) to XBST (Battery)
// Find: R0JTVAQ=	Replace: WEJTVAQ=

DefinitionBlock ("", "SSDT", 2, "T460", "BATT", 0)
{
    External (\_SB.PCI0.LPC.EC, DeviceObj)
    External (\_SB.PCI0.LPC.EC.BATW, MethodObj)     // 1 Arguments
    External (\_SB.PCI0.LPC.EC.XBIF, MethodObj)     // 3 Arguments
    External (\_SB.PCI0.LPC.EC.XBST, MethodObj)     // 4 Arguments
    External (\_SB.PCI0.LPC.EC.AC._PSR, MethodObj)    // 0 Arguments
    External (\_SB.PCI0.LPC.EC.BATM, MutexObj)
    External (\_SB.PCI0.LPC.EC.HIID, FieldUnitObj)
    External (\_SB.PCI0.LPC.EC.BSWR, FieldUnitObj)
    External (\_SB.PCI0.LPC.EC.BSWA, FieldUnitObj)
    External (\_SB.PCI0.LPC.EC.B0I0, IntObj)
    External (\_SB.PCI0.LPC.EC.B0I1, IntObj)
    External (\_SB.PCI0.LPC.EC.B0I2, IntObj)
    External (\_SB.PCI0.LPC.EC.B0I3, IntObj)
    External (\_SB.PCI0.LPC.EC.B1I0, IntObj)
    External (\_SB.PCI0.LPC.EC.B1I1, IntObj)
    External (\_SB.PCI0.LPC.EC.B1I2, IntObj)
    External (\_SB.PCI0.LPC.EC.B1I3, IntObj)

    Method (B1B2, 2, NotSerialized)
    {
        Return ((Arg0 | (Arg1 << 0x08)))
    }

    Method (B1B4, 4, NotSerialized)
    {
        Local0 = Arg3
        Local0 = (Arg2 | (Local0 << 0x08))
        Local0 = (Arg1 | (Local0 << 0x08))
        Local0 = (Arg0 | (Local0 << 0x08))
        Return (Local0)
    }

    Scope (\_SB.PCI0.LPC.EC)
    {
        OperationRegion (BRAM, EmbeddedControl, Zero, 0x0100)
        Field (BRAM, ByteAcc, NoLock, Preserve)
        {
            Offset (0xA0),
            BRC0,   8,
            BRC1,   8,
            BFC0,   8,
            BFC1,   8,
            Offset (0xA8),
            BAC0,   8,
            BAC1,   8,
            BVO0,   8,
            BVO1,   8
        }

        Field (BRAM, ByteAcc, NoLock, Preserve)
        {
            Offset (0xA0),
            BBM0,   8,
            BBM1,   8
        }

        Field (BRAM, ByteAcc, NoLock, Preserve)
        {
            Offset (0xA0),
            BDC0,   8,
            BDC1,   8,
            BDV0,   8,
            BDV1,   8,
            Offset (0xAA),
            BSN0,   8,
            BSN1,   8
        }

        Field (BRAM, ByteAcc, NoLock, Preserve)
        {
            Offset (0xA0),
            BCH0,   8,
            BCH1,   8,
            BCH2,   8,
            BCH3,   8
        }

        Field (BRAM, ByteAcc, NoLock, Preserve)
        {
            Offset (0xA0),
            BMNX,   128
        }

        Field (BRAM, ByteAcc, NoLock, Preserve)
        {
            Offset (0xA0),
            BDNX,   128
        }

        Method (RE1B, 1, Serialized)
        {
            OperationRegion (ERAM, EmbeddedControl, Arg0, One)
            Field (ERAM, ByteAcc, NoLock, Preserve)
            {
                BYTE,   8
            }

            Return (BYTE) /* \_SB_.PCI0.LPC_.EC__.RE1B.BYTE */
        }

        Method (RECB, 2, Serialized)
        {
            Arg1 = ((Arg1 + 0x07) >> 0x03)
            Name (TEMP, Buffer (Arg1){})
            Arg1 += Arg0
            Local0 = Zero
            While ((Arg0 < Arg1))
            {
                TEMP [Local0] = RE1B (Arg0)
                Arg0++
                Local0++
            }

            Return (TEMP) /* \_SB_.PCI0.LPC_.EC__.RECB.TEMP */
        }
        
        Method (WE1B, 2, Serialized)
        {
            OperationRegion (ERAM, EmbeddedControl, Arg0, One)
            Field (ERAM, ByteAcc, NoLock, Preserve)
            {
                BYTE,   8
            }

            BYTE = Arg1
        }

        Method (WECB, 3, Serialized)
        {
            Arg1 = ((Arg1 + 0x07) >> 0x03)  // Arg1 = ceil(Arg1 / 8), this is loop counter

            Local7 = Buffer (Arg1) {}       // Initial buffer to be written
            Local7 = Arg2

            Arg1 += Arg0                    // Shift write window to target area
            Local0 = Zero                   // Buffer index

            While ((Arg0 < Arg1))
            {
                WE1B (Arg0, DerefOf (Local7 [Local0]))
                Arg0++                      // Offset++
                Local0++                    // Index++
            }
        }
        
        Method (GBIF, 3, Serialized)
        {
        	If (_OSI ("Darwin"))
        	{
	            Acquire (BATM, 0xFFFF)
	            If (Arg2)
	            {
	                HIID = (Arg0 | One)
	                Local7 = B1B2 (BBM0, BBM1)
	                Local7 >>= 0x0F
	                Arg1 [Zero] = (Local7 ^ One)
	                HIID = Arg0
	                If (Local7)
	                {
	                    Local1 = (B1B2 (BFC0, BFC1) * 0x0A)
	                }
	                Else
	                {
	                    Local1 = B1B2 (BFC0, BFC1)
	                }

	                Arg1 [0x02] = Local1
	                HIID = (Arg0 | 0x02)
	                If (Local7)
	                {
	                    Local0 = (B1B2 (BDC0, BDC1) * 0x0A)
	                }
	                Else
	                {
	                    Local0 = B1B2 (BDC0, BDC1)
	                }

	                Arg1 [One] = Local0
	                Divide (Local1, 0x14, Local2, Arg1 [0x05])
	                If (Local7)
	                {
	                    Arg1 [0x06] = 0xC8
	                }
	                ElseIf (B1B2 (BDV0, BDV1))
	                {
	                    Divide (0x00030D40, B1B2 (BDV0, BDV1), Local2, Arg1 [0x06])
	                }
	                Else
	                {
	                    Arg1 [0x06] = Zero
	                }

	                Arg1 [0x04] = B1B2 (BDV0, BDV1)
	                Local0 = B1B2 (BSN0, BSN1)
	                Name (SERN, Buffer (0x06)
	                {
	                    "     "
	                })
	                Local2 = 0x04
	                While (Local0)
	                {
	                    Divide (Local0, 0x0A, Local1, Local0)
	                    SERN [Local2] = (Local1 + 0x30)
	                    Local2--
	                }

	                Arg1 [0x0A] = SERN /* \_SB_.PCI0.LPC_.EC__.GBIF.SERN */
	                HIID = (Arg0 | 0x06)
	                Arg1 [0x09] = RECB (0xA0, 0x80)
	                HIID = (Arg0 | 0x04)
	                Name (BTYP, Buffer (0x05)
	                {
	                     0x00, 0x00, 0x00, 0x00, 0x00                     // .....
	                })
	                BTYP = B1B4 (BCH0, BCH1, BCH2, BCH3)
	                Arg1 [0x0B] = BTYP /* \_SB_.PCI0.LPC_.EC__.GBIF.BTYP */
	                HIID = (Arg0 | 0x05)
	                Arg1 [0x0C] = RECB (0xA0, 0x80)
	            }
	            Else
	            {
	                Arg1 [One] = 0xFFFFFFFF
	                Arg1 [0x05] = Zero
	                Arg1 [0x06] = Zero
	                Arg1 [0x02] = 0xFFFFFFFF
	            }

	            Release (BATM)
	            Return (Arg1)
        	}
        	Else
        	{
        		Return (\_SB.PCI0.LPC.EC.XBIF (Arg0, Arg1, Arg2))
        	}
        }   // END of GBIF

        Method (GBST, 4, NotSerialized)
        {
        	If (_OSI ("Darwin"))
        	{
	            Acquire (BATM, 0xFFFF)
	            If ((Arg1 & 0x20))
	            {
	                Local0 = 0x02
	            }
	            ElseIf ((Arg1 & 0x40))
	            {
	                Local0 = One
	            }
	            Else
	            {
	                Local0 = Zero
	            }

	            If ((Arg1 & 0x07)){}
	            Else
	            {
	                Local0 |= 0x04
	            }

	            If (((Arg1 & 0x07) == 0x07))
	            {
	                Local0 = 0x04
	                Local1 = Zero
	                Local2 = Zero
	                Local3 = Zero
	            }
	            Else
	            {
	                HIID = Arg0
	                Local3 = B1B2 (BVO0, BVO1)
	                If (Arg2)
	                {
	                    Local2 = (B1B2 (BRC0, BRC1) * 0x0A)
	                }
	                Else
	                {
	                    Local2 = B1B2 (BRC0, BRC1)
	                }

	                Local1 = B1B2 (BAC0, BAC1)
	                If ((Local1 >= 0x8000))
	                {
	                    If ((Local0 & One))
	                    {
	                        Local1 = (0x00010000 - Local1)
	                    }
	                    Else
	                    {
	                        Local1 = Zero
	                    }
	                }
	                ElseIf (!(Local0 & 0x02))
	                {
	                    Local1 = Zero
	                }

	                If (Arg2)
	                {
	                    Local1 *= Local3
	                    Divide (Local1, 0x03E8, Local7, Local1)
	                }
	            }

	            Local5 = (One << (Arg0 >> 0x04))
	            BSWA |= BSWR /* \_SB_.PCI0.LPC_.EC__.BSWR */
	            If (((BSWA & Local5) == Zero))
	            {
	                Arg3 [Zero] = Local0
	                Arg3 [One] = Local1
	                Arg3 [0x02] = Local2
	                Arg3 [0x03] = Local3
	                If ((Arg0 == Zero))
	                {
	                    B0I0 = Local0
	                    B0I1 = Local1
	                    B0I2 = Local2
	                    B0I3 = Local3
	                }
	                Else
	                {
	                    B1I0 = Local0
	                    B1I1 = Local1
	                    B1I2 = Local2
	                    B1I3 = Local3
	                }
	            }
	            ElseIf (^AC._PSR ())
	            {
	                If ((Arg0 == Zero))
	                {
	                    Arg3 [Zero] = B0I0 /* \_SB_.PCI0.LPC_.EC__.B0I0 */
	                    Arg3 [One] = B0I1 /* \_SB_.PCI0.LPC_.EC__.B0I1 */
	                    Arg3 [0x02] = B0I2 /* \_SB_.PCI0.LPC_.EC__.B0I2 */
	                    Arg3 [0x03] = B0I3 /* \_SB_.PCI0.LPC_.EC__.B0I3 */
	                }
	                Else
	                {
	                    Arg3 [Zero] = B1I0 /* \_SB_.PCI0.LPC_.EC__.B1I0 */
	                    Arg3 [One] = B1I1 /* \_SB_.PCI0.LPC_.EC__.B1I1 */
	                    Arg3 [0x02] = B1I2 /* \_SB_.PCI0.LPC_.EC__.B1I2 */
	                    Arg3 [0x03] = B1I3 /* \_SB_.PCI0.LPC_.EC__.B1I3 */
	                }
	            }
	            Else
	            {
	                Arg3 [Zero] = Local0
	                Arg3 [One] = Local1
	                Arg3 [0x02] = Local2
	                Arg3 [0x03] = Local3
	            }

	            Release (BATM)
	            Return (Arg3)
        	}
        	Else
        	{
        		Return (\_SB.PCI0.LPC.EC.XBST (Arg0, Arg1, Arg2, Arg3))
        	}
        }   // END of GBST
    }   // END of Scope \_SB.PCI0.LPC.EC
}
