; --------------------------------------------------------------------
; 6502 assembly on Atari.
; Built with eclipse/wudsn/atasm.

; "HELLO, WHIRLED!" displayed by implementing a minimal 
; display list pointing to memory containing the text.
; This should work on all configurations of 8-bit Atari.
;
; There is no actual code doing work. All the work is 
; accomplished by using the Atari's structured executable 
; load file format to load the display list and screen data,
; and to update he shadow register values to point to the 
; display list and enable the screen display.
;
; An alternative implementation would write the address
; of the text string directly into the OS default display 
; list which requires a fixed address that depends on 48K
; or more memory and NO CARTRIDE installed.
;
; --------------------------------------------------------------------

SDMCTL = $022F ; OS Shadow register for ANTIC's DMACTL (Display DMA Control)
SDLSTL = $0230 ; OS Shadow register for ANTIC's DLISTL (Display List Address)

LOMEM_DOS_DUP = $3308 ; First usable memory after DOS and DUP 

DOS_RUN_ADDR =  $02e0 ; Execute at address stored here when file loading completes.

; --------------------------------------------------------------------

	*=LOMEM_DOS_DUP ; Start "program" after DOS and DUP 

; --------------------------------------------------------------------
; Yup, that's all the "program" there is. 3 bytes of JMP

PRG_START

Do_While_More_Electricity             ; Infinite loop, otherwise the
	jmp Do_While_More_Electricity ; program returns to DOS immediately.

; --------------------------------------------------------------------
; The data.  The text to display and a minimal display list.

HELLO_WHIRLED ; plus one trailing blank space
	.sbyte "HELLO, WHIRLED! " ; .sbyte is internal Atari format
	
DISPLAY_LIST
	.byte $70,$70,$70,$47 ; 3 blank Lines, mode 7 text with Load Memory Scan
	.word HELLO_WHIRLED   ; Display the text
	.byte $41             ; Vertical Blank, then jump to...
	.word DISPLAY_LIST    ; the start of the display list
	
; --------------------------------------------------------------------
; Create the display.  Narrow screen width is used which is 
; exactly 16 Mode 2 characters wide which is the same length
; as the HELLO_WHIRLED text.

	*=SDLSTL  ; Set new Display List address
	.word DISPLAY_LIST
	
	*=SDMCTL  ; Set DMA control. (Screen DMA on + narrow width.)
	.byte $21 

; And that's it -- data loaded from file. Hello, Whirled! with no code.

; --------------------------------------------------------------------
; Store the program start location in the Atari DOS RUN Address.
; When DOS is done loading the executable file into memory it will 
; automatically jump to the address placed here in DOS_RUN_ADDR.

	*=DOS_RUN_ADDR
	.word PRG_START

; --------------------------------------------------------------------
	.end ; finito
