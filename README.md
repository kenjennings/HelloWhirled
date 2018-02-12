# HelloWhirled

Since I had to create a "hello world" repository as part of the initial Github tutorial, I decided to continue and provide its pitiful existence some sort of purpose.

Here you will find various kinds of "Hello, Whirled!" programs. (This is a close relative of the more advanced "Visualize Whirled Peas!" application.)


[![HelloWhirled](https://github.com/kenjennings/HelloWhirled/blob/master/HelloWhirled.png)](#features)


The excitement is overwhelming.


| **Program** | **Summary** | 
| ------- | ------- |
| **BASICALLY BASIC** | |
|[ATARI_BASIC](https://github.com/kenjennings/HelloWhirled/blob/master/ATARI_BASIC "ATARI_BASIC") | Ye old, standard Atari BASIC using yon venerable "PRINT". |
|[ATARI_BASICXL](https://github.com/kenjennings/HelloWhirled/blob/master/ATARI_BASICXL "ATARI_BASICXL") | OSS BASIC XL on Atari using "Print".  Note how the pretty, mixed-case keywords do dramatically improve performance and efficiency. |
|[ATARI_BASICXL_BIGTEXT](https://github.com/kenjennings/HelloWhirled/blob/master/ATARI_BASICXL_BIGTEXT "ATARI_BASICXL_BIGTEXT") | OSS BASIC XL on Atari.  Small change to engage the large text mode for display.  (The difference here is writing to channel #6, the S: device for screen graphics.) |
| **Assembly Shenanigans** | |
|[ATARI_ATASM_CIO_PUTBYTES.asm](https://github.com/kenjennings/HelloWhirled/blob/master/ATARI_ATASM_CIO_PUTBYTES.asm "ATARI_ATASM_CIO_PUTBYTES.asm") | Use the official, legally sanctioned call through the OS Central I/O to write the string to the screen (E: device.) |
| [ATARI_ATASM_CIO_PUTCHEAT.asm](https://github.com/kenjennings/HelloWhirled/blob/master/ATARI_ATASM_CIO_PUTCHEAT.asm "ATARI_ATASM_CIO_PUTCHEAT.asm") | Uses the OS Central I/O in a slightly less than sanctioned way to write the characters to the screen (E: device.)  It reduces the IOCB set up by using the PUT CHAR vector shortcut in the IOCB channel which is intended for Atari BASIC, but changes the model to a less efficient iteration printing individual characters. |
| [ATARI_ATASM_DIRECTWRITE.asm](https://github.com/kenjennings/HelloWhirled/blob/master/ATARI_ATASM_DIRECTWRITE.asm "ATARI_ATASM_DIRECTWRITE.asm") | Uses the OS's Page 0 pointer to the current display to write (or, POKE) directly into screen memory. |
| **DISK LOAD ABUSE** | |
| [ATARI_ATASM_DISPLAYLIST.asm](https://github.com/kenjennings/HelloWhirled/blob/master/ATARI_ATASM_DISPLAYLIST.asm "ATARI_ATASM_DISPLAYLIST.asm") | Display text without executing any code. Uses the Atari's executable load file to replace the OS's default display list LMS address operand's value with the address of the "Hello Whirled!" text string in memory.  Since this manipulates a fixed memory location it requires specific configuration -- 48K or more RAM and NO CARTRIDGE installed. |
| [ATARI_ATASM_DISPLAYLIST_EXTRA.asm](https://github.com/kenjennings/HelloWhirled/blob/master/ATARI_ATASM_DISPLAYLIST_EXTRA.asm "ATARI_ATASM_DISPLAYLIST_EXTRA.asm") |  Display text without executing any code. Uses the Atari's executable load file to load a minimal display list showing the text, and directly updates the OS's ANTIC shadow registers to install the display list. |
| [ATARI_ATASM_SCREENRAM.asm](https://github.com/kenjennings/HelloWhirled/blob/master/ATARI_ATASM_SCREENRAM.asm "ATARI_ATASM_SCREENRAM.asm") | Display text without executing any code. Uses the Atari's executable load file to load the text directly into the screen RAM for the OS's default text display. Since this refers to a fixed memory location it requires specific configuration -- 48K or more RAM and NO CARTRIDGE installed. |
