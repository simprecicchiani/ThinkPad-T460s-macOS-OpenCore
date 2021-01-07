// SSDT to redirect _DSM to native XDSM on non mac OS

DefinitionBlock ("", "SSDT", 2, "T460s", "XDSM", 0)
{
	External (\_SB.PCI0.LPC, DeviceObj)
	External (\_SB.PCI0.LPC.XDSM, MethodObj)	// 4 Arguments
	External (\_SB.PCI0.IGBE, DeviceObj)
	External (\_SB.PCI0.IGBE.XDSM, MethodObj)	// 4 Arguments
	External (\_SB.PCI0.EXP1, DeviceObj)
	External (\_SB.PCI0.EXP1.XDSM, MethodObj)	// 4 Arguments
	External (\_SB.PCI0.EXP3, DeviceObj)
	External (\_SB.PCI0.EXP3.XDSM, MethodObj)	// 4 Arguments
	External (\_SB.PCI0.EXP4, DeviceObj)
	External (\_SB.PCI0.EXP4.XDSM, MethodObj)	// 4 Arguments
	External (\_SB.PCI0.EXP5, DeviceObj)
	External (\_SB.PCI0.EXP5.XDSM, MethodObj)	// 4 Arguments
	External (\_SB.PCI0.EXP8, DeviceObj)
	External (\_SB.PCI0.EXP8.XDSM, MethodObj)	// 4 Arguments
	External (\_SB.PCI0.RP09, DeviceObj)
	External (\_SB.PCI0.RP09.XDSM, MethodObj)	// 4 Arguments
	External (\_SB.PCI0.SMBU, DeviceObj)
	External (\_SB.PCI0.SMBU.XDSM, MethodObj)	// 4 Arguments
	External (\_SB.PCI0.HECI, DeviceObj)
	External (\_SB.PCI0.HECI.XDSM, MethodObj)	// 4 Arguments
	External (\_SB.EPC, DeviceObj)
	External (\_SB.EPC.XDSM, MethodObj)	// 4 Arguments
	External (\_SB.PCI0.EXP8.PXSX, DeviceObj)
	External (\_SB.PCI0.EXP8.PXSX.XDSM, MethodObj)	// 4 Arguments
	External (\_SB.PCI0.PPMC, DeviceObj)
	External (\_SB.PCI0.PPMC.XDSM, MethodObj)	// 4 Arguments
    External (\_SB.PCI0.SAT1, DeviceObj)
    External (\_SB.PCI0.SAT1.XDSM, MethodObj)   // 4 Arguments

    If (!_OSI ("Darwin"))
    {
    	Scope (\_SB.PCI0.LPC)
    	{
    		Method (_DSM, 4, NotSerialized)
    		{
    			Return (\_SB.PCI0.LPC.XDSM (Arg0, Arg1, Arg2, Arg3))
    		}
    	}

    	Scope (\_SB.PCI0.IGBE)
    	{
    		Method (_DSM, 4, Serialized)
    		{
    			Return (\_SB.PCI0.IGBE.XDSM (Arg0, Arg1, Arg2, Arg3))
    		}
    	}

    	Scope (\_SB.PCI0.EXP1)
    	{
    		Method (_DSM, 4, Serialized)
    		{
    			Return (\_SB.PCI0.EXP1.XDSM (Arg0, Arg1, Arg2, Arg3))
    		}
    	}

    	Scope (\_SB.PCI0.EXP3)
    	{
    		Method (_DSM, 4, Serialized)
    		{
    			Return (\_SB.PCI0.EXP3.XDSM (Arg0, Arg1, Arg2, Arg3))
    		}
    	}

    	Scope (\_SB.PCI0.EXP4)
    	{
    		Method (_DSM, 4, Serialized)
    		{
    			Return (\_SB.PCI0.EXP4.XDSM (Arg0, Arg1, Arg2, Arg3))
    		}
    	}

    	Scope (\_SB.PCI0.EXP5)
    	{
    		Method (_DSM, 4, Serialized)
    		{
    			Return (\_SB.PCI0.EXP5.XDSM (Arg0, Arg1, Arg2, Arg3))
    		}
    	}

    	Scope (\_SB.PCI0.EXP8)
    	{
    		Method (_DSM, 4, Serialized)
    		{
    			Return (\_SB.PCI0.EXP8.XDSM (Arg0, Arg1, Arg2, Arg3))
    		}
    	}

       	Scope (\_SB.PCI0.RP09)
    	{
    		Method (_DSM, 4, Serialized)
    		{
    			Return (\_SB.PCI0.RP09.XDSM (Arg0, Arg1, Arg2, Arg3))
    		}
    	}

       	Scope (\_SB.PCI0.SMBU)
    	{
    		Method (_DSM, 4, Serialized)
    		{
    			Return (\_SB.PCI0.SMBU.XDSM (Arg0, Arg1, Arg2, Arg3))
    		}
    	}

       	Scope (\_SB.PCI0.HECI)
    	{
    		Method (_DSM, 4, Serialized)
    		{
    			Return (\_SB.PCI0.HECI.XDSM (Arg0, Arg1, Arg2, Arg3))
    		}
    	}

       	Scope (\_SB.EPC)
    	{
    		Method (_DSM, 4, Serialized)
    		{
    			Return (\_SB.EPC.XDSM (Arg0, Arg1, Arg2, Arg3))
    		}
    	}

    	Scope (\_SB.PCI0.EXP8.PXSX)
    	{
    		Method (_DSM, 4, Serialized)
    		{
    			Return (\_SB.PCI0.EXP8.PXSX.XDSM (Arg0, Arg1, Arg2, Arg3))
    		}
    	}

       	Scope (\_SB.PCI0.PPMC)
    	{
    		Method (_DSM, 4, Serialized)
    		{
    			Return (\_SB.PCI0.PPMC.XDSM (Arg0, Arg1, Arg2, Arg3))
    		}
    	}

        Scope (\_SB.PCI0.SAT1)
        {
            Method (_DSM, 4, Serialized)
            {
                Return (\_SB.PCI0.SAT1.XDSM (Arg0, Arg1, Arg2, Arg3))
            }
        }
    }
}

