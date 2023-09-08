; 212018535, 50%
; 324007202, 50%
.ORIG x4320

PrintNum:
ST R0 R0Save_PrintNum ;Storing the values of the registers at the start of the sabrotine
ST R1 R1Save_PrintNum	
ST R2 R2Save_PrintNum	
ST R3 R3Save_PrintNum	
ST R4 R4Save_PrintNum	
ST R5 R5Save_PrintNum	
ST R6 R6Save_PrintNum	
ST R7 R7Save_PrintNum	

AND R3 R3 #0 ;INITIALZING THE REGISTERS TO ZERO
AND R2 R2 #0
AND R1 R1 #0
AND R4 R4 #0
AND R6 R6 #0
AND R5 R5 #0

ADD R0 R0 #0 ; check if R0 is 0 or positive
BRzp PrintNumAssistant; if R0 is 0 or positive go to PrintNumAssistant 
ADD R4 R4 #1 ;if negative Flag ON
ST R4 NegativeFlagPrintNum
NOT R0 R0 ; turning R0 to positive
ADD R0 R0 #1 

PrintNumAssistant:
LEA R6 Array ; putting the address to R6
ADD R6 R6 #5 ; using R6 as a pointer to the last cell of the array
LD R1 TenPrintNum; putting 10 into R1
LD R5 NegativeFlagPrintNum
BRz PositiveNum_PrintNum ; if R0 is positive continue
LD R1 MinusTenPrintNum ; putting -10 into R1 if R0 is negative 
PositiveNum_PrintNum: 
LD R4 DivAddress_PrintMum; putting the div address into R4
LD R5 ZeroAsciiPrintNum ;putting the - Ascii value of 0 into R5
FillArrayLoop_PrintNum:
JSRR R4 ; go to the address that exists into R4 and put into R7 the PC of the next instruction
ADD R3 R3 R5; puttig into R3 R3(mod R0/10)+R5(-Ascii value of 0) (now we have the Ascii value of R3(mod R0/10))
STR R3 R6 #0 ; putting the value of R3 into the address R6(the cell that R6 is pointing to in the Array) 
ADD R6 R6 #-1 ; moving the pointer back in 1
ADD R0 R2 #0 ; putting the result of div R0/10 in R0
BRnp FillArrayLoop_PrintNum ;check if the result(R2) is positive continue the loop
LD R4 NegativeFlagPrintNum ;putting the value of NegativeFlaPrintNum in R4
BRz Print_PrintNum ; if the Flag is OFF go to Print
LD R4 MinusAsciiPrintNum ;put the value of Minus Ascii into R4
STR R4 R6 #0 ; putting the value of Minus Ascii into the current cell of the Array (the cell that R6 is pointing to)
Print_PrintNum: 
LEA R6 Array ; put the address of the beginning of the Array into R6
AND R4 R4 #0 ; INITIALZING THE REGISTER R4 TO ZERO
ADD R4 R4 #5 ; intializig R4 to 5(the counter of the loop)
PrintLoop_PrintNum:
LDR R0 R6 #0 ; puttin in R0 the element that R6 is pointing on 
BRn Skip_PrintNum ; if the value is negative skip
OUT ; else print the value that exists in R0,the Ascii value of it 
Skip_PrintNum:
ADD R6 R6 #1 ; moving the pointer forward in 1
ADD R4 R4 #-1 ; decreasing the counter of the loop in 1
BRzp PrintLoop_PrintNum; if the counter is 0 or positive(not negative) continue the loop


EndOfPrintNum:
AND R3 R3 #0 ; intializing R3 to 0
ST R3 NegativeFlagPrintNum ; turn the flag OFF 
ADD R3 R3 -1; putting into R3 the value of R3-1
LEA R6 Array; putting into R6 the address of the beginning of the Array
AND R4 R4 #0 ; INITIALZING THE REGISTER R4 TO ZERO
ADD R4 R4 #5 ; intializig R4 to 5(the counter of the loop)
EndLoop_PrintNum:; returning the cells of the Array to -1
STR R3 R6 #0
ADD R6 R6 #1
ADD R4 R4 #-1
BRzp EndLoop_PrintNum
LD R0 R0Save_PrintNum ; LOADING THE START VALUES OF THE REGISTERS BEFORE ENTERRING THE PrintNum SUBROUTINE
LD R1 R1Save_PrintNum	
LD R2 R2Save_PrintNum	
LD R3 R3Save_PrintNum	
LD R4 R4Save_PrintNum	
LD R5 R5Save_PrintNum	
LD R6 R6Save_PrintNum	
LD R7 R7Save_PrintNum
RET 


Array .blkw #6 #-1
R0Save_PrintNum .fill #0
R1Save_PrintNum .fill #0
R2Save_PrintNum .fill #0
R3Save_PrintNum .fill #0
R4Save_PrintNum .fill #0
R5Save_PrintNum .fill #0
R6Save_PrintNum .fill #0
R7Save_PrintNum .fill #0
NegativeFlagPrintNum .fill #0
TenPrintNum .fill #10
DivAddress_PrintMum .fill x4064
ZeroAsciiPrintNum .fill #48
MinusAsciiPrintNum .fill #45
MinusTenPrintNum .fill #-10
NUM1 .FILL #-999
.END