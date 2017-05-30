; --------------------------------------------------------------------
; 6502 assembly on Atari.
; Built with eclipse/wudsn/atasm.
;
; "Hello, Whirled!" displayed in screen via CIO by abusing the
; the IOCB's PUT CHAR vector which is really intended for BASIC.
; This cheat allows bypassing most knowledge of IOCB in the code.
; --------------------------------------------------------------------
;
; Necessary Central I/O values.
;
IOCB = $0340     ; Base IO Control Block, Channel 0, E: by default
;
ICPTL = IOCB+$06 ; PUT CHAR routine (low)
ICPTH = IOCB+$07 ; PUT CHAR routine (high)
;
; Borrow a page 0 location that isn't used by BASIC or the OS for 
; the purposes of this program.  Need to preserve the Y register, 
; because the PUT CHAR will change all the registers.
FR0 =    $D4 ; float.  Floating point register and USR return value to BASIC.

; --------------------------------------------------------------------

; Program run information...
LOMEM_DOS_DUP = $3308 ; First usable memory after DOS and DUP 

DOS_RUN_ADDR =  $02e0 ; Execute at address stored here when file loading completes.

; --------------------------------------------------------------------

	*=LOMEM_DOS_DUP ; Start program at first usable memory after DOS and DUP 

PRG_START

; --------------------------------------------------------------------
; Iterate through the string character by character and
; call the PutCH routine.
;
	ldy #0
	
Write_Hello_String
	lda HELLO_WHIRLED,y           ; Read from the data
	cmp #$9B                      ; Is this the end of string?
	beq Do_While_More_Electricity ; Yes, go to end of program.

	sty FR0                       ; Need to save Y.  PutCH will change it.
	jsr PutCH                     ; Used the CIO PutCH in IOCB0
	ldy FR0                       ; Restore Y.

	iny                           ; Increment index to string and screen.
	bne Write_Hello_String        ; Do the next character.

Do_While_More_Electricity         ; Infinite loop, otherwise the
	jmp Do_While_More_Electricity ; program returns to DOS immediately.

	rts                           ; Well, it will never get here.

HELLO_WHIRLED
	.byte "Hello, Whirled!",$9B   ; ATASCII text, with end of line


;---------------------------------------------------------------------
; Write a character to the screen.
; Push the address of the E: device PutChar routine held in 
; IOCB0 onto the stack and call it. 
; INPUT:
; A = character to write
; NOTE:
; OS will modify all registers.
;---------------------------------------------------------------------
PutCH
	sta OUTPUT ; Self modifying code - save the byte below.

	lda ICPTH ; High byte for PUT CHAR in E:/IOCB Channel 0.
	pha       ; Push to stack

	lda ICPTL ; Low byte for PUT CHAR in E:/IOCB Channel 0.
	pha       ; Push to stack

OUTPUT = *+1
	lda #$00 ; Modified at routine entry.

	; This rts actually triggers calling the address of the E:
	; device PUT CHAR routine pushed onto the stack above. 
	rts  

	
; --------------------------------------------------------------------
; Store the program start location in the Atari DOS RUN Address.
; When DOS is done loading the executable it will automatically
; jump to the address placed here in DOS_RUN_ADDR.

	*=DOS_RUN_ADDR
	.word PRG_START

; --------------------------------------------------------------------
	.end ; finito
