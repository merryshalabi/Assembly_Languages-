; 212018535, 50%
; 324007202, 50%
.ORIG X4834
InsertToTree:
ST R0 R0_Save_InsertToTree            ; STORING THE VALUES OF THE REGISTERS AT THE START OF THE SUBROUTINE
ST R1 R1_Save_InsertToTree
ST R2 R2_Save_InsertToTree
ST R3 R3_Save_InsertToTree
ST R4 R4_Save_InsertToTree
ST R5 R5_Save_InsertToTree
ST R6 R6_Save_InsertToTree
ST R7 R7_Save_InsertToTree


AND R6 R6 #0                           ; INITIALZING THE REGISTER R6 TO ZERO

Loop_columsMulRows_InsertToTree:       ; LOOP TO MULTIPLY COLUMS AND ROWS
ADD R6 R6 R4                           ; PUTTING INTO R6 R6+R4
ADD R5 R5 #-1                          ; DECREASE THE COUNTER 
BRp Loop_columsMulRows_InsertToTree    ; IF THE COUNTER IS POSITIVE THEN GO TO Loop_ColumsMulRow_InsertToTree AND CONTINUE THE MULTIPING)
ADD R4 R6 #0                           ; PUTTING THE FINAL RESULT INTO R4

LD R6 ListAddress                      ; PUT INTO R6 THE ADDRESS OF THE HEAD OF THE LIST
ST R6 NewHead                          ; STORING THE ADDRESS OF THE HEAD OF THE LIST INTO THE LABEL NewHead


Matrix_Loop_InsertToTree:              
LDR R0 R3 #0                            ; USE R0 AS A POINTER TO THE CURRENT CELL IN MATRIX
LD R6 MaxPowerOf2_Address_InsertToTree  ; PUT INTO R6 THE ADDRESS OF THE SUBROUTINE MaxPowerOf2
JSRR R6                                 ; GO TO THE ADDRESS THAT EXIST INTO R6, AND PUT INTO R7 THE PC OF THE NEXT INSTRUCTION
JSR InsertValue                         ; GO TO THE SUBROUTINE InsertValue AND PUT INTO R7 THE PC OF THE NEXT INSTRUCTION
LD R0 NewHead                           ; PUT INTO R0 THE VALUE OF THE LABEL NewHead
LD R6 InsertValueToList_Address         ; PUT INTO R6 THE ADDRESS OF THE SUBROUTINE InsertValueToList 
JSRR R6                                 ; GO TO THE ADDRESS THAT EXIST INTO R6, AND PUT INTO R7 THE PC OF THE NEXT INSTRUCTION
ST R0 NewHead                           ; STORING THE VALUE IN R0 (THE ADDRESS OF THE HEAD OF THE LIST AFTER THE SORT) INTO THE LABEL NewHead 
ADD R3 R3 #1                            ; MOVE THE POINTER TO THE NEXT CELL
ADD R4 R4 #-1                           ; DECREASE THE COUNTER
BRp Matrix_Loop_InsertToTree            ; IF THE COUNTER IS POSITIVE THEN GO TO Matrix_Loop_InsertToTree



End_Of_InsertToTree:
AND R6 R6 #0              
ST R6 NewHead                          ; PUTTING 0 INTO THE LABEL NewHead
LD R0 R0_Save_InsertToTree             ; LOADING THE START VALUES OF THE REGISTERS BEFORE ENTERRING THE InsertToTree SUBROUTINE
LD R1 R1_Save_InsertToTree
LD R2 R2_Save_InsertToTree
LD R3 R3_Save_InsertToTree
LD R4 R4_Save_InsertToTree
LD R5 R5_Save_InsertToTree
LD R6 R6_Save_InsertToTree
LD R7 R7_Save_InsertToTree
			
RET
	
R0_Save_InsertToTree .fill #0
R1_Save_InsertToTree .fill #0
R2_Save_InsertToTree .fill #0
R3_Save_InsertToTree .fill #0
R4_Save_InsertToTree .fill #0
R5_Save_InsertToTree .fill #0
R6_Save_InsertToTree .fill #0
R7_Save_InsertToTree .fill #0
MaxPowerOf2_Address_InsertToTree .fill x412C
InsertValueToList_Address .fill X4A28
ListAddress .fill X5024
NewHead .fill #0

InsertValue:
ST R0 R0_Save_InsertValue              ; STORING THE VALUES OF THE REGISTERS AT THE START OF THE SUBROUTINE
ST R1 R1_Save_InsertValue
ST R2 R2_Save_InsertValue
ST R3 R3_Save_InsertValue
ST R4 R4_Save_InsertValue
ST R5 R5_Save_InsertValue
ST R6 R6_Save_InsertValue
ST R7 R7_Save_InsertValue


InsertValueAssistant:
LDR R3 R2 #0                          ; PUTTING INTO R3 THE VALUE OF THE NODE THAT R2 POINTTING TO IN THE TREE 
LDR R4 R2 #1                          ; PUTTING INTO R4 THE COUNTER OF THE NODE THAT T2 POINTTING TO IN THE TREE
BRnp Contunue_InsertValue             ; IF THE COUNTER IS NOT ZERO ( THE TREE NOT EMPTY) GO TO Contunue_InsertValue   
STR R1 R2 #0                          ; IF THE COUNTER 0 (THE TREE IS EMPTY) PUT THE VALUE OF R1 INTO THE NODE THAT R2 POINTTING TO  
ADD R6 R4 #1                          ; ADD 1 TO THE COUNTER 
STR R6 R2 #1                 
BR End_Of_InsertValue                 ; GO TO End_Of_InsertValue

Contunue_InsertValue:          
BR Check_Overflow_InsertValue         ; GO TO Check_Overflow_InsertValue 
NotOverflow_InsertValue:
NOT R3 R3                             ; DO TWOS COMPLIMENT TO R3
ADD R3 R3 #1
BR Check2IfOverflow_InsertValue        ; GO TO CheckIfOverflow_InsertValue
NotOverflow_InsertValue2:
ADD R6 R1 R3                          ; PUT INTO R6 THE VALUE OF (R1+R3) 
BRz TheSameNumber_InsertValue         ; IF THE VALUE OF R6 IS 0 GO TO TheSameNumber_InsertValue  
BRp Go_Right                          ; IF THE VALUE OF R6 IS POSITIVE GO TO Go_Right (GO TO THE RIGHT SON OF R2)
Go_Left:                               
LDR R2 R2 #2                          ; MOVE THE POINTER(THE ADDRESS IN R2) TO THE LEFT CHILD OF R2 
BRz End_Of_InsertValue                ; IF THE LEFT CHILD IS NULL GO TO End_Of_InsertValue 
BR InsertValueAssistant             

Go_Right:
LDR R2 R2 #3                          ; R2<- MEM[R2+3] (RIGHT CHILD)
BRz End_Of_InsertValue                ; IF THE RIGHT CHILD S NULL GO TO End_Of_InsertValue
BR InsertValueAssistant 

TheSameNumber_InsertValue:
ADD R4 R4 #1                          ; R4 = R4 + 1
STR R4 R2 #1                          ; MEM[R2+1] <- R4 (ADD 1 TO THE COUNTER)
BR End_Of_InsertValue

Check_Overflow_InsertValue:           ; CHECK IF R3=(-2^15)     
LD R5 twoExp14                        ; R5 = -(2^14)
ADD R5 R3 R5                          ; R5 = R3 + (-2^14)
BRz NotOverflow_InsertValue           ; IF R5 IS 0 (R3 IS 2^14) GO TO NotOverflow_InsertValu 
LD R5 TwoExp14                        ; R5 = (2^14)
ADD R5 R3 R5                          ; R5 = R3 + ( 2^14)
BRzp NotOverflow_InsertValue          ; IF R5 IS POSITIVE OR ZERRO( R3 IS NOT (-2^15) R3 IS -(2^14) OR LARGER) GO TO NotOverflow_InsertValue(ELSE R3 IS -2^15)
LD R5 twoExp14                        ; R5 = -(2^14) 
ADD R5 R5 R1                          ; R5 = R1 + - 2^14 
BRz Go_Right                          ; IF R5 IS ZERO ( R1 IS -(2^14) AND R3 IS (-2^15) ) GO TO Go_Right 
LD R5 TwoExp14                        ; R5= 2^14
ADD R5 R5 R1                          ; R5 = R1 + 2^14 
BRn TheSameNumber_InsertValue         ; IF R5 IS NEGATIVE( THEN R1 IS SMALER THAN -2^14 THEN R1=R2=-2^15) GO TO TheSameNumber_InsertValue
BR Go_Right                           ; GO TO Go_Right ( IF R3 IS (-2^15) AND R1 IS NOT ( -2^14))


Check2IfOverflow_InsertValue         ; CHECK IF (R1 + R3) IS OVERFLOW (R3 AFTER THE TWOS COMPLIMENT) 
ADD R3 R3 #0                          
BRp Number1IsPostitive_InsertValue    ; IF R3 IS POSITIVE GO TO Number1IsPostitive_InsertValue  
BRz NotOverflow_InsertValue2          ; IF R3 IS 0 THER IS NO OVERFLOW
ADD R1 R1 #0                
BRn Go_Left                           ; IF R1 IS NEGATIVE (R3 ALSO NEGATIVE) GO TO Go_Left
BR NotOverflow_InsertValue2         
Number1IsPostitive_InsertValue:
ADD R1 R1 #0
BRp Go_Right                          ; IF R1 IS POSITIVE (R3 ALSO POSIIVE) GO TO Go_Right               
BR NotOverflow_InsertValue2

End_Of_InsertValue:
LD R0 R0_Save_InsertValue             ; LOADING THE START VALUES OF THE REGISTERS BEFORE ENTERRING THE InsertToTree SUBROUTINE
LD R1 R1_Save_InsertValue
LD R2 R2_Save_InsertValue
LD R3 R3_Save_InsertValue
LD R4 R4_Save_InsertValue
LD R5 R5_Save_InsertValue
LD R6 R6_Save_InsertValue
LD R7 R7_Save_InsertValue



RET
R0_Save_InsertValue .fill #0
R1_Save_InsertValue .fill #0
R2_Save_InsertValue .fill #0
R3_Save_InsertValue .fill #0
R4_Save_InsertValue .fill #0
R5_Save_InsertValue .fill #0
R6_Save_InsertValue .fill #0
R7_Save_InsertValue .fill #0
twoExp14 .fill #-16384
TwoExp14 .fill #16384

.END