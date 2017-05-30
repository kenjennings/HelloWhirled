; --------------------------------------------------------------------
; 6502 assembly on Atari.
; Built with eclipse/wudsn/atasm.
;
; "Hello, Whirled!" displayed by using the OS's Central I/O 
; to write to E: device using the PUT BYTES command.
;
; Necessary Central I/O values.
;
CIOV = $E456        ; CIO Vector
;
CIO_PUT_BYTES = $0B ; Command to write bytes
;
IOCB = $0340        ; Base IO Control Block, Channel 0, E: by default
;
ICCMD = IOCB+$02    ; ** CIO Command
ICBAL = IOCB+$04    ; ** Buffer address (low)
ICBAH = IOCB+$05    ; ** Buffer address (high) 
ICBLL = IOCB+$08    ; ** Buffer length (low)
ICBLH = IOCB+$09    ; ** Buffer length (high)  
;
; Program run information...
LOMEM_DOS_DUP = $3308 ; First usable memory after DOS and DUP 

DOS_RUN_ADDR =  $02e0 ; Execute at address stored here when file loading completes.

; --------------------------------------------------------------------

	*=LOMEM_DOS_DUP ; Start program at first usable memory after DOS and DUP 

PRG_START

; --------------------------------------------------------------------
; Load up what is necessary in the Central I/O control block for the 
; E: device and call CIO vector to write the string.
; It is technically correct to use the X index addressing where the 
; value of X is the channel number * 16.   
; However, since this is using channel 0 which is the E: device by 
; default the indexed addressing could be left off entirely.

	ldx #0 ; CIO channel number * 16. (Though 0 * 16 is still = 0)

	; Note that PUT BYTES and PUT RECORD commands work equally well.

	lda #CIO_PUT_BYTES  ; Set the command to write data.
	sta ICCMD,x
	
	lda #<HELLO_WHIRLED ; Set the starting address of the string.
	sta ICBAL,x
	lda #>HELLO_WHIRLED
	sta ICBAH,x
	
	lda #$10            ; Set the length of the string.
	sta ICBLL,x 
	lda #0 
	sta ICBLH,x 
	
	jsr CIOV ; Engage, Mr Crusher.

	; FYI: On return from CIOV the CPU N flag is set if there was 
    ; an error and the error code is in Y register.  But we don't
	; care for the simple purposes of Hello, Whirled!

Do_While_More_Electricity         ; Infinite loop, otherwise the
	jmp Do_While_More_Electricity ; program returns to DOS immediately.

	rts                           ; Well, it will never get here.

HELLO_WHIRLED
	.byte "Hello, Whirled!",$9b   ; ATASCII text
	
; --------------------------------------------------------------------
; Store the program start location in the Atari DOS RUN Address.
; When DOS is done loading the executable it will automatically
; jump to the address placed here in DOS_RUN_ADDR.

	*=DOS_RUN_ADDR
	.word PRG_START

; --------------------------------------------------------------------
	.end ; finito
