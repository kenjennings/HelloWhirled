; --------------------------------------------------------------------
; 6502 assembly on Atari.
; Built with eclipse/wudsn/atasm.

; "Hello, Whirled!" displayed by changing the graphics mode 0
; display list's initial memory scan address to point to 
; the buffer in the program.  
;
; There is also callous disregard for whatever may follow the 
; program in memory.  The screen will also show whatever junk 
; happens to follow in memory.  If that is nonzero bytes, then 
; other characters will appear on screen.  (On a cold boot 
; memory will likely be 0. But, if any program is run before 
; this program, then there may be visible data.)
;
; There is no actual code doing work. This is accomplished by 
; using the Atari's structured executable load file format to 
; load the address of the Hello, Whirled! string directly to 
; the LMS instruction's address operand.
; 
; --------------------------------------------------------------------
; $BC20 is the starting address of the display list when 
; there is 48K or more of memory and NO CARTRIDGE loaded.
; The mode instruction is at the base display list address
; plus 3 bytes.  The LMS address operand is the word that
; follows at display list base plus 4.
;
DISPLAY_LIST=$BC20
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
; The data.  "Hello, Whirled!" text.

HELLO_WHIRLED
	.sbyte "Hello, Whirled!"      ; .sbyte is internal Atari format

; --------------------------------------------------------------------
; Create the display.   
; Set load address to the display list LMS address operand and store
; the address of the HELLO_WHIRLED text.
 
	*=[DISPLAY_LIST+4] 
 	.word HELLO_WHIRLED ; And store the address of the string.
	
; and that's it.  Hello, Whirled! with no code.

; --------------------------------------------------------------------
; Store the program start location in the Atari DOS RUN Address.
; When DOS is done loading the executable file into memory it will 
; automatically jump to the address placed here in DOS_RUN_ADDR.

	*=DOS_RUN_ADDR
	.word PRG_START

; --------------------------------------------------------------------
	.end ; finito
