//Enables DYTC thermal-management on newer Thinkpads
DefinitionBlock ("", "SSDT", 2, "T460s", "DYTC", 0x00000000)
{
    External (HPTE, FieldUnitObj) 
    External (LNUX, IntObj)    // Variable set with "Linux" or "FreeBSD"
    External (WNTF, IntObj)    // Variable set with "Windows 2001" or "Microsoft Windows NT"
    External (DPTF, FieldUnitObj) 
    External (OSYS, FieldUnitObj) 

    Scope (\)
    {
        If (_OSI ("Darwin"))
        {
            // disable HPET. It shouldn't be needed on modern systems anyway and is also disabled in genuine OSX
            HPTE = Zero
            
            // Initialze mute button mode like Linux when it's broken, may be combined with MuteLEDFixup in prefpane.
            LNUX = One

            // Enables DYTC, Lenovos thermal solution. Can be controlled by YogaSMC
            WNTF = One

            // Disable DPTF, we use DYTC!
            DPTF = Zero

            // Patch OSYS to native value of darwin
            OSYS = 0x07DF
        }
    }
}
