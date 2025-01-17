# pico680b-monitor-asm-gettingproc
NOTICE: 2025/01/11 17:33
I got virus warning from windows defender downloading a68's zip from bellow today now.
https://github.com/glitchwrks/a68/archive/refs/heads/master.zip
with Chrome 131.0.6778.265（Official Build） （64bit）.
That download was stopped by Chrome automatically, so I did not download. 
I have no other Virus Scanner of other kind. So I could not test if it was true or false.

But I did bellow with git clone on WSL2 of my env.
You should use git clone: from https://github.com/glitchwrks/a68.git better.

I got the monitor asm code from monitor binary of this repository: https://github.com/simple-circuit/picobug/ .
I write down the procedures to get monitor asm code here.

The LICENSE is set under same for original monitor binary (GPL3).
https://github.com/simple-circuit/picobug/blob/main/LICENSE

Procedure to get monitor asm code

## 1. get monitor asm code binary from ino.

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

## 2. Convert binary () to s19 format with mymot.ipynb (on this repo).

   Paste above binary into array a of mymot.ipynb.
   then exec mymot.ipynb on google colaboratory.
   You would get srec on output of the final code pain.
   <PRE>
   > S113FB938E00F19FF6CE0100DFFA5FD7F3D7F27E32
   > :
   > S110FFF301010101010100FBA50104FB93C4</PRE>

## 3. paste s19 file to notepad or your favorite edit and save it to the file.

## 4. disassemble the above s19 file with f9dasm.

   https://github.com/Arakula/f9dasm
   https://github.com/Arakula/f9dasm/releases has windows binary.
   like this:
   <PRE>
   C:\Users\user\Downloads>f9dasm -6800 -begin fb93 -end ffff picobug4t.s19 > picobug4t.asm
   </PRE>
   So, you get assembler source code, but this has several points to mitigate.

## 5. Mainly you should mitigate to asm is two points.

## 5.1 remove &gt;M before head of jump labels

<PRE>
   > $ grep -c ">M" picobug4t.asm
   > 8</PRE>
   I edit asm code file with vim (ex mode) like this.
   <PRE>
   > :1,$ s/>M/M/g</PRE>

## 5.2 put 0 to ",X" (like LDAA ,X to LDAA 0,X)

<PRE>
   > grep -c " ,X" picobug4t.asm
   > 12</PRE>
   I edit asm code file with vim (ex mode) like this.
<PRE>
   > :1,$ s/ ,X/ 0,X/g</PRE>

## 6. assemble asm code

   <PRE>
   > a68 picobug4t.asm -l picobug4t.lst -s picobug4t.s19
   </PRE>
   There were 2 errors still.
     That cause were bellow(picobug3.asm has no error, picobug4t.asm has 2 error for assemble).
   <PRE>
   > diff -bitw picobug4t.asm picobug3.asm
   > 7a11
   >       Org $00EE
   > 8a13
   >       Org $00f1
   </PRE>
   ![image](https://github.com/user-attachments/assets/6676d850-a757-4871-ba45-c5cf1d1ac8bf)
   Above two were indeed no need.
   True error cause were hedead two header line bellow.
   <PRE>
   >f9dasm: M6800/1/2/3/8/9 / H6309 Binary/OS9/FLEX9 Disassembler V1.83
   >Loaded Motorola S file picobug4t.s19</PRE>
   Edit like this.
<PRE>
   >;f9dasm: M6800/1/2/3/8/9 / H6309 Binary/OS9/FLEX9 Disassembler V1.83
   >;Loaded Motorola S file picobug4t.s19</PRE>

## 7. convert s19 to array with a.awk (on this repo)
<PRE>
   > $ awk -f a.awk picobug4t.s19 > picobug4t.txt</PRE>

## 8.edit picobug4t.txt with vim(ex mode).
<PRE>
:1,$ s/^/0x/g</PRE>
<PRE>
:1,$ s/ /,0x/g</PRE>
<PRE>
:1,$ s/0x$//g</PRE>
## 9.paste back picobug4t.txt into body of array PICO_BUG on sim680b_rev1.ino.
## 9.Build .ino with vscode or your IDE.

awk script was got https://news.mynavi.jp/article/pebble_in_the_window-133/ , but
slightly change from -8-3 to -8 -2 :). Thank you.
Written with [StackEdit](https://stackedit.io/).
