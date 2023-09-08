; 212018535, 50%
; 324007202, 50%
.orig x41F4
GetNum:
ST R0 R0_Save_GetNum          ; STORING THE VALUES OF THE REGISTERS AT THE START OF THE SUBROUTINE
ST R1 R1_Save_GetNum
ST R3 R3_Save_GetNum
ST R4 R4_Save_GetNum
ST R5 R5_Save_GetNum
ST R6 R6_Save_GetNum
ST R7 R7_Save_GetNum


AND R4 R4 #0                   ; INITIALZING THE REGISTERS TO ZERO
AND R5 R5 #0 
AND R1,R1,#0
AND R6,R6,#0


GetNumAssistant:
GETC                           ; Reading an input from the user and put the ascii value of the input in R0
OUT                            ; PRINTING THE VALUE THAT EXIST INTO R0 ,NOT THE NUMBER BUT WHAT DOES IT MEAN IN ASCII
LD R6 Space_Ascii_GetNum       ; PUTTING INTO R6 THE ASCII VALUE OF SPACE
ADD R6 R6 R0                   ; CHECK IF THE VALUE IN R0 IS THE ASCII VALUE OF SPACE
BRz GetNumAssistant            ; IF THE VALUE IN R0 IS THE ASCII VALUE OF SPACE GO TO GetNumAssistant


LD R4 Minus_Ascii_GetNum       ; PUTTING INTO R4 THE ASCII VALUE OF MINUS
ADD R4 R4 R0                   ; PUT INTO R4 THE VALUE OF ( R4 + R0)
BRnp Positive_GetNum           ; IF IT'S POSITIVE OR NEGATIVE THEN WE HAVE IN R0 AN POSITIVE VALUE 
AND R4 R4 #0                   ; INITIALZING THE REGISTER R4 TO ZERO
ADD R4 R4 #1                   ; PUT INTO R4 THE VALUE OF ( R4 + 1)
ST R4 minusFlagGetNum          ; TURN ON THE MINUS FLAG 
AND R4 R4 #0                   ; PUT INTO R4 THE VALUE OF ( R4 + R0)
BR GetNumAssistant             ; GO TO GetNumAssistant


Positive_GetNum:
AND R4 R4 #0                   ;INITIALZING THE REGISTER R4 TO ZERO
Loop_GetNum:
LD R3 Zero_Ascii_GetNum        ; PUTTING INTO R3 THE ASCII VALUE OF ZERO IN NEGATIVE TO CONVERT THE ASCII VALUE TO THE NUMBER VALUE
ADD R0 R0 R3                   ; PUTTING INTO R0 R0+R3(CONVERTING TO THE ACTUAL NUMBER)
LD R6 minusFlagGetNum          ; CHECKING IF THE MINUS FLAG IS POSITIVE(ON)
BRz Mul_10_GetNum              ; IF IT'S ZERO (OFF) THE GO TO Mul_10 , AND START TO CALCULATE
NOT R0,R0                      ; ELSE WE DO TWOS COMPLIMENT TO R0 (THE NUMBER WE HAVE)
ADD R0,R0,#1

Mul_10_GetNum:
AND R5 R5 #0                  ;INITIALZING THE REGISTER R5 TO ZERO
LD R3 Ten_GetNum              ; PUTTING INTO R3 10 TO USE IT AS ACOUNTER

Loop_Mul_10_GetNum:
ADD R5 R5 R4                  ; PUT INTO R5 THE VALUE OF (R5 + R4)
ADD R3 R3 #-1                 ; DECREASE THE COUNTER 
BRp Loop_Mul_10_GetNum        ;IF THE COUNTER IS POSITIVE THEN GO TO Loop_Mul_10_GetNum

ADD R4 R5 #0                  ; PUT THE FINAL RESULT INTO R4 
ADD R4 R4 R0                  ; PUT INTO R4 VALUE OF (R4 + R0)
GETC                          ; Reading an input from the user and put the ascii value of the input in R0
OUT                           ; PRINTING THE VALUE THAT EXIST INTO R0 ,NOT THE NUMBER BUT WHAT DOES IT MEAN IN ASCII
LD R3 Space_Ascii_GetNum      ; PUTTING INTO R3 THE ASCII VALUE OF SPACE
ADD R3 R3 R0                  ; CHECK IF THE VALUE IN R0 IS THE ASCII VALUE OF SPACE
BRz EndGetNum                 ; IF THE VALUE IN R0 IS THE ASCII VALUE OF SPACE GO TO EndGetNum
LD R3 Enter_Ascii_GetNum      ; PUTTING INTO R3 THE ASCII VALUE OF ENTER
ADD R3 R3 R0                  ; CHECK IF THE VALUE IN R0 IS THE ASCII VALUE OF ENTER
BRz EndGetNum                 ; IF THE VALUE IN R0 IS THE ASCII VALUE OF ENTER GO TO EndGetNum
BR Loop_GetNum                ; GO TO Loop_GetNum

EndGetNum:
AND R3 R3 #0
ST R3 minusFlagGetNum         ; TURNING OF THE MINUS FLAG  
ADD R2 R4 #0                  ; PUTTING THE FINAL NUMBER INTO R2        
LD R0 R0_Save_GetNum           
LD R1 R1_Save_GetNum       ; LOADING THE START VALUES OF THE REGISTERS BEFORE ENTERRING THE GetNum SUBROUTINE
LD R3 R3_Save_GetNum
LD R4 R4_Save_GetNum
LD R5 R5_Save_GetNum
LD R6 R6_Save_GetNum
LD R7 R7_Save_GetNum
RET

R0_Save_GetNum  .fill #0        
R1_Save_GetNum  .fill #0
R3_Save_GetNum  .fill #0
R4_Save_GetNum  .fill #0
R5_Save_GetNum  .fill #0
R6_Save_GetNum  .fill #0
R7_Save_GetNum  .fill #0
Space_Ascii_GetNum .fill #-32
minusFlagGetNum .fill #0
Zero_Ascii_GetNum .fill #-48
Minus_Ascii_GetNum .fill #-45
Ten_GetNum .fill #10 
Enter_Ascii_GetNum .fill #-10
.end