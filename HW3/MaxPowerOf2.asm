
.orig x412C

MaxPowerOf2:
	ST R7, R7_SAVE_MAXPOWEROF2
	ST R2, R2_SAVE_MAXPOWEROF2
	ST R3, R3_SAVE_MAXPOWEROF2
	ST R4, R4_SAVE_MAXPOWEROF2
	; R0 = A number.
	; Subroutine will save in R1 the largest power of 2 that can fit in the number we got in R0. If R0 is a negative number, then we will fit in R1 the largest power of two... only with a negative sign.

	AND R1, R1, #0
	
	AND R0, R0, R0		; if R0==0:
	BRz END_MAXPOWEROF2		; we return R1=0
	
	ADD R2, R0, #0		; we're going to save abs(R0) in R2
	BRzp NON_NEGATIVE
	NEGATIVE: 
		NOT R2, R0
		ADD R2, R2, #1	; in case R0 is negative we hold R0's 2's complement in R2
	NON_NEGATIVE:	; now R2 hold abs(R0)
	ADD R3, R2, #-1	; here we handle the case in which abs(R0)=1 (we return R1=1 / R1=-1)
	BRp CONTINUE
	ADD R1, R1, #1
	BR END_LOOP	; we go to END_LOOP, not to END_MAXPOWEROF2, because we might need to change the R1's sign (make it negative)
	
	CONTINUE:	; if we get here it means abs(R0) >=2
	ADD R1, R1, #2
	
	LOOP:	ADD R3, R1, R1	; R3 = 2 * R1
		NOT R4, R3
		ADD R4, R4, #1	; R4 = -R3
		ADD R4, R2, R4	; if abs(R0) - R3 < 0
		BRn END_LOOP	;	get out of LOOP
		ADD R1, R3, #0
		BR LOOP
	END_LOOP:
		AND R0, R0, R0
		BRzp END_MAXPOWEROF2
		NOT R1, R1
		ADD R1, R1, #1
	
	END_MAXPOWEROF2:
		LD R7, R7_SAVE_MAXPOWEROF2
		LD R2, R2_SAVE_MAXPOWEROF2
		LD R3, R3_SAVE_MAXPOWEROF2
		LD R4, R4_SAVE_MAXPOWEROF2
	RET

R7_SAVE_MAXPOWEROF2 .fill #0
R2_SAVE_MAXPOWEROF2 .fill #0
R3_SAVE_MAXPOWEROF2 .fill #0
R4_SAVE_MAXPOWEROF2 .fill #0
	
.END