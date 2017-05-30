; --------------------------------------------------------------------
; 6502 assembly on Atari.
; Built with eclipse/wudsn/atasm.

; "Hello, Whirled!" displayed by loading the text directly
; into screen memory from the file. 
;
; There is no actual code doing work. This is accomplished by 
; using the Atari's structured executable load file format to 
; populate screen RAM directly from the file.
; 
; --------------------------------------------------------------------
; $XXXX is the starting address of the screen RAM when 
; there is 48K or more of memory and NO CARTRIDGE loaded.
;
SCREEN_RAM=$BC20

; --------------------------------------------------------------------

LOMEM_DOS_DUP = $3308 ; First usable memory after DOS and DUP 

DOS_RUN_ADDR =  $02e0 ; Execute at address stored here when file loading completes.

; --------------------------------------------------------------------

	*=LOMEM_DOS_DUP ; Start program at first usable memory after DOS and DUP 

; --------------------------------------------------------------------
; Yup, that's all the "program" there is. 3 bytes of JMP

PRG_START

Do_While_More_Electricity         ; Infinite loop, otherwise the
	jmp Do_While_More_Electricity ; program returns to DOS immediately.
	
; --------------------------------------------------------------------
; Create the display.   
; Set load address to the screen RAM location and then load the data
; for the text directly into memory.
 
	*=SCREEN_RAM 
	.sbyte "Hello, Whirled!"      ; .sbyte is internal Atari format
	
; and that's it.  Hello, Whirled! with no code.

; --------------------------------------------------------------------
; Store the program start location in the Atari DOS RUN Address.
; When DOS is done loading the executable file into memory it will 
; automatically jump to the address placed here in DOS_RUN_ADDR.

	*=DOS_RUN_ADDR
	.word PRG_START

; --------------------------------------------------------------------
	.end ; finito
