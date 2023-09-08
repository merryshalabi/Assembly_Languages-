; 212018535, 50%
; 324007202, 50%
; Convention: Haifa
.Orig x38FC
GetNum: 
	; Increase stack size by number of registers to backup
    ADD R6 R6 #-5
   
    STR R1 R6 #0   ; Backup registers for local use
    STR R3 R6 #1
    STR R4 R6 #2
    STR R5 R6 #3
    STR R7 R6 #4
  
    AND R4 R4 #0   ; initializing the registers that we will use
    AND R5 R5 #0 
    AND R1,R1,#0

   
    ; Reading an input from the user , and print until you get a number 
    GetNumAssistant:
    GETC                          
    OUT                             
    LD R4 Space_Ascii_GetNum       
    ADD R4 R4 R0                  
    BRz GetNumAssistant 
   
    ; Check if the number in R0 is negative and use R1 as a flag  
    LD R4 Minus_Ascii_GetNum       
    ADD R4 R4 R0                   
    BRnp Positive_GetNum 
    AND R4 R4 #0   
    ADD R1 R1 #1                                               
    BR GetNumAssistant
     
   
    Positive_GetNum:
    AND R4 R4 #0                   ; R4=0 
   
    ; converting the number in R0 from ascii value to actual number
    Loop_GetNum:
    LD R3 Zero_Ascii_GetNum        
    ADD R0 R0 R3                   
    ADD R1 R1 #0                 ; Check if the number in R0 negative    
    BRz Mul_10_GetNum             
    NOT R0,R0                      
    ADD R0,R0,#1                  ; Do twos compliment if the number in R0 is negative
    
    Mul_10_GetNum:
    AND R5 R5 #0                  ; Initializing R5 to 0 
    LD R3 Ten_GetNum              ; R3= 10 
   
    ;Loop to multiply R4*10 
    Loop_Mul_10_GetNum:
    ADD R5 R5 R4                  
    ADD R3 R3 #-1                 ; Decrease the counter  
    BRp Loop_Mul_10_GetNum        

    ADD R4 R5 #0                  ; Put the final result into R4
    ADD R4 R4 R0                  ; R4=R4+R0
    GETC                          ; Reading an input from the user and put the ascii value of the input in R0
    OUT                           ; Printing the ascii value of the number in R0
    LD R3 Space_Ascii_GetNum      
    ADD R3 R3 R0                  ; If the the value in R0 is space ascii value go to EndGetNum
    BRz EndGetNum                
    LD R3 Enter_Ascii_GetNum     
    ADD R3 R3 R0                  ; If the the value in R0 is enter ascii value go to EndGetNum
    BRz EndGetNum                 
    BR Loop_GetNum                ; Else go to Loop_GetNum
   
    EndGetNum:
    ADD R0 R4 #0                  ; put the final result into R2 
   
    ; Restore backed up registers from the stack   
    LDR R1 R6 #0   
    LDR R3 R6 #1
    LDR R4 R6 #2
    LDR R5 R6 #3
    LDR R7 R6 #4
   
    ADD R6, R6, #5

    RET 
   

Space_Ascii_GetNum .fill #-32
Zero_Ascii_GetNum .fill #-48
Minus_Ascii_GetNum .fill #-45
Ten_GetNum .fill #10 
Enter_Ascii_GetNum .fill #-10
.END 