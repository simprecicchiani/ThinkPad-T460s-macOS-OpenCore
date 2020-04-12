// SSDT for function keys. For ThinkPad T450.
// John Davis - Goldfish64

DefinitionBlock("", "SSDT", 2, "hack", "FNKEY", 0)
{
    // External references to EC__, keyboard, and original methods.
    External(_SB.PCI0.LPC_.EC__, DeviceObj)
    External(_SB.PCI0.LPC_.KBD_, DeviceObj)
    External(_SB.PCI0.LPC_.EC__.XQ6A, MethodObj)
    External(_SB.PCI0.LPC_.EC__.XQ15, MethodObj)
    External(_SB.PCI0.LPC_.EC__.XQ14, MethodObj)
    External(_SB.PCI0.LPC_.EC__.XQ16, MethodObj)
    External(_SB.PCI0.LPC_.EC__.XQ64, MethodObj)
    External(_SB.PCI0.LPC_.EC__.XQ66, MethodObj)
    External(_SB.PCI0.LPC_.EC__.XQ67, MethodObj)
    External(_SB.PCI0.LPC_.EC__.XQ68, MethodObj)
    External(_SB.PCI0.LPC_.EC__.XQ69, MethodObj)
    
    Scope(\_SB.PCI0.LPC_.EC__)
    {
        // _Q6A - (Fn+F4) microphone mute key.
        Method(_Q6A, 0, NotSerialized)  // _Qxx: EC__ Query
        {
            // Send a one-shot event (down then up) for scancode 64 to keyboard device. This
            // is picked up by VoodooPS2 and sent to macOS as the F20 key.
            Notify(\_SB.PCI0.LPC_.KBD, 0x036b)
            
            // Call original _Q6A method.
            \_SB.PCI0.LPC_.EC__.XQ6A()
        }
        
        // _Q15 - (Fn+F5) brightness down key.
        Method(_Q15, 0, NotSerialized)  // _Qxx: EC__ Query
        {
            // Send a one-shot event (down then up) for scancode e0 05 to keyboard device. This
            // is picked up by VoodooPS2 and sent to macOS as the F14 (brightness down) key.
            Notify(\_SB.PCI0.LPC_.KBD, 0x0405)
            
            // Call original _Q15 method.
            \_SB.PCI0.LPC_.EC__.XQ15()
        }
        
        // _Q14 - (Fn+F6) brightness up key.
        Method(_Q14, 0, NotSerialized)  // _Qxx: EC__ Query
        {
            // Send a one-shot event (down then up) for scancode e0 06 to keyboard device. This
            // is picked up by VoodooPS2 and sent to macOS as the F15 (brightness up) key.
            Notify(\_SB.PCI0.LPC_.KBD, 0x0406)
            
            // Call original _Q14 method.
            \_SB.PCI0.LPC_.EC__.XQ14()
        }
        
        // _Q16 - (Fn+F7) projEC__tor key.
        Method(_Q16, 0, NotSerialized)  // _Qxx: EC__ Query
        {
            // Send a one-shot event (down then up) for scancode 67 to keyboard device. This
            // is picked up by VoodooPS2 and sent to macOS as the F16 key.
            Notify(\_SB.PCI0.LPC_.KBD, 0x0367)
            
            // Call original _Q16 method.
            \_SB.PCI0.LPC_.EC__.XQ16()
        }
        
        // _Q64 - (Fn+F8) Wireless disable key.
        Method(_Q64, 0, NotSerialized)  // _Qxx: EC__ Query
        {
            // Send a one-shot event (down then up) for scancode 68 to keyboard device. This
            // is picked up by VoodooPS2 and sent to macOS as the F17 key.
            Notify(\_SB.PCI0.LPC_.KBD, 0x0368)
            
            // Call original _Q64 method.
            \_SB.PCI0.LPC_.EC__.XQ64()
        }
        
        // _Q66 - (Fn+F9) Settings key.
        Method(_Q66, 0, NotSerialized)  // _Qxx: EC__ Query
        {
            // Send a one-shot event (down then up) for scancode 69 to keyboard device. This
            // is picked up by VoodooPS2 and sent to macOS as the F18 key.
            Notify(\_SB.PCI0.LPC_.KBD, 0x0369)
            
            // Call original _Q66 method.
            \_SB.PCI0.LPC_.EC__.XQ66()
        }
        
        // _Q67 - (Fn+F10) Search key.
        Method(_Q67, 0, NotSerialized)  // _Qxx: EC__ Query
        {
            // Send a down event for the Alt key (scancode e0 5b), then a one-shot event (down then up) for
            // the spacebar (scancode 39), and finally an up event for the Alt key (break scancode e0 db).
            // This is picked up by VoodooPS2 and sent to macOS as the Command+Space key combo for Spotlight.
            //
            // If you wish to use the Windows key as the Command key instead, you will need to adjust this to
            // send the scancodes for one of the Windows keys.
            Notify(\_SB.PCI0.LPC_.KBD, 0x0138)
            Notify(\_SB.PCI0.LPC_.KBD, 0x0339)
            Notify(\_SB.PCI0.LPC_.KBD, 0x01b8)
            
            // Call original _Q67 method.
            \_SB.PCI0.LPC_.EC__.XQ67()
        }
        
        // _Q68 - (Fn+F11) App switcher key.
        Method(_Q68, 0, NotSerialized)  // _Qxx: EC__ Query
        {
            // Send a down event for the Control key (scancode 1d), then a one-shot event (down then up) for
            // the up arrow key (scancode 0e 48), and finally an up event for the Control key (break scancode 9d).
            // This is picked up by VoodooPS2 and sent to macOS as the Control+Up key combo for Mission Control.
            Notify(\_SB.PCI0.LPC_.KBD, 0x011d)
            Notify(\_SB.PCI0.LPC_.KBD, 0x0448)
            Notify(\_SB.PCI0.LPC_.KBD, 0x019d)
            
            // Call original _Q68 method.
            \_SB.PCI0.LPC_.EC__.XQ68()
        }
        
        // _Q69 - (Fn+F12) Start screen key.
        Method(_Q69, 0, NotSerialized)  // _Qxx: EC__ Query
        {
            // Send a one-shot event (down then up) for scancode 6a to keyboard device. This
            // is picked up by VoodooPS2 and sent to macOS as the F19 key.
            Notify(\_SB.PCI0.LPC_.KBD, 0x036a)
            
            // Call original _Q69 method.
            \_SB.PCI0.LPC_.EC__.XQ69()
        }
    }
}
