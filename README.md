# HelloWhirled

Since I had to create a "hello world" repository as part of the initial tutorial, I decided to continue and provide its pitiful existence some sort of purpose.

Here you will find various kinds of "Hello, Whirled!" programs. (This is a close relative of the more advanced "Visualize Whirled Peas!" application.)


[![HelloWhirled](https://github.com/kenjennings/HelloWhirled/blob/master/HelloWhirled.png)](#features)


The excitement is overwhelming.


ATARI_ATASM_CIO_PUTBYTES -- 6502 Assembly for atasm.  Uses the OS Central I/O to write the string to the screen (E: device.)

ATARI_ATASM_DIRECTWRITE -- 6502 Assembly for atasm.  Uses (abuses) the OS Page 0 Pointer to the screen to write directly into screen memory.

ATARI_BASIC -- Ye old, standard Atari BASIC using "PRINT". 

ATARI_BASICXL -- OSS BASIC XL on Atari using "Print".  Note the pretty, mixed-case keywords. It really is an improvement.

ATARI_BASICXL_BIGTEXT -- OSS BASIC XL on Atari.  Small change to engage the large text mode for display.  (The difference here is writing to channel #6, the S: device for screen graphics.)
