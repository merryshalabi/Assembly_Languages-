; 212018535, 50%
; 324007202, 50%
.ORIG x4000

Mul:
	ST R1,R1_SAVE_MUL		;SAVE ALL THE REGISTERS WE WILL USE IN THE SUBROUTINE
	ST R0,R0_SAVE_MUL
	ST R4,R4_SAVE_MUL  
	ST R5,R5_SAVE_MUL  
	ST R7,R7_SAVE_MUL

	AND R2,R2,#0			;INITIALIZE R2 TO ZERO
	AND R3,R3,#0 
    AND R4,R4,#0
    AND R5,R5,#0
    AND R6,R6,#0                    	;INITIALIZE R3 TO STORE THE SIGN OF THE INPUT

	ADD R0,R0,#0 			;CHECK IF INPUT EQUALS ZERO
	BRz FINISH1_MUL    
	ADD R1,R1,#0
	BRz FINISH1_MUL
	BRn NEGATIVE_1_MUL			 ;IF WE GET HERE,THEN R1 IS NEGATIVE
R0_CHECK1_MUL:
	ADD R0,R0,#0
	BRp LOOP1_MUL 				;IF R0 IS POSITIVE,THEN YOU CAN JUMP TO EXECUTE LOOP1
	NOT R0,R0; 				;IF NOT, CHANGE IT'S SIGN TO POSITIVE
	ADD R0,R0,#1
	ADD R3,R3,#1


LOOP1_MUL:
							;ADD R0 TO R2, R1 TIEMS
	ADD R1,R1,#0
	BRnz END_LOOP1_MUL
	ADD R2,R2,R0
	ADD R1,R1,#-1
	BR LOOP1_MUL

FINISH1_MUL: 					;IF WE GET HERE WE RETURN ZERO BECAUSE OF INPUT
	ADD R2,R2,#0
	BR END_SUB1_MUL


NEGATIVE_1_MUL: 				;HANDLE WITH NEGATIVE INPUT AND CHANGE THEIR SIGN TO POSITIVE
	ADD R3,R3,#1 			;INCREMENT THE COUNTER OF NEGATIVE NUMBERS
	NOT R1,R1;
	ADD R1,R1,#1
	BR R0_CHECK1_MUL

END_LOOP1_MUL: 				;CHOOSE THE SIGN OF THE RESULT ACCORDING TO THE NUMBER OF NEGATIVE REGISTERS
	AND R3,R3,#1
	BRz END_SUB1_MUL 			;IF THE RESULT IS POSITIVE THEN FINISH THE SUBROTINE
	NOT R2,R2 			;ELSE, WE HAVE TO RETURN NEGATIVE INPUT
	ADD R2,R2,#1


END_SUB1_MUL:				 ;RESTORE ALL THE REGISTERS VALUES
	LD R1,R1_SAVE_MUL
	LD R0,R0_SAVE_MUL
	LD R3,R3_SAVE_MUL
	LD R5,R5_SAVE_MUL
	LD R7,R7_SAVE_MUL

RET


R0_SAVE_MUL .FILL #0
R1_SAVE_MUL .FILL #0
R3_SAVE_MUL .FILL #0
R4_SAVE_MUL .FILL #0
R5_SAVE_MUL .FILL #0
R7_SAVE_MUL .FILL #0
.END