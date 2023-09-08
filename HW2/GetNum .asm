; 212018535, 50%
; 324007202, 50%
.ORIG x41F4

GetNum:
ST R0,R0_SAVE_GETNUM ; Storing the values of the registers at the start of the sabrotine
ST R1,R1_SAVE_GETNUM
ST R3,R3_SAVE_GETNUM
ST R4,R4_SAVE_GETNUM
ST R5,R5_SAVE_GETNUM
ST R6,R6_SAVE_GETNUM
ST R7,R7_SAVE_GETNUM

Start_Again_GetNum:
AND R4 R4 #0 ; INITIALZING THE REGISTERS TO ZERO
AND R5 R5 #0 
AND R1,R1,#0
AND R6,R6,#0
ST R6,Overflow_Flag_GetNum ; USING R6 AS A FLAG FOR AN OVERFLOW NUMBER,IN THE BEGINING IT'S 0

LEA R0,Input_String_GetNum ; PUTTING INTO R0 THE ADDRESS OF THE BEGINING OF THE INPUT STRING TO PRINT IT IN THE NEXT ROW
PUTS ; PRINTING THE STRING THAT EXIST INTO R0
 
GETC ; Reading an input from the user and put the ascii value of the input in R0
OUT ; PRINTING THE VALUE THAT EXIST INTO R0 ,NOT THE NUMBER BUT WHAT DOES IT MEAN IN ASCII

LD R3,Enter_Ascii_GetNum ; PUTTING INTO R3 THE ASCII VALUE OF ENTER (NEW LINE), IN NEGATIVE TO HELP US TO CHECK LATER
ADD R3,R3,R0 ; PUTTING IN R3 R3+R0
BRnp Continue3_GetNum ; IF THE RESULT NEGATIVE OR POSITIVE THEN GO TO Continue3 (THE USER DIDNT PRESS ENTER YET)
; ELSE IF THE USER PRESSED ENTER IN THE BEGINING WE HAVE TO TELL HIM IT'S NOT A NUMBER AND ASK TO ENTER AGAIN
LEA R0,Not_Number_String_GetNum ; PUTTING INTO R0 THE ADDRESS OF THE BEGINING OF Not_Number_String
PUTS ; PRINTING THE STRING THAT EXIST INTO R0
BR Start_Again_GetNum ; GO TO Start_Again

Continue3_GetNum
LD R3,Minus_Ascii_GetNum ; PUTTING INTO R3 THE ASCII VALUE OF "-",IN NEGATIVE TO HELP US TO CHECK LATER
ADD R3,R3,R0 ; Putting in R3, R3+R0(to check if the input into R0 equal to '-' ascii value)
BRnp Check_If_Num_GetNum ; IF THE RESULT NEGATIVE OR POSITIVE THEN GO Check_If_Num (THE USER DIDNT ENTERED "-")
; ELSE IF THE USER ENTERED "-" THEN WE ARE INTO Minus_Num
Minus_Num_GetNum:
LD R6,Minus_Flag_GetNum ; Puting into R6 the value 1 , We gonna use it like a flag
GETC ;Reading an input from the user and put the ascii value of the input in R0
OUT ; PRINTING THE VALUE THAT EXIST INTO R0 ,NOT THE NUMBER BUT WHAT DOES IT MEAN IN ASCII
LD R3,Enter_Ascii_GetNum ;PUTTING INTO R3 THE ASCII VALUE OF ENTER (NEW LINE), IN NEGATIVE TO HELP US TO CHECK LATER
ADD R3,R3,R0 ; PUTTING IN R3 R3+R0
BRnp Check_If_Num_GetNum ; IF THE RESULT NEGATIVE OR POSITIVE THEN GO Check_If_Num (THE USER DIDNT PRESS ENTER YET)
; ELSE IF THE USER PRESSED ENTER AFTER ENTERRING "-" WE HAVE TO TELL HIM IT'S NOT A NUMBER AND ASK TO ENTER AGAIN
LEA R0,Not_Number_String_GetNum ; PUTTING INTO R0 THE ADDRESS OF THE BEGINING OF THE Not_Number_String TO PRINT IT IN THE NEXT ROW
PUTS ; PRINTING THE STRING THAT EXIST INTO R0
BR Start_Again_GetNum ; GO TO Start_Again

Check_If_Num_GetNum:
;THE NUMBERS IN ASCII VALUE STARTING FROM 48 TO 57, THEN EVRRY ANOTHER VALUE MEANS OR ENTER OR CHAR OR SIGN) 
LD R3,Enter_Ascii_GetNum ;PUTTING INTO R3 THE ASCII VALUE OF ENTER (NEW LINE), IN NEGATIVE TO HELP US TO CHECK LATER
ADD R3,R3,R0 ; PUTTING IN R3 R3+R0
BRnp Continue2_GetNum ;IF THE RESULT NEGATIVE OR POSITIVE THEN GO Continue2 (THE USER DIDNT PRESS ENTER YET)
; ELSE IF THE USER PRESSED ENTER ,THEN WE PUT THE FINAL RESULT THAT EXIST IN R4 INTO R0  
ADD R2,R4,#0
BR End_GetNum ; GO TO End_GetNum
Continue2_GetNum 
LD R3,Nine_Ascii_GetNum ; Putting into R3 the the ascii value of '9',in negative to help us to check later
;(9 is the maximum num that the user can insert in each digit)
ADD R3,R3,R0 ; PUTTING INTO R3 R3+R0
BRp Input_isnt_a_num_GetNum ; IF THE RESULT IS POSITIVE , THEN FOR SURE THE INPUT ISN'T A NUMBER, THEN GO TO Input_isnt_a_num
; ELSE THEN THE INPUT WOULD BE A NUMBER OR CHAR OR A SIGN
LD R3,Zero_Ascii_GetNum ; Putting into R3 the the ascii value of '0',in negative to help us to check later
ADD R3,R3,R0 ;(0 is the minimum num that the user can insert in each digit)
BRn Input_isnt_a_num_GetNum ; IF THE RESULT IS NEGATIVE THEN THE INPUT DEFINITELY ISN'T A NUMBER
LD R3,Overflow_Flag_GetNum ; PUTTING INTO R3 THE VALUE OF THE OVERFLOW FLAG
BRp Overflow_Num_GetNum ; IF IT'S POSITIVE THEN WE HAVE AN OVERFLOW NUMBER , GO TO Overflow_Num
; AND THERE IS NO NEED TO Continue TO CALCULATE THE FINAL RESULT  
Loop_GetNum:
LD R3,Zero_Ascii_GetNum ; PUTTING INTO R3 THE ASCII VALUE OF ZERO IN NEGATIVE TO CONVERT THE ASCII VALUE TO THE NUMBER VALUE
ADD R0,R0,R3 ; PUTTING INTO R0 R0+R3(CONVERTING TO THE ACTUAL NUMBER)
ADD R6,R6,#0 ; CHECKING IF THE MINUS FLAG IS POSITIVE(ON)
BRz Mul_10_GetNum ; IF IT'S ZERO (OFF) THE GO TO Mul_10 , AND START TO CALCULATE
NOT R0,R0 ; ELSE WE DO TWOS COMPLIMENT TO R0 (THE NUMBER WE HAVE)
ADD R0,R0,#1

Mul_10_GetNum:
ST R0,R0_SAVE_Mul_10_GetNum ; STORING THE VALUE OF R0
AND R5,R5,#0 ; INITIALZING R5 TO ZERO
LD R3,Ten_GetNum ; PUTTING INTO R3 10 ,WE GONNA USE IT AS A COUNTER (EVERY TIME WE GONNA MULTIPY THE RESULT BY 10)

Loop_Mul_10_GetNum:
ADD R1,R5,#0 ; PUTTING INTO R1 R5
ADD R0,R4,#0 ; PUTTING INTO R0 R4
LD R2,Overflow_Address_GetNum ; PUTTING INTO R2 THE ADDRESS OF THE CHECK OVERFLOW SUBROUTINE THAT WE DID IN THE LAST HOMEWORK
JSRR R2 ; GO TO THE ADDRESS THAT EXIST INTO R2, AND PUT INTO R7 THE PC OF THE NEXT INSTRUCTION
ST R2,Overflow_Flag_GetNum ; STORING THE RESULT INTO Overflow_Flag
ADD R2,R2,#0
BRp Overflow_Num_GetNum ; CHECKING IF THE RESULT IS POSITIVE THEN WE HAVE AN OVERFLOW NUMBER , SO GO TO Overflow_Num
ADD R5,R5,R4 ; PUTTING INTO R5 R5+R4
ADD R3,R3,#-1 ; DECREASE THE COUNTER 
BRp Loop_Mul_10_GetNum ; IF THE COUNTER IS POSITIVE THEN GO TO Loop_Mul_10 AND CONTINUE THE MULTIPING
ADD R4,R5,#0
LD R0,R0_SAVE_Mul_10_GetNum ; PUTTING INTO R0 THE PREVIOUS VALUE BEFORE ENTRING THE LOOP
LD R2,Overflow_Address_GetNum ; PUTTING INTO R2 THE ADDRESS OF THE CHECK OVERFLOW SUBROUTINE THAT WE DID IN THE LAST HOMEWORK
JSRR R2 ; GO TO THE ADDRESS THAT EXIST INTO R2, AND PUT INTO R7 THE PC OF THE NEXT INSTRUCTION
ST R2,Overflow_Flag_GetNum ; STORING THE RESULT INTO Overflow_Flag
ADD R2,R2,#0 
BRp Overflow_Num_GetNum ; CHECKING IF THE RESULT IS POSITIVE THEN WE HAVE AN OVERFLOW NUMBER , SO GO TO Overflow_Num
ADD R4,R4,R0 ; PUTTING INTO R4 R4+R0 (THE INPUT+ THE FINAL RESULT OF MULTIPING)
Continue_GetNum
GETC ; Reading an input from the user and put the ascii value of the input in R0
OUT ; PRINTING THE VALUE THAT EXIST INTO R0 ,NOT THE NUMBER BUT WHAT DOES IT MEAN IN ASCII
BR Check_If_Num_GetNum ; GO TO Check_If_Num

Overflow_Num_GetNum:
GETC ; Reading an input from the user and put the ascii value of the input in R0
OUT ; PRINTING THE VALUE THAT EXIST INTO R0 ,NOT THE NUMBER BUT WHAT DOES IT MEAN IN ASCII
LD R3,Enter_Ascii_GetNum ; PUTTING INTO R3 THE ASCII VALUE OF ENTER (NEW LINE), IN NEGATIVE TO HELP US TO CHECK LATER
ADD R3,R3,R0 ; PUTTING INTO R3 R3+R0
BRnp Check_If_Num_GetNum ; IF THE RESULT IS POSITIVE OR NEGATIVE THEN GO TO Check_If_Num
; ELSE THE USER PRESSED ENTER AND WE HAVE AN OVERFLOW NUMBER , SO WE GONNA TELL HIM THAT THE NUMBER IS OVERFLOWED 
; AND ASK HIM TO ENTER A NUMBER AGAIN
LEA R0,Overflow_String_GetNum ; PUTTING INTO R0 THE ADDRESS OF THE BEGINING OF THE Overflow_String TO PRINT IT IN THE NEXT ROW
PUTS ; PRINTING THE STRING THAT EXIST INTO R0
BR Start_Again_GetNum ; GO TO Start_Again

Input_isnt_a_num_GetNum:
GETC ; Reading an input from the user and put the ascii value of the input in R0
OUT ; PRINTING THE VALUE THAT EXIST INTO R0 ,NOT THE NUMBER BUT WHAT DOES IT MEAN IN ASCII
LD R3,Enter_Ascii_GetNum ; PUTTING INTO R3 THE ASCII VALUE OF ENTER (NEW LINE), IN NEGATIVE TO HELP US TO CHECK LATER
ADD R3,R3,R0 ; PUTTING INTO R3 R3+R0
BRnp Input_isnt_a_num_GetNum ; IF THE RESULT IS NEGATIVE OR POSITIVE THEN THE USER DIDNT PRESSED ENTER YET , SO 
; WE WILL CONTINUE GETTING INPUTS UNTIL HE PRESS ENTER
;ELSE IF HE PRESSED ENTER WE WILL TELL HIM THAT HE DIDNT ENTERED A NUMBER , AND ASK HIM TO ENTER A NUMBER AGAIN
LEA R0,Not_Number_String_GetNum ; PUTTING INTO R0 THE ADDRESS OF THE BEGINING OF THE Not_Number_String TO PRINT IT IN THE NEXT ROW
PUTS ; PRINTING THE STRING THAT EXIST INTO R0
BR Start_Again_GetNum ; GO TO Start_Again

End_GetNum: 
LD R0,R0_SAVE_GETNUM ; LOADING THE START VALUES OF THE REGISTERS BEFORE ENTERRING THE GetNum SUBROUTINE
LD R1,R1_SAVE_GETNUM
LD R3,R3_SAVE_GETNUM
LD R4,R4_SAVE_GETNUM
LD R5,R5_SAVE_GETNUM
LD R6,R6_SAVE_GETNUM
LD R7,R7_SAVE_GETNUM
RET 


Overflow_Address_GetNum .fill X4120
Input_String_GetNum .STRINGZ "Enter an integer number: "
Not_Number_String_GetNum .STRINGZ "Error! You did not enter a number. Please enter again: "
Overflow_String_GetNum .STRINGZ "Error! Number overflowed! Please enter again: "
Overflow_Flag_GetNum .fill #0
Enter_Ascii_GetNum .fill #-10
Ten_GetNum .fill #10
Nine_Ascii_GetNum .fill #-57
Zero_Ascii_GetNum .fill #-48
Minus_Flag_GetNum .fill #1
Minus_Ascii_GetNum .fill #-45
R0_SAVE_GETNUM .fill #0
R1_SAVE_GETNUM .fill #0
R3_SAVE_GETNUM .fill #0
R4_SAVE_GETNUM .fill #0
R5_SAVE_GETNUM .fill #0
R6_SAVE_GETNUM .fill #0
R7_SAVE_GETNUM .fill #0
R0_SAVE_Mul_10_GetNum .fill #0
.END