; 212018535, 50%
; 324007202, 50%
.ORIG X4A28
InsertValueToList:
ST R0 R0_SaveInsertValueToList              ; STORING THE VALUES OF THE REGISTERS AT THE START OF THE SUBROUTINE
ST R1 R1_SaveInsertValueToList
ST R2 R2_SaveInsertValueToList
ST R3 R3_SaveInsertValueToList
ST R4 R4_SaveInsertValueToList
ST R5 R5_SaveInsertValueToList
ST R6 R6_SaveInsertValueToList
ST R7 R7_SaveInsertValueToList

InsertValueToListAssistant:  
LDR R3 R0 #0                                 ; R3<- MEM[R0+0] (R3=THE VALUE OF THE NODE THAT R0 POINTING TO) 
LDR R4 R0 #1                                 ; R4<- MEM[R0+1] (R4=THE COUNTER OF THE NODE THAT R0 POINTING TO)
LDR R2 R0 #3                                 ; R2<- MEM[R0+3] (R2=THE ADDRESS OF THE NEXT NODE THAT R0 POINTING TO) 
ADD R4 R4 #0 
BRz TheFirstNode                             ; IF THE R4=0 (THE LIST IS EMPTY) GO TO TheFirstNode 
BR Check_Overflow_InsertValueToList   

Not_Overflow_InsertValueToList: 
LDR R4 R0 #1                                 ; R4<- MEM[R0+1] 
NOT R3 R3                                    ; DO TWOS COMPLIMENT TO R3
ADD R3 R3 #1
BR Check2IfOverflow_InsertValueToList

NotOverFlow2_InsertValueToList:
LDR R4 R0 #1                                 ; R4<- MEM[R0+1]  
ADD R3 R3 R1
BRnp ContinueInsertValueToList               ; IF R3 IS NOT 0 (R3!=R1) GO TO ContinueInsertValueToList

TheSameNumberInsertValueToList:
LDR R4 R0 #1
ADD R6 R4 #1                                 ; IF R3=R1 ADD 1 TO THE COUNTER 
STR R6 R0 #1                                 ; MEM[R0+1]<-R6
BR EndOfInsertValueToList                    ; GO TO EndOfInsertValueToList

ContinueInsertValueToList:
LDR R4 R0 #1                                 ; R4<- MEM[R0+1] 
LDR R5 R2 #1                                 ; R5<- MEM[R2+1] ( R5=THE COUNTER OF THE NEXT NODE)
BRnp GoNext                                  ; IF R5!=0 GO TO GoNext
LDR R5 R0 #3                                 ; R5<- MEM[R0+3] (R0 POINTING TO THE LAST NODE, PUT INTO R5 THE ADDRESS OF THE NEXT OF R0)  
STR R1 R5 #0                                 ; MEM[R5+0]<-R1 (PUT R1 INTO THE FIRST EMPTY NODE)
AND R2 R2 #0
ADD R2 R2 #1                    
STR R2 R5 #1                                 ; MEM[R5+1]<-R2 (PUT 1 INTO THE COUNTER OF THE LAST NODE)
LD R0 R0_SaveInsertValueToList               ; PUT THE ADDRESS OF THE HEAD OF THE LIST INTO R0 
BR SortList 
GoNext:
LDR R0 R0 #3                                 ; R0<-MEM[R0+3] ( MOVE THE POINTER TO THE NEXT NODE)
BR InsertValueToListAssistant

Check_Overflow_InsertValueToList:            ; CHECK IF R3=(-2^15)
LD R4 twoExp14InsertValueToList              ; R4 = -(2^14)
ADD R4 R3 R4                                 ; R4 = R3 + (-2^14)
BRz Not_Overflow_InsertValueToList           ; IF R4 IS 0 (R3 IS 2^14) GO TO Not_Overflow_InsertValueToList
LD R4 TwoExp14InsertValueToList              ; R4 = (2^14)
ADD R4 R4 R3                                 ; R4 = R3 + ( 2^14)
BRzp Not_Overflow_InsertValueToList          ; IF R4 IS POSITIVE OR ZERRO( R3 IS NOT (-2^15) R3 IS -(2^14) OR LARGER) GO TO Not_Overflow_InsertValueToList(ELSE R3 IS -2^15)
LD R4 twoExp14InsertValueToList              ; R4 = -(2^14)
ADD R4 R4 R1                                 ; R4 = R1 + - 2^14
BRz ContinueInsertValueToList                ; IF R4 IS ZERO ( R1 IS -(2^14) AND R3 IS (-2^15) ) GO TO ContinueInsertValueToListt
LD R4 TwoExp14InsertValueToList              ; R4= 2^14
ADD R4 R4 R1                                 ; R4 = R1 + 2^14
BRn TheSameNumberInsertValueToList           ; IF R4 IS NEGATIVE( THEN R1 IS SMALER THAN -2^14 THEN R1=R2=-2^15) GO TO TheSameNumberInsertValueToList
BR ContinueInsertValueToList                 ; GO TO ContinueInsertValueToList ( IF R3 IS (-2^15) AND R1 IS NOT ( -2^14))



Check2IfOverflow_InsertValueToList:           ; CHECK IF (R1 + R3) IS OVERFLOW (R3 AFTER THE TWOS COMPLIMENT)
ADD R3 R3 #0                             
BRp Number1IsPostitive_InsertValueToList      ; IF R3 IS POSITIVE GO TO Number1IsPostitive_InsertValueToList 
BRz NotOverFlow2_InsertValueToList            ; IF R3 IS 0 THER IS NO OVERFLOW
ADD R1 R1 #0
BRn ContinueInsertValueToList                 ; IF R1 IS NEGATIVE (R3 ALSO NEGATIVE) GO TO ContinueInsertValueToList
BR NotOverFlow2_InsertValueToList
Number1IsPostitive_InsertValueToList:
ADD R1 R1 #0
BRp ContinueInsertValueToList                 ; IF R1 IS POSITIVE (R3 ALSO POSIIVE) GO TO ContinueInsertValueToList
BR NotOverFlow2_InsertValueToList



TheFirstNode:                                 ; THE LIST IS EMPTY 
STR R1 R0 #0                                  ; MEM[R0+0]<-R1 
AND R2 R2 #0
ADD R2 R2 #1
STR R2 R0 #1                                  ; MEM[R0+1]<- 1 (PUT 1 INTO THE COUNTER OF THE NOOD)
ST R0 R0_SaveInsertValueToList         
BR EndOfInsertValueToList


SortList:
LDR R3 R0 #0                                ; R3<- MEM[R0+0] (R3=THE VALUE OF THE NODE THAT R0 POINTING TO)
LDR R4 R0 #1                                ; R4<- MEM[R0+1] (R4=THE COUNTER OF THE NODE THAT R0 POINTING TO)
LDR R2 R0 #3                                ; R2<- MEM[R0+3] (R2=THE ADDRESS OF THE NEXT NODE THAT R0 POINTING TO)
BR Check_Overflow_SortList

Not_Overflow_SortList:
LDR R4 R0 #1
NOT R3 R3                                   ; DO TWOS COMPLIMENT TO R3
ADD R3 R3 #1
BR Check2IfOverflow_SortList  

NotOverFlow2_SortList:
LDR R4 R0 #1
ADD R3 R3 R1                                ; R3=(R3+R1)
BRn Done_InsertValueToList                  ; IF R3<0 (R3>R1) GO TO Done_InsertValueToList(THE RIGHT PLACE OF R1)
Positive_SortList:                          ;(R1>R3)
LDR R4 R0 #1
LDR R2 R2 #1                                ; R2<-MEM[R2+1] (R2=THE COUNTER OF THE NEXT )
BRz EndOfInsertValueToList                  ; IF R2=0 GO TO EndOfInsertValueToList(R0 GOT TO THE LAST OF THE LIST) 
LDR R0 R0 #3                                ; R0<-MEM[R0+3] (MOVE THE POINTER TO THE NEXT NODE)
BR SortList

Done_InsertValueToList:   
LDR R4 R0 #1 
LDR R2 R5 #2                                ; R2<-MEM[R5+2] (R2=PREV OF THE NODE THAT R5 POINTING TO (THE LAST NODE IN THE LIST)
LDR R3 R5 #3                                ; R3<-MEM[R5+3] ( R3=THE NEXT OF R5)
STR R3 R2 #3                                ; MEM[R2+3]<- R3 ( THE NEXT OF R2 IS THE ADDRESS IN R3 ) 
STR R2 R3 #2                                ; MEM[R3+2]<- R2 ( THE PREV OF R3 IS THE ADDRESS IN R2 ) 
LDR R6 R0 #2                                ; R3<-MEM[R5+3] (R6=THE PREV OF R0)
STR R6 R5 #2                                ; MEM[R5+2]<- R6 (PREV R5= R6)
STR R0 R5 #3                                ; MEM[R5+3]<- R0(NEXT R5=R0)
STR R5 R6 #3                                ; MEM[R6+3]<- R5(NEXT R6 = R5)
STR R5 R0 #2                                ; MEM[R0+2]<- R5 (PREV R0 = R5) 
LDR R6 R5 #2
BRp SameHead
ST R5 R0_SaveInsertValueToList              ; IF R5 IS THE NEW HEAD STOR R5 INTO R0_SaveInsertValueToList
SameHead:
BR EndOfInsertValueToList

Check2IfOverflow_SortList:                 ; CHECK IF (R1 + R3) IS OVERFLOW (R3 AFTER THE TWOS COMPLIMENT)
ADD R3 R3 #0                 
BRp Number1IsPostitive_InsertValueToList2  ; IF R3 IS POSITIVE GO TO Number1IsPostitive_InsertValueToList2
BRz NotOverFlow2_SortList                  ; IF R3 IS 0 THER IS NO OVERFLOW
ADD R1 R1 #0
BRn Done_InsertValueToList                 ; IF R1 IS NEGATIVE (R3 ALSO NEGATIVE) GO TO Done_InsertValueToList
BR NotOverFlow2_SortList                   
Number1IsPostitive_InsertValueToList2:
ADD R1 R1 #0
BRp Positive_SortList                      ; IF R1 IS POSITIVE (R3 ALSO POSIIVE) GO TO Positive_SortList
BR NotOverFlow2_SortList              

Check_Overflow_SortList:                   ; CHECK IF R3=(-2^15) 
LD R4 twoExp14InsertValueToList            ; R4 = -(2^14)
ADD R4 R3 R4                               ; R4 = R3 + (-2^14)
BRz Not_Overflow_SortList                  ; IF R4 IS 0 (R3 IS 2^14) GO TO Not_Overflow_SortList
LD R4 TwoExp14InsertValueToList            ; R4 = (2^14)
ADD R4 R4 R3                               ; R4 = R3 + ( 2^14)
BRzp Not_Overflow_SortList                 ; IF R4 IS POSITIVE OR ZERRO( R3 IS NOT (-2^15) R3 IS -(2^14) OR LARGER) GO TO Not_Overflow_SortList(ELSE R3 IS -2^15)
BR Positive_SortList


EndOfInsertValueToList:
LD R0 R0_SaveInsertValueToList
LD R1 R1_SaveInsertValueToList
LD R2 R2_SaveInsertValueToList
LD R3 R3_SaveInsertValueToList
LD R4 R4_SaveInsertValueToList
LD R5 R5_SaveInsertValueToList
LD R6 R6_SaveInsertValueToList
LD R7 R7_SaveInsertValueToList

			

RET
	
R0_SaveInsertValueToList .fill #0
R1_SaveInsertValueToList .fill #0
R2_SaveInsertValueToList .fill #0
R3_SaveInsertValueToList .fill #0
R4_SaveInsertValueToList .fill #0
R5_SaveInsertValueToList .fill #0
R6_SaveInsertValueToList .fill #0
R7_SaveInsertValueToList .fill #0
twoExp14InsertValueToList .fill #-16384
TwoExp14InsertValueToList .fill #16384
.END