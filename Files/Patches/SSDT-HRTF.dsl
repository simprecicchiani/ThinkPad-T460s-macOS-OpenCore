// SSDT for T460 HPET, RTC amd TIMR 3 in 1 fixup
//
// Binary patch for deactivating native HPET device
// change HPET (\WNTF\!WXPF to _OSI("Darwin"))
// Find: oBCQXFdOVEaSXFdYUEY=	Replace: oA9fT1NJDURhcndpbgA=
//
// Alternative method of native HPET deactivation
// change HPET (\WNTF\!WXPF to \XXXX\!YYYY)
// Find: kFxXTlRGklxXWFBG	Replace: kFxYWFhYklxZWVlZ
//
// Yet another method of HPET deactivation
// change HPET._STA to XSTA
// Find: DEHQAQMUH19TVEEA	Replace: DEHQAQMUH1hTVEEA

DefinitionBlock ("", "SSDT", 2, "T460s", "HRTF", 0)
{
    External (\_SB.PCI0.LPC, DeviceObj)
    External (\_SB.PCI0.LPC.PIC, DeviceObj)
    External (\_SB.PCI0.LPC.RTC, DeviceObj)
    External (\_SB.PCI0.LPC.TIMR, DeviceObj)
    External (\_SB.PCI0.LPC.HPET, DeviceObj)
    External (\HPET, FieldUnitObj)

//    External (WNTF, IntObj)
//    External (WXPF, IntObj)
//
////	Alternative method for HPET deactivation
//    Scope (\)
//    {
//        Name (XXXX, One)
//        Name (YYYY, Zero)
//        If (!_OSI ("Darwin"))
//        {
//            XXXX = WNTF /* External reference */
//            YYYY = WXPF /* External reference */
//        }
//    }
//
////	Yet another method of HPET deactivation
//    Scope (\_SB.PCI0.LPC.HPET)
//    {
//    	Method (_STA, 0, NotSerialized)
//    	{
//    		If (_OSI ("Darwin"))
//    		{
//    			Return (Zero)
//    		}
//    		Else
//    		{
//    			Return (0x0F)
//    		}
//    	}
//    }

    Scope (\_SB.PCI0.LPC.PIC)
    {
        Method (_STA, 0, NotSerialized) // _STA: Status
        {
            If (_OSI ("Darwin"))
            {
                Return (Zero)
            }
            Else
            {
                Return (0x0F)
            }
        }
    }

    Scope (\_SB.PCI0.LPC.RTC)
    {
        Method (_STA, 0, NotSerialized)  // _STA: Status
        {
            If (_OSI ("Darwin"))
            {
                Return (Zero)
            }
            Else
            {
                Return (0x0F)
            }
        }
    }

    Scope (\_SB.PCI0.LPC.TIMR)
    {
        Method (_STA, 0, NotSerialized)  // _STA: Status
        {
            If (_OSI ("Darwin"))
            {
                Return (Zero)
            }
            Else
            {
                Return (0x0F)
            }
        }
    }

    Scope (\_SB.PCI0.LPC)
    {
        Device (IPIC)
        {
            Name (_HID, EisaId ("PNP0000") /* 8259-compatible Programmable Interrupt Controller */)  // _HID: Hardware ID
            Name (_CRS, ResourceTemplate ()  // _CRS: Current Resource Settings
            {
                IO (Decode16,
                    0x0020,             // Range Minimum
                    0x0020,             // Range Maximum
                    0x01,               // Alignment
                    0x02,               // Length
                    )
                IO (Decode16,
                    0x00A0,             // Range Minimum
                    0x00A0,             // Range Maximum
                    0x01,               // Alignment
                    0x02,               // Length
                    )
                IO (Decode16,
                    0x04D0,             // Range Minimum
                    0x04D0,             // Range Maximum
                    0x01,               // Alignment
                    0x02,               // Length
                    )
                IRQNoFlags ()
                    {2}
            })

            Method (_STA, 0, NotSerialized)  // _STA: Status
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

        Device (HPE0)
        {
            Name (_HID, EisaId ("PNP0103") /* HPET System Timer */)  // _HID: Hardware ID
            Name (_UID, Zero)  // _UID: Unique ID
            Name (BUF0, ResourceTemplate ()
            {
                IRQNoFlags ()
                    {0}
                IRQNoFlags ()
                    {8}
                Memory32Fixed (ReadWrite,
                    0xFED00000,         // Address Base
                    0x00000400,         // Address Length
                    _Y24)
            })

            Method (_STA, 0, NotSerialized)  // _STA: Status
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

            Method (_CRS, 0, Serialized)  // _CRS: Current Resource Settings
            {
                CreateDWordField (BUF0, \_SB.PCI0.LPC.HPE0._Y24._BAS, HPT0)  // _BAS: Base Address
                HPT0 = \HPET
                Return (BUF0) /* \_SB_.PCI0.LPC_.HPE0.BUF0 */
            }
        }

        Device (RTC0)
        {
            Name (_HID, EisaId ("PNP0B00") /* AT Real-Time Clock */)  // _HID: Hardware ID
            Name (_CRS, ResourceTemplate ()  // _CRS: Current Resource Settings
            {
                IO (Decode16,
                    0x0070,             // Range Minimum
                    0x0070,             // Range Maximum
                    0x01,               // Alignment
                    0x08,               // Length
                    )
            })

            Method (_STA, 0, NotSerialized)  // _STA: Status
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

        Device (TIM0)
        {
            Name (_HID, EisaId ("PNP0100") /* PC-class System Timer */)  // _HID: Hardware ID
            Name (_CRS, ResourceTemplate ()  // _CRS: Current Resource Settings
            {
                IO (Decode16,
                    0x0040,             // Range Minimum
                    0x0040,             // Range Maximum
                    0x01,               // Alignment
                    0x04,               // Length
                    )
            })

            Method (_STA, 0, NotSerialized)  // _STA: Status
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
}

