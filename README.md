# pico680b-monitor-asm-gettingproc

I got the monitor asm code from monitor binary of this repository: https://github.com/simple-circuit/picobug/ .
I write down the procedures to get monitor asm code here.

The LICENSE is set under same for original monitor binary (GPL3).
https://github.com/simple-circuit/picobug/blob/main/LICENSE

Procedure to get monitor asm code
1. get monitor asm code binary from ino.
   https://github.com/simple-circuit/picobug/blob/main/sim680b_rev1.ino
   <PRE>
   > static uint16_t PICO_BUG[1133] = {0x8E
   > :
   > ...};</PRE>
   you could binary from above code. paste to notepad or favorite editor.
   <PRE>
   > 0x8E,0x00,0xF1,0x9F,0xF6,0xCE,0x01,0x00,0xDF,0xFA,0x5F,0xD7,0xF3...
   > :
   > 0x01,0x00,0xFB,0xA5,0x01,0x04,0xFB,0x93</PRE>
3. Convert binary () to s19 format with mymot.ipynb (on this repo).
   Paste above binary into array a of mymot.ipynb.
   then exec mymot.ipynb on google colaboratory.
   You would get srec on output of the final code pain.
   <PRE>
   > S113FB938E00F19FF6CE0100DFFA5FD7F3D7F27E32
   > :
   > S110FFF301010101010100FBA50104FB93C4</PRE>
5. paste s19 file to notepad or your favorite edit and save it to the file.
6. disassemble the above s19 file with f9dasm.
   https://github.com/Arakula/f9dasm
   https://github.com/Arakula/f9dasm/releases has windows binary.
   like this:<PRE>
   C:\Users\user\Downloads>f9dasm -6800 -begin fb93 -end ffff picobug2.s19 > picobug2.asm
   </PRE>
   So, you get assembler source code, but this has several points to mitigate.

   
