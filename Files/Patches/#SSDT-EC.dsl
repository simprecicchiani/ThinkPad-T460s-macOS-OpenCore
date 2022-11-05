// EC RW 
DefinitionBlock ("", "SSDT", 2, "T460s", "EC", 0)
{
    External(_SB.PCI0.LPC.EC, DeviceObj)
    
    Scope (\)
    {
        Method (B1B2, 2, NotSerialized)
        {
            ShiftLeft (Arg1, 8, Local0)
            Or (Arg0, Local0, Local0)
            Return (Local0)

        }
        Method (B1B4, 4, NotSerialized)
        {
            Store (Arg3, Local0)
            Or (Arg2, ShiftLeft (Local0, 0x08), Local0)
            Or (Arg1, ShiftLeft (Local0, 0x08), Local0)
            Or (Arg0, ShiftLeft (Local0, 0x08), Local0)
            Return (Local0)
        }
    }
    
    Scope(\_SB.PCI0.LPC.EC)
    {    
        Method (RE1B, 1, NotSerialized)
        {
            OperationRegion(ERAM, EmbeddedControl, Arg0, 1)
            Field(ERAM, ByteAcc, NoLock, Preserve) { BYTE, 8 }
            Return(BYTE)
        }
        Method (RECB, 2, Serialized)
        {
            ShiftRight(Arg1, 3, Arg1)
            Name(TEMP, Buffer(Arg1) { })
            Add(Arg0, Arg1, Arg1)
            Store(0, Local0)
            While (LLess(Arg0, Arg1))
            {
                Store(RE1B(Arg0), Index(TEMP, Local0))
                Increment(Arg0)
                Increment(Local0)
            }
            Return(TEMP)
        }
        
        Method (WE1B, 2, NotSerialized)
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
            ShiftRight(Arg1, 3, Arg1)
            Name (TEMP, Buffer (Arg1) {})
            Store(Arg2, TEMP)
            Add(Arg0, Arg1, Arg1)
            Store(0, Local0)
            While (LLess(Arg0, Arg1))
            {
                WE1B (Arg0, DerefOf (TEMP [Local0]))
                Increment(Arg0)
                Increment(Local0)
            }
        }
    }
}
//EOF