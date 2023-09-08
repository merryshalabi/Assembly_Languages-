; 212018535, 50%
; 324007202, 50%
; Convention: Haifa
.Orig x39C4
GetMatrix:
	; Increase stack size by number of registers to backup
    ADD R6 R6 #-6
   
    ; Backup registers for local use
    STR R1 R6 #0   
    STR R2 R6 #1
    STR R3 R6 #2
    STR R4 R6 #3
    STR R5 R6 #4
    STR R7 R6 #5
   
    LDR R3 R6 #6     ; R3=MatrixPointer
    LDR R4 R6 #7     ; R4=N
   
    AND R2 R2 #0     ; initializing the registers that we will use
    ADD R5 R4 #0
    AND R1 R1 #0
   
    ; Loop to multiply rows and colums R4*R4
    Loop_ColumsMulRows_GetMatrix:       
    ADD R1 R1 R4                        
    ADD R5 R5 #-1                       ; Decrease the counter 
    BRp Loop_ColumsMulRows_GetMatrix    
    ADD R4 R1 #0
   
    ; print input string
    LEA R0 InputStringGetMatrix
    PUTS
    LD R0 EnterAsciiGetMatrix
    OUT
   
    ; Take the first value from the user 
    MustBeOne:
    LD R2 GetNum_Address_GetMatrix 
    JSRR R2
    ADD R4 R4 #-1
    TheLastCell:
    ADD R5 R0 #-1                  ; check if the value in R0 is 1
    BRnp IllegalInput
    STR R0 R3 #0                   ; Storing the value into the matrix 
    ADD R3 R3 #1                   ; move the pointer to the next cell 
    ADD R4 R4 #0                    
    BRnz EndGetMatrix   
    BR GetMatrixAssestant          ; Go to GetMatrixAssestant to take the next value          
   
    IllegalInput:
    ADD R4 R4 #0                        ; if R4=0 ( the last cell in maze) go to TheLastCellIsIllegal
    BRnz TheLastCellIsIllegal      
    LD R2 GetNum_Address_GetMatrix  
    JSRR R2                             ; Go to GetNum subroutine 
    ADD R4 R4 #-1 
    BRp IllegalInput                    ; if r4>0 go to IllegalInput        
    TheLastCellIsIllegal:
    LEA R0 IllegalInputStringGetMatrix  ; print illegal input string and go to MustBeOne to take the values of the matrix again
    PUTS
    LD R0 EnterAsciiGetMatrix
    OUT 
    ADD R4 R1 #0
    BR MustBeOne
   
   
    GetMatrixAssestant:
    LD R2 GetNum_Address_GetMatrix 
    JSRR R2             ; go to GetNum subroutine to take the next value
    ADD R4 R4 #-1   
    BRz TheLastCell     ; if r4=0 ( the last cell) go to TheLastCell
    ADD R5 R0 #-1       ; check if the value in r0 is legal
    BRz LegalInput     
    ADD R5 R0 #0
    BRz LegalInput
    BR IllegalInput    ; if the value in r0!=0 and r0!=1 go to IllegalInput
      
    LegalInput:
    STR R0 R3 #0                    ; Storing the value into the matrix 
    ADD R3 R3 #1                    ; move the pointer to the next cell
    ADD R4 R4 #0
    BRp GetMatrixAssestant
    BR EndGetMatrix
   
   
   
    EndGetMatrix:
  
    LEA R0 Legal_Input_String
    PUTS
    LD R0 EnterAsciiGetMatrix
    OUT
        
    LDR R4 R6 #7
    ADD R0 R4 #0
 	
    LDR R1 R6 #0   ; Restore backed up registers from the stack
    LDR R2 R6 #1
    LDR R3 R6 #2
    LDR R4 R6 #3
    LDR R5 R6 #4
    LDR R7 R6 #5    
   
    ADD R6 R6 #6 
    RET

GetNum_Address_GetMatrix .fill x38FC
IllegalInputStringGetMatrix .stringz "Illegal maze! Please try again: "
InputStringGetMatrix .stringz "Please enter the maze matrix: "
EnterAsciiGetMatrix .fill #10
Legal_Input_String .stringz "The mouse is hopeful he will find his cheese."
.END
