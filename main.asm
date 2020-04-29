#include "p16f628a.inc"
;pic configuration bits
 __CONFIG _FOSC_INTOSCIO & _WDTE_OFF & _PWRTE_OFF & _MCLRE_OFF & _BOREN_ON & _LVP_OFF & _CPD_OFF & _CP_OFF
 
RES_VECT CODE	0x0000          ;processor reset vector
GOTO START                      ;go to beginning of program
  
CBLOCK 0x20			;declare constants and set them to general purpose register
COUNT1
COUNT2
ENDC
 
START	bsf STATUS, RP0		;set bank 0 to logic 1
	bcf STATUS, RP1		;set bank 1 to logic 0, this combination will select bank 1
	movlw B'00000000'	;make all bits as 0 a.k.a outputs
	movwf TRISB		;move register W values to TRISB register from bank 1
	bcf STATUS, RP0		;set bank 0 to logic 0
	bcf STATUS, RP1		;set bank 1 to logic 0, this combination will select bank 0
	goto MAIN		;go to MAIN program
	
DELAY				;sub program for delay
LOOP1	decfsz COUNT1, 1	;decrement COUNT1 by 1
	goto LOOP1		;go back to LOOP1
	decfsz COUNT2, 1	;decrement COUNT2 by 1
	goto LOOP1		;go back to LOOP1
	return
	
MAIN	bsf PORTB, 5		;set 5th bit from PORTB register to 1 (LED On)
	call DELAY		;call the delay sub program and wait couple milliseconds
	bcf PORTB, 5		;set 5th bit from PORTB register to 0 (Led off)
	call DELAY		;call the delay sub program and wait couple milliseconds
	goto MAIN		;go to MAIN again (infinite loop)
	END			;end of listing
	
	