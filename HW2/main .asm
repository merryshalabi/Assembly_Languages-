; 212018535, 50%
; 324007202, 50%
.ORIG x3000 
LD R3 GetNumAddress_Main ; putting the address of the subroutine GetNumAddress into R3
JSRR R3; go to the address that exists in R3(the GetNum)
ST R2 Num1Save_Main;putting the value that exists R2 into label Num1Save
LD R3 GetNumAddress_Main ;putting the address of the subroutine GetNumAddress into R3
JSRR R3 ; go to the address that exists in R3(the GetNum)
ST R2 Num2Save_Main;putting the value that exists R2 into lable Num2Save
LD R3 CalculatorAddress_Main;; putting the address of the subroutine CalculatorAddress into R3
LD R0 Num1Save_Main ; putting in R0 the value that exists in Num1Save
LD R1 Num2Save_Main ; putting in R1 the value that exists in Num2Save
JSRR R3 ; go to the address that exists in R3(the Calculator)
Halt
GetNumAddress_Main .fill x41F4
CalculatorAddress_Main .fill x4384
Num1Save_Main .fill #0
Num2Save_Main .fill #0
.END