# pico680b-monitor-asm-gettingproc

I got the monitor asm code from monitor binary of this repository: https://github.com/simple-circuit/picobug/ .
I write down the procedures to get monitor asm code here.

The LICENSE is set under same for original monitor binary (GPL3).
https://github.com/simple-circuit/picobug/blob/main/LICENSE

Procedure to get monitor asm code
1. get monitor asm code binary from ino.
   https://github.com/simple-circuit/picobug/blob/main/sim680b_rev1.ino
   > static uint16_t PICO_BUG[1133] = {0x8E
   > :
   > ...};
   you could binary from above code. paste to notepad or favorite editor.
2. convert binary () to s19 format
   
   > 0x8E,0x00,0xF1,0x9F,0xF6,0xCE,0x01,0x00,0xDF,0xFA,0x5F,0xD7,0xF3...
   > :
   > 0x01,0x00,0xFB,0xA5,0x01,0x04,0xFB,0x93
   
