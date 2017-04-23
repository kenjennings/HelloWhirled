; --------------------------------------------------------------------
; 6502 assembly on Atari.
; Built with eclipse/wudsn/atasm.

; "Hello, Whirled!" displayed by writing directly to screen
; memory via the OS's page 0 pointer, SAVMSC.

SAVMSC = $58 ; word. Address of first byte of screen memory.

LOMEM_DOS_DUP = $3308 ; First usable memory after DOS and DUP 

DOS_RUN_ADDR =  $02e0 ; Execute at address stored here when file loading completes.

; --------------------------------------------------------------------

*=LOMEM_DOS_DUP ; Start program at first usable memory after DOS and DUP 

PRG_START

; --------------------------------------------------------------------
; Note that by writing directly to screen memory the ATASCII text codes 
; cannot be used. Instead, the text data must be in the Atari internal 
; format. This is handled by using .sbyte instead of .byte for data storage.
;
; The standard Atari EOL $9B is used to mark the end of string. 
; 0 cannot be used, because that is the internal code for a blank space.
;
; Note that using an index for iterating through data and screen memory
; means this is limited to 256 bytes of output to the screen.  Writing 
; more would mean resetting the pointer to the screen and using a new
; base for the index.

	ldy #0

Copy_Text_To_Screen
	lda HELLO_WHIRLED,y           ; Read from the data
	cmp #$9B                      ; Is this the end of string?
	beq Do_While_More_Electricity ; Yes, go to end of program.
	sta (SAVMSC),y                ; Write byte to scrteen memory.
	iny                           ; Increment index to string and screen.
	bne Copy_Text_To_Screen       ; Do the next character.

Do_While_More_Electricity         ; Infinite loop, otherwise the
	jmp Do_While_More_Electricity ; program returns to DOS immediately.
		
HELLO_WHIRLED
	.sbyte "Hello, Whirled!"      ; .sbyte is internal Atari format
	.byte $9b
	
; --------------------------------------------------------------------
; Store the program start location in the Atari DOS RUN Address.
; When DOS is done loading the executable it will automatically
; jump to the address placed hre in DOS_RUN_ADDR.

	*=DOS_RUN_ADDR
	.word PRG_START

; --------------------------------------------------------------------
	.end ; finito
