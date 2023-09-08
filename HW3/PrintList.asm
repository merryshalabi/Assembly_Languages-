; 212018535, 50%
; 324007202, 50%
.ORIG X4C1C
PrintList:
ST R0 R0_Save_PritList
ST R1 R1_Save_PritList
ST R2 R2_Save_PritList
ST R3 R3_Save_PritList
ST R4 R4_Save_PritList 
ST R5 R5_Save_PritList
ST R6 R6_Save_PritList
ST R7 R7_Save_PritList


Find_Head:
LDR R2 R0 #2                                ; R2<-MEM[R0+2](R2=THE PREV OF R1)
BRz StartPrintList                          ; IF R2=0 (R0 IS THE HEAD OF THE LIST) GO TO StartPrintList  
LDR R0 R0 #2                                ; R0<-MEM[R0+2]
BR Find_Head     

StartPrintList:
ADD R2 R0 #0                                ; R2=R0 (R2= THE ADDRESS OF THE HEAD OF THE LIST)
LD R0 EnterAscii_PrintList                  ; R0=THE ASCII VALUE OF ENTER
OUT

PrintList_Loop:
LDR R3 R2 #0                                ; R3<- MEM[R0+0] (R3=THE VALUE OF THE NODE THAT R0 POINTING TO) 
LDR R4 R2 #1                                ; R4<- MEM[R0+1] (R4=THE COUNTER OF THE NODE THAT R0 POINTING TO)
ADD R0 R3 #0                                ; R0=R3 (THE VALUE OF THE NODE THAT R0 POINTING TO)
LD R6 PrintNum_Address_PrintList            ; R6= THE ADDRESS OF THE SUBROUTINE PrintNum
JSRR R6                                     ; GO TO THE ADDRESS THAT EXIST INTO R6, AND PUT INTO R7 THE PC OF THE NEXT INSTRUCTION
LD R0 SpaceAscii_PrintList         
OUT
ADD R0 R4 #0                                ; R0=R4 (THE COUNTER OF THE NODE THAT R0 POINTING TO) 
JSRR R6                                     ; GO TO THE ADDRESS THAT EXIST INTO R6 
LD R0 EnterAscii_PrintList
OUT
LDR R2 R2 #3                                ; R2<-MEM[R2+3] (MOVE THE POINTER TO THE NEXT NODE)
LDR R5 R2 #1                                ; R5<-MEM[R2+1] (R5=THE COUNTER OF THE NEXT NODE)  
BRp PrintList_Loop                          ; IF R5 IS POSITIVE GO TO PrintList_Loop (R2 IS NOT THE LAST NODE)



End_Of_PrintLoop:
LD R0 R0_Save_PritList
LD R1 R1_Save_PritList
LD R2 R2_Save_PritList 
LD R3 R3_Save_PritList
LD R4 R4_Save_PritList 
LD R5 R5_Save_PritList
LD R6 R6_Save_PritList
LD R7 R7_Save_PritList
	

RET
R0_Save_PritList .fill #0	
R1_Save_PritList .fill #0
R2_Save_PritList .fill #0
R3_Save_PritList .fill #0
R4_Save_PritList .fill #0
R5_Save_PritList .fill #0
R6_Save_PritList .fill #0
R7_Save_PritList .fill #0
PrintNum_Address_PrintList .fill x4320
SpaceAscii_PrintList .fill #32
EnterAscii_PrintList .fill #10	
.END