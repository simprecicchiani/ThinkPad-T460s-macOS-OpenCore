// SSDT for T460 XHCI and custom UIAC Device
// Automatic injection of XHC properties
//
// change _UPC to XUPC (XHCI)
// Find: X1VQQw==    Replace: WFVQQw==

DefinitionBlock ("", "SSDT", 2, "T460", "XHCI", 0)
{
    External (DTGP, MethodObj)     // 5 Arguments
    External (\_SB.PCI0.XHCI, DeviceObj)
    External (\_SB.PCI0.XHCI.XDSM, MethodObj)   // 4 Arguments
    External (\_SB.PCI0.XHCI.URTH.HSP0, DeviceObj)
    External (\_SB.PCI0.XHCI.URTH.HSP1, DeviceObj)
    External (\_SB.PCI0.XHCI.URTH.HSP2, DeviceObj)
    External (\_SB.PCI0.XHCI.URTH.HSP3, DeviceObj)
    External (\_SB.PCI0.XHCI.URTH.HSP5, DeviceObj)
    External (\_SB.PCI0.XHCI.URTH.HSP6, DeviceObj)
    External (\_SB.PCI0.XHCI.URTH.HSP7, DeviceObj)
    External (\_SB.PCI0.XHCI.URTH.HSP8, DeviceObj)
    External (\_SB.PCI0.XHCI.URTH.HSP9, DeviceObj)
    External (\_SB.PCI0.XHCI.URTH.SSP0, DeviceObj)
    External (\_SB.PCI0.XHCI.URTH.SSP2, DeviceObj)
    External (\_SB.PCI0.XHCI.URTH.SSP3, DeviceObj)
    External (\_SB.PCI0.XHCI.URTH.SSP5, DeviceObj)

    External (\_SB.PCI0.XHCI.URTH.HSP4, DeviceObj)
	External (\_SB.PCI0.XHCI.URTH.HSPA, DeviceObj)
    External (\_SB.PCI0.XHCI.URTH.HSPB, DeviceObj)

    External (\_SB.PCI0.XHCI.URTH.SSP1, DeviceObj)
    External (\_SB.PCI0.XHCI.URTH.SSP4, DeviceObj)

    External (\_SB.PCI0.XHCI.URTH.HSP0.XUPC, MethodObj)     // 0 Arguments
    External (\_SB.PCI0.XHCI.URTH.HSP1.XUPC, MethodObj)     // 0 Arguments
    External (\_SB.PCI0.XHCI.URTH.HSP2.XUPC, MethodObj)     // 0 Arguments
    External (\_SB.PCI0.XHCI.URTH.HSP3.XUPC, MethodObj)     // 0 Arguments
    External (\_SB.PCI0.XHCI.URTH.HSP5.XUPC, MethodObj)     // 0 Arguments
    External (\_SB.PCI0.XHCI.URTH.HSP6.XUPC, MethodObj)     // 0 Arguments
    External (\_SB.PCI0.XHCI.URTH.HSP7.XUPC, MethodObj)     // 0 Arguments
    External (\_SB.PCI0.XHCI.URTH.HSP8.XUPC, MethodObj)     // 0 Arguments
    External (\_SB.PCI0.XHCI.URTH.HSP9.XUPC, MethodObj)     // 0 Arguments
    External (\_SB.PCI0.XHCI.URTH.SSP0.XUPC, MethodObj)     // 0 Arguments
    External (\_SB.PCI0.XHCI.URTH.SSP2.XUPC, MethodObj)     // 0 Arguments
    External (\_SB.PCI0.XHCI.URTH.SSP3.XUPC, MethodObj)     // 0 Arguments
    External (\_SB.PCI0.XHCI.URTH.SSP5.XUPC, MethodObj)     // 0 Arguments

    External (\_SB.PCI0.XHCI.URTH.HSP4.XUPC, MethodObj)     // 0 Arguments
    External (\_SB.PCI0.XHCI.URTH.HSPA.XUPC, MethodObj)     // 0 Arguments
    External (\_SB.PCI0.XHCI.URTH.HSPB.XUPC, MethodObj)     // 0 Arguments

    External (\_SB.PCI0.XHCI.URTH.SSP1.XUPC, MethodObj)     // 0 Arguments
    External (\_SB.PCI0.XHCI.URTH.SSP4.XUPC, MethodObj)     // 0 Arguments

    External (\_SB.PCI0.XHCI.URTH.HSP9.WCAM, DeviceObj)     // 0 Arguments
    External (\_SB.PCI0.XHCI.URTH.HSP9.WCAM.XUPC, MethodObj)    // 0 Arguments


    // Inject USB power properties for XHCI
    Method(\_SB.PCI0.XHCI._DSM, 4, Serialized)
    {
        If (_OSI ("Darwin"))
        {
            If (!Arg2)
            {
                Return (Buffer (One)
                {
                    0x03
                })
            }
            Local0 = Package ()
            {
                "AAPL,current-available",
                Buffer ()
                {
                    0x34, 0x08, 0, 0
                },

                "AAPL,current-extra",
                Buffer ()
                {
                    0x98, 0x08, 0, 0,
                },

                "AAPL,current-extra-in-sleep",
                Buffer ()
                {
                    0x40, 0x06, 0, 0,
                },

                "AAPL,max-port-current-in-sleep",
                Buffer ()
                {
                    0x34, 0x08, 0, 0
                }
            }

            Return(Local0)
        }
        Else
        {
            Return (\_SB.PCI0.XHCI.XDSM (Arg0, Arg1, Arg2, Arg3))
        }
    }

    // Redundant USB Power properties injection via USBX Device
    Scope (\_SB)
    {
        Device (USBX)
        {
            Name (_ADR, Zero)  // _ADR: Address

            Method (_DSM, 4, NotSerialized)  // _DSM: Device-Specific Method
            {
            	If ((Arg2 == Zero))
                {
                    Return (Buffer (One)
                    {
                         0x03                                             // .
                    })
                }
                Local0 = Package ()
                    {
	                    "kUSBSleepPowerSupply",
	                    0x13EC,
	                    "kUSBSleepPortCurrentLimit",
	                    0x0834,
	                    "kUSBWakePowerSupply",
	                    0x13EC,
	                    "kUSBWakePortCurrentLimit",
	                    0x0834
                    }
                DTGP (Arg0, Arg1, Arg2, Arg3, RefOf (Local0))
                Return (Local0)
            }

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

    Scope (\)
    {
        Name (UPCX, Package (0x04)
        {
            Zero,
            Zero,
            Zero,
            Zero
        })

        Name (UPCD, Package (0x04)
        {
            0xFF,
            0x03,
            Zero,
            Zero
        })

        Name (UPCB, Package (0x04)
        {
            0xFF,
            0xFF,
            Zero,
            Zero
        })
    }

    Scope (\_SB.PCI0.XHCI.URTH.HSP0)    // USB2 left side front external
    {
        Method (_UPC, 0, Serialized)
        {
        	If (_OSI ("Darwin"))
        	{
		        Name (UPCP, Package (0x04) {})
                CopyObject (\UPCD, UPCP)
                Return (UPCP)
        	}
        	Else
        	{
        		Return (\_SB.PCI0.XHCI.URTH.HSP0.XUPC ())
        	}
        }
    }

    Scope (\_SB.PCI0.XHCI.URTH.HSP1)    // USB2 right side external
    {
        Method (_UPC, 0, Serialized)
        {
        	If (_OSI ("Darwin"))
        	{
		        Name (UPCP, Package (0x04) {})
                CopyObject (\UPCD, UPCP)
                Return (UPCP)
        	}
        	Else
        	{
        		Return (\_SB.PCI0.XHCI.URTH.HSP1.XUPC ())
        	}
        }
    }

    Scope (\_SB.PCI0.XHCI.URTH.HSP2)    // HUB
    {
        Method (_UPC, 0, Serialized)
        {
        	If (_OSI ("Darwin"))
        	{
		        Name (UPCP, Package (0x04) {})
                CopyObject (\UPCD, UPCP)
                Return (UPCP)
        	}
        	Else
        	{
        		Return (\_SB.PCI0.XHCI.URTH.HSP2.XUPC ())
        	}
        }
    }

    Scope (\_SB.PCI0.XHCI.URTH.HSP3)    // HUB
    {
        Method (_UPC, 0, Serialized)
        {
        	If (_OSI ("Darwin"))
        	{
		        Name (UPCP, Package (0x04) {})
                CopyObject (\UPCD, UPCP)
                Return (UPCP)
        	}
        	Else
        	{
        		Return (\_SB.PCI0.XHCI.URTH.HSP3.XUPC ())
        	}
        }
    }


    Scope (\_SB.PCI0.XHCI.URTH.HSP4)	// Nothing
    {
    	Method (_UPC, 0 , Serialized)
    	{
	    	If (!_OSI ("Darwin"))
	    	{
	    		Return (\_SB.PCI0.XHCI.URTH.HSP4.XUPC ())
	    	}
            Else
            {
                Name (UPCP, Package (0x04) {})
                CopyObject (\UPCX, UPCP)
                Return (UPCP)
            }
    	}
    }

    Scope (\_SB.PCI0.XHCI.URTH.HSP5)    // USB2 left side back external
    {
        Method (_UPC, 0, Serialized)
        {
        	If (_OSI ("Darwin"))
        	{
		        Name (UPCP, Package (0x04) {})
                CopyObject (\UPCD, UPCP)
                Return (UPCP)
        	}
        	Else
        	{
        		Return (\_SB.PCI0.XHCI.URTH.HSP5.XUPC ())
        	}
        }
    }

    Scope (\_SB.PCI0.XHCI.URTH.HSP6)    // Bluetooch
    {
        Method (_UPC, 0, Serialized)
        {
        	If (_OSI ("Darwin"))
        	{
		        Name (UPCP, Package (0x04) {})
                CopyObject (\UPCB, UPCP)
                Return (UPCP)
        	}
        	Else
        	{
        		Return (\_SB.PCI0.XHCI.URTH.HSP6.XUPC ())
        	}
        }
    }

    Scope (\_SB.PCI0.XHCI.URTH.HSP7)    // Touch Screen
    {
        Method (_UPC, 0, Serialized)
        {
        	If (_OSI ("Darwin"))
        	{
		        Name (UPCP, Package (0x04) {})
                CopyObject (\UPCB, UPCP)
                Return (UPCP)
        	}
        	Else
        	{
        		Return (\_SB.PCI0.XHCI.URTH.HSP7.XUPC ())
        	}
        }
    }

    Scope (\_SB.PCI0.XHCI.URTH.HSP8)    // Finger Print
    {
        Method (_UPC, 0, Serialized)
        {
        	If (_OSI ("Darwin"))
        	{
		        Name (UPCP, Package (0x04) {})
                CopyObject (\UPCB, UPCP)
                Return (UPCP)
        	}
        	Else
        	{
        		Return (\_SB.PCI0.XHCI.URTH.HSP8.XUPC ())
        	}
        }
    }

    Scope (\_SB.PCI0.XHCI.URTH.HSP9)    // Web Camera
    {
        Method (_UPC, 0, Serialized)
        {
        	If (_OSI ("Darwin"))
        	{
		        Name (UPCP, Package (0x04) {})
                CopyObject (\UPCB, UPCP)
                Return (UPCP)
        	}
        	Else
        	{
        		Return (\_SB.PCI0.XHCI.URTH.HSP9.XUPC ())
        	}
        }
    }

    Scope (\_SB.PCI0.XHCI.URTH.HSP9.WCAM)	// WEB Camera on Windows
    {
    	Method (_UPC, 0 , Serialized)
    	{
	    	If (!_OSI ("Darwin"))
	    	{
	    		Return (\_SB.PCI0.XHCI.URTH.HSP9.WCAM.XUPC ())
	    	}
            Else
            {
                Name (UPCP, Package (0x04) {})
                CopyObject (\UPCX, UPCP)
                Return (UPCP)
            }
    	}
    }

    Scope (\_SB.PCI0.XHCI.URTH.HSPA)	// Nothing
    {
    	Method (_UPC, 0 , Serialized)
    	{
	    	If (!_OSI ("Darwin"))
	    	{
	    		Return (\_SB.PCI0.XHCI.URTH.HSPA.XUPC ())
	    	}
            Else
            {
                Name (UPCP, Package (0x04) {})
                CopyObject (\UPCX, UPCP)
                Return (UPCP)
            }
    	}
    }

    Scope (\_SB.PCI0.XHCI.URTH.HSPB)		// Nothing
    {
    	Method (_UPC, 0 , Serialized)
    	{
	    	If (!_OSI ("Darwin"))
	    	{
	    		Return (\_SB.PCI0.XHCI.URTH.HSPB.XUPC ())
	    	}
            Else
            {
                Name (UPCP, Package (0x04) {})
                CopyObject (\UPCX, UPCP)
                Return (UPCP)
            }
    	}
    }

    Scope (\_SB.PCI0.XHCI.URTH.SSP0)    // USB3 left side front external
    {
        Method (_UPC, 0, Serialized)
        {
        	If (_OSI ("Darwin"))
        	{
		        Name (UPCP, Package (0x04) {})
                CopyObject (\UPCD, UPCP)
                Return (UPCP)
        	}
        	Else
        	{
        		Return (\_SB.PCI0.XHCI.URTH.SSP0.XUPC ())
        	}
        }
    }

    Scope (\_SB.PCI0.XHCI.URTH.SSP1)		// Nothing
    {
    	Method (_UPC, 0 , Serialized)
    	{
	    	If (!_OSI ("Darwin"))
	    	{
	    		Return (\_SB.PCI0.XHCI.URTH.SSP1.XUPC ())
	    	}
            Else
            {
                Name (UPCP, Package (0x04) {})
                CopyObject (\UPCX, UPCP)
                Return (UPCP)
            }
    	}
    }

    Scope (\_SB.PCI0.XHCI.URTH.SSP2)    // USB3 right side port external
    {
        Method (_UPC, 0, Serialized)
        {
        	If (_OSI ("Darwin"))
        	{
		        Name (UPCP, Package (0x04) {})
                CopyObject (\UPCD, UPCP)
                Return (UPCP)
        	}
        	Else
        	{
        		Return (\_SB.PCI0.XHCI.URTH.SSP2.XUPC ())
        	}
        }
    }

    Scope (\_SB.PCI0.XHCI.URTH.SSP3)    // USB3 on Dock Hub
    {
        Method (_UPC, 0, Serialized)
        {
        	If (_OSI ("Darwin"))
        	{
		        Name (UPCP, Package (0x04) {})
                CopyObject (\UPCD, UPCP)
                Return (UPCP)
        	}
        	Else
        	{
        		Return (\_SB.PCI0.XHCI.URTH.SSP3.XUPC ())
        	}
        }
    }

    Scope (\_SB.PCI0.XHCI.URTH.SSP4)		// Nothing
    {
    	Method (_UPC, 0 , Serialized)
    	{
	    	If (!_OSI ("Darwin"))
	    	{
	    		Return (\_SB.PCI0.XHCI.URTH.SSP4.XUPC ())
	    	}
            Else
            {
                Name (UPCP, Package (0x04) {})
                CopyObject (\UPCX, UPCP)
                Return (UPCP)
            }
    	}
    }

    Scope (\_SB.PCI0.XHCI.URTH.SSP5)    // USB3 left side back external
    {
        Method (_UPC, 0, Serialized)
        {
        	If (_OSI ("Darwin"))
        	{
		        Name (UPCP, Package (0x04) {})
                CopyObject (\UPCD, UPCP)
                Return (UPCP)
        	}
        	Else
        	{
        		Return (\_SB.PCI0.XHCI.URTH.SSP5.XUPC ())
        	}
        }
    }
}

