; 212018535, 50%
; 324007202, 50%
; Convention: Haifa
.Orig x3B54
PrintMatrix:
;;;;;;;;;PrintMatrix(N,MatrixAddress);;;;;;;;;;;;
    ; Increase stack size by number of registers to backup
	ADD R6 R6 #-6 
    ; Backup registers for local use
	STR R1 R6 #0
	STR R2 R6 #1
	STR R3 R6 #2
	STR R4 R6 #3
	STR R5 R6 #4
	STR R7 R6 #5

	LDR R3 R6 #6 ; R3=N
	LDR R4 R6 #7 ; R4=MatrixAddress

	AND R1 R1 #0
	ADD R5 R3 #0 ; R5=N



	ADD R1 R0 #0 ; R1=R0 flag

	LEA R0 Solution_String	
	PUTS
	LD R0 Enter_Ascii_PrintMatrix
	OUT
	
	ADD R2 R3 #0

;;;;loop to print the line;;;;
PrintMatrixLine:
	LDR R0 R4 #0                  ; R0=A[I][J]
	LD R5 Star_Ascii_PrintMatrix
	ADD R5 R5 R0                  ; if we want to print a star then R0 hase the ascii value
	BRz Continue
	LD R5 Zero_Ascii_PrintMatrix  ; else put the the ascii value of a[i][j] into R0
	ADD R0 R0 R5
	Continue:
	OUT 
	LD R0 Space_Ascii_PrintMatrix 
	OUT
	ADD R4 R4 #1                 ; move the pointer to the next cell
	ADD R3 R3 #-1                ; decrease the counter
	BRp PrintMatrixLine
;;;loop to start a new line;;;
PrintMatrixNewLine:
	LD R0 Enter_Ascii_PrintMatrix
	OUT
	LDR R3 R6 #6                ; counter=N    
	ADD R2 R2 #-1               ; decrease the inner loop counter
	BRp PrintMatrixLine          


	LEA R0 Another_Solution_String 
	PUTS

	GETC 
	OUT 
	
	ADD R2 R0 #0
	
	GETC
	OUT
	
	LD R5 Y_Ascii_PrintMatrix
	ADD R5 R2 R5    ; if user insert Y or y go to Yes
	BRz Yes
	LD R5 y_Ascii_PrintMatrix
	ADD R5 R2 R5
	BRz Yes
	AND R0 R0 #0    ; if the user insert N R0=-1 
	ADD R0 R0 #-1
	BR EndOfPrintMatrix

Yes:
	ADD R0 R1 #0   
	ADD R0 R0 #1  ; R0 = R0 +1

EndOfPrintMatrix:
; Restore backed up registers from the stack
LDR R1 R6 #0
LDR R2 R6 #1
LDR R3 R6 #2
LDR R4 R6 #3
LDR R5 R6 #4
LDR R7 R6 #5
; update R6
ADD R6 R6 #6

RET 

Space_Ascii_PrintMatrix .fill #32
Enter_Ascii_PrintMatrix .fill #10
Zero_Ascii_PrintMatrix .fill #48
Star_Ascii_PrintMatrix .fill #-42
Another_Solution_String .stringz "Would you like to see another solution? "
Y_Ascii_PrintMatrix .fill #-89
N_Ascii_PrintMatrix .fill #-78
y_Ascii_PrintMatrix .fill #-121
Solution_String .stringz "Yummy! The mouse has found the cheese!"
.END