# HelloWhirled

Since I had to create a "hello world" repository as part of the initial tutorial, I decided to continue and provide its pitiful existence some sort of purpose.

Here you will find various kinds of "Hello, Whirled!" programs. (This is a close relative of the more advanced "Visualize Whirled Peas!" application.)


[![HelloWhirled](https://github.com/kenjennings/HelloWhirled/blob/master/HelloWhirled.png)](#features)


The excitement is overwhelming.


ATARI_ATASM_CIO_PUTBYTES -- 6502 Assembly for atasm.  Uses the official, legally sanctioned I/O method.  It uses the OS Central I/O to write the string to the screen (E: device.)

ATARI_ATASM_CIO_PUTCHEAT -- 6502 Assembly for atasm.  Uses the OS Central I/O to write the characters to the screen (E: device.)  It does this using the PUT CHAR vector provided in the IOCB channel.  This cuts down the amount of IOCB setup needed, but changes the model to a less efficient iteration printing individual characters.

ATARI_ATASM_DIRECTWRITE -- 6502 Assembly for atasm.  Uses (abuses) the OS Page 0 Pointer to the screen to write directly into screen memory.

ATARI_ATASM_DISPLAYLIST -- 6502 Assembly for atasm.  Display "Hello, Whirled!", technically without any actual code executing.  This abuses the Atari's executable load file to replace the OS default display list LMS address operand's value with the address of the "Hello, Whirled" string.  Since this manipulates a fixed location in memory it requires specific configuration -- 48K or more RAM and NO CARTRIDGE installed. 

ATARI_ATASM_DISPLAYLIST_EXTRA.asm -- 6502 Assembly for atasm.  Display "Hello, Whirled!", technically without any actual code executing.  This uses (and abuses) the Atari's executable load file to install a minimal display list showing the "Hello, Whirled" string.  It abuses the executable load file by updating the OS shadow registers to install the display list.  This should run on any configuration Atari capable of loading DOS.

ATARI_ATASM_SCREENRAM.asm -- 6502 Assembly for atasm.  Display "Hello, Whirled!", technically without any actual code executing.  This abuses the Atari's executable load file to write the "Hello, Whirled" string directly into screen RAM.  Since this refers to a fixed location in memory it requires specific configuration -- 48K or more RAM and NO CARTRIDGE installed. 
  
ATARI_BASIC -- Ye old, standard Atari BASIC using "PRINT". 

ATARI_BASICXL -- OSS BASIC XL on Atari using "Print".  Note the pretty, mixed-case keywords. It really is an improvement.

ATARI_BASICXL_BIGTEXT -- OSS BASIC XL on Atari.  Small change to engage the large text mode for display.  (The difference here is writing to channel #6, the S: device for screen graphics.)
