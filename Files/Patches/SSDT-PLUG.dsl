
//
// Leverages the PMPM approach found in https://github.com/acidanthera/OpenCorePkg/blob/master/Docs/AcpiSamples/SSDT-PLUG.dsl
// Plugin-type = 0x01 injection to load X86*.kext
//
DefinitionBlock ("", "SSDT", 2, "T460s", "CpuPlug", 0x00003000)
{
    External (\_PR.CPU0, ProcessorObj)
    Method (PMPM, 4, NotSerialized) {
       If (LEqual (Arg2, Zero)) {
           Return (Buffer (One) { 0x03 })
       }
       Return (Package (0x02)
       {
           "plugin-type", 
           One
       })
    }
    Scope (\_PR.CPU0)
    {
        Method (_DSM, 4, NotSerialized)  // _DSM: Device-Specific Method
        {
            Return (PMPM (Arg0, Arg1, Arg2, Arg3))
        }
    }
}