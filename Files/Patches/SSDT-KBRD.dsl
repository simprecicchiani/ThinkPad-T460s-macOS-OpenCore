// 
DefinitionBlock ("", "SSDT", 2, "simprecicchiani-T460s", "KBRD", 0)
{
    External(_SB.PCI0.LPC_.KBD_, DeviceObj)
    Scope (_SB.PCI0.LPC.KBD)
    {
    If (_OSI ("Darwin"))
    {
        // Select specific configuration in VoodooPS2Trackpad.kext
        Method(_DSM, 4)
        {
            If (!Arg2) { Return (Buffer() { 0x03 } ) }
            Return (Package()
            {
                "RM,oem-id", "LENOVO",
                "RM,oem-table-id", "T460",
            })
        }
        Name (RMCF,Package() 
        {
            // Overrides for settings in Info.plist
            "Keyboard", Package()
            {
                "Swap command and option", 
                ">y",
                "Custom PS2 Map", Package()
                {
                    Package(){},
                    "e037=64 " // PrtSc -> F13
                }
            }
        })
    }
    }
}
//EOF