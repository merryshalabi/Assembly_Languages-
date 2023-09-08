; 212018535, 50%
; 324007202, 50%
.ORIG x412C
CheckOverflow:
ST R0 R0_SAVE_CheckOverflow
ST R1 R1_SAVE_CheckOverflow
ST R7 R7_SAVE_CheckOverflow ; STORING THE IITIAL VALUES OF THE REGISTERS 
ST R3 R3_SAVE_CheckOverflow

AND R2 R2 #0 ;INITIALIZING R2 
ADD R1 R1 #0 ; cheks value of R1, if positive goes to R1Positive to check first case
BRp R1Positive
BRn R1Negative ;if negative goes to R1Negative to check second case 
BR FINISH_CheckOverflow	;if R1 then goes to FINISH , wouldn't be overflow 

R1Positive: ; first case ( adding two positive numbers gives a negative number)
ADD R0 R0 #0 ; checks value of R0, if not positive goes to FINISH, overflow wouldn't occur
BRnz FINISH_CheckOverflow
ADD R3 R1 R0 ; adding R1+R0
BRp FINISH_CheckOverflow ; if answer is still positive then there's no overflow, goes to FINISH 
ADD R2 R2 #1 ;else there's overflow , R2=1
BR FINISH_CheckOverflow    ; goes to finish loop

R1Negative ; second case (adding two negative number gives a positive number)
ADD R0 R0 #0 ; cheks value of R0 
BRzp FINISH_CheckOverflow ; if it's not negative then there wouldn't be overflow , else continue checking 
ADD R3 R1 R0 ; R3= R1+R0
BRn FINISH_CheckOverflow ; if the answer is still negative then there's no overflow , goes to FINISH loop
ADD R2 R2 #1 ; else there's overflow , R2=1
BR FINISH_CheckOverflow ; goes to FINISH label

FINISH_CheckOverflow:
LD R0 R0_SAVE_CheckOverflow
LD R1 R1_SAVE_CheckOverflow    ;LOADING THE INITIALI VALUES OF THE REGISTERS 
LD R7 R7_SAVE_CheckOverflow
LD R3 R3_SAVE_CheckOverflow
RET
R0_SAVE_CheckOverflow .Fill #0
R1_SAVE_CheckOverflow .Fill #0
R7_SAVE_CheckOverflow .Fill #0
R3_SAVE_CheckOverflow .Fill #0


.END