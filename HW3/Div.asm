; 212018535, 50%
; 324007202, 50%
.ORIG X4064

Div:

	ST R1,R1_SAVE_DIV	;SAVE ALL THE REGISTERS WE WILL USE IN THE SABROUTINE
	ST R0,R0_SAVE_DIV
	ST R5,R5_SAVE_DIV  
	ST R4,R4_SAVE_DIV  		
	ST R7,R7_SAVE_DIV
	
	AND R2,R2,#0		; INITIALIZE THE OUTPUT REGISTERS
	AND R3,R3,#0
	AND R4,R4,#0
	AND R5,R5,#0
	
	
	ADD R1,R1,#0		; CHECK INVALID INPUT 
	BRz INVALID_INPUT_DIV
	BRn NEGATIVE_R1_DIV		; CHECK IF R1 IS NEGATIVE

R0_CHECK2_DIV:
	ADD R0,R0,#0		; IF R0 EQUALS TO ZERO THEN RETURN 0
	BRz END_SUB2_DIV	
	BRp CONTINUE2_DIV		; IF R0 IS POSITIVE THEN IT'S ALLOWED TO EXECUTE LOOP2
	NOT R0,R0			; IF NOT,FLIP IT'S SIGN 
	ADD R0,R0,#1
	ADD R4,R4,#1		; INCREMENT FOR THE COUNTER OF NEGATIVE NUMBERS
	

CONTINUE2_DIV:				; R5=-|R1|, WE WILL USE IT IN LOOP2
	ADD R5,R1,#0
	NOT R5,R5
	ADD R5,R5,#1
	
	
LOOP2_DIV:
	ADD R0,R0,R5		; WHILE R0 > R5
	BRnz END_LOOP2_DIV
	ADD R2,R2,#1		; ADD 1 TO THE DIVISION RESULT
	BR LOOP2_DIV

END_LOOP2_DIV:				; CHECK THE FINAL VALUE IN R0
	ADD R0,R0,#0
	BRn R0_SMALLER_THAN_R1	; R0 < R1
	ADD R2,R2,#1		; WE MUST ADD 1 TO THE DIVISION RESULT TO GET THE CORRECT ANSWER
	BR FINISH2_DIV

R0_SMALLER_THAN_R1:
	ADD R0,R0,#0
	BRzp FINISH2_DIV
	ADD R0,R0,R1		

FINISH2_DIV:	
	ADD R3,R0,#0		; SAVE THE REMAINDER IN R3
	AND R4,R4,#1		; CHECK THE COUNTER OF NEGATIVE NUMBERS (BY MOD 2)
	BRz END_SUB2_DIV		;IF THE RESULT SIGN IS POSITVE THEN GO TO END 
	NOT R2,R2			;ELSE, WE HAVE TO RETURN NEGATIVE SIGN 
	ADD R2,R2,#1
	BR END_SUB2_DIV
	
NEGATIVE_R1_DIV:
	ADD R4,R4,#1		; INCREMENT FOR THE COUNTER OF NEGATIVE NUMBERS
	NOT R1,R1;			; FLIP R1 TO POSOTIVE
	ADD R1,R1,#1
	BR R0_CHECK2_DIV		; CONTINUE TO CHECK R0

INVALID_INPUT_DIV:			; RETURN -1 IN EACH REGISTER IF THE INPUT IS INVALID
	ADD R2,R2,#-1
	ADD R3,R3,#-1

END_SUB2_DIV:				;RESTORE ALL THE REGISTERS VALUES
	LD R1,R1_SAVE_DIV
	LD R0,R0_SAVE_DIV
	LD R4,R4_SAVE_DIV
	LD R5,R5_SAVE_DIV
	LD R7,R7_SAVE_DIV

RET	

R1_SAVE_DIV .FILL #0
R0_SAVE_DIV .FILL #0
R4_SAVE_DIV .FILL #0
R5_SAVE_DIV .FILL #0
R7_SAVE_DIV .FILL #0
.END