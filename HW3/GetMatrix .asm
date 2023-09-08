; 212018535, 50%
; 324007202, 50%
.ORIG X444C
GetMatrix:
ST R0 R0_Save_GetMatrix           ; STORING THE VALUES OF THE REGISTERS AT THE START OF THE SUBROUTINE
ST R1 R1_Save_GetMatrix
ST R2 R2_Save_GetMatrix
ST R3 R3_Save_GetMatrix
ST R4 R4_Save_GetMatrix
ST R5 R5_Save_GetMatrix
ST R6 R6_Save_GetMatrix
ST R7 R7_Save_GetMatrix


LD R0 Enter_Ascii_GetNum            ; PUT INTO R0 THA ASCII VALUE OF ENTER  
OUT 
AND R6 R6 #0                        ; INITIALZING THE REGISTER R6 TO ZERO
Loop_ColumsMulRows_GetMatrix:       ; LOOP TO MULTIPLY COLUMS AND ROWS
ADD R6 R6 R4                        ; PUTTING INTO R6 R6+R4
ADD R5 R5 #-1                       ; DECREASE THE COUNTER 
BRp Loop_ColumsMulRows_GetMatrix    ; IF THE COUNTER IS POSITIVE THEN GO TO Loop_ColumsMulRows_GetMatrix AND CONTINUE THE MULTIPING
ADD R4 R6 #0                        ; PUTTING THE FINAL RESULT INTO R4 

GetMatrixAssistant:
LD R6 GetNum_Address_GetMatrix      ; PUTTING INTO R6 THE ADDRESS OF THE GETNUM SUBROUTINE 
JSRR R6                             ; GO TO THE ADDRESS THAT EXIST INTO R6, AND PUT INTO R7 THE PC OF THE NEXT INSTRUCTION
STR R2 R3 #0                        ; STORING THE RESULT INTO THE ADDRESS IN R3 (THE MATRIX ADDRESS)
ADD R3 R3 #1                        ; PUT INTO R3 THE ADDRESS OF THE NEXT CELL IN THE MATRIX
ADD R4 R4 #-1                       ; DECREASE THE COUNTER 
BRp GetMatrixAssistant              ; IF THE COUNTER IS POSITIVE THEN GO TO GetMatrixAssistant AND CONTINUE FILL THE MATRIX


End_GetMatrix:
LD R0 R0_Save_GetMatrix           
LD R1 R1_Save_GetMatrix
LD R2 R2_Save_GetMatrix
LD R3 R3_Save_GetMatrix
LD R4 R4_Save_GetMatrix
LD R5 R5_Save_GetMatrix
LD R6 R6_Save_GetMatrix
LD R7 R7_Save_GetMatrix

			

RET
	
R0_Save_GetMatrix  .fill #0        
R1_Save_GetMatrix  .fill #0
R2_Save_GetMatrix  .fill #0
R3_Save_GetMatrix  .fill #0
R4_Save_GetMatrix  .fill #0
R5_Save_GetMatrix  .fill #0
R6_Save_GetMatrix  .fill #0
R7_Save_GetMatrix  .fill #0
GetNum_Address_GetMatrix .fill x41F4
InputStringGetMatrix .stringz "Enter the matrix values: "
Enter_Ascii_GetNum .fill #10
Space_Ascii_GetMatrix .fill #-32
InsertToTreeAddress .FILL X4834
.END