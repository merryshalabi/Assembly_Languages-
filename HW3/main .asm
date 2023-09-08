; 212018535, 50%
; 324007202, 50%
.ORIG X3000

LEA R0 PROMPT_row               ; PUT INTO R0 PROMPT_row STRING 
PUTS	                        ; PRINTING THE STRING THAT EXIST INTO R0 
LD R6 GetNumSub_ptr             ; PUT INTO R6 THE ADDRESS OF GetNum SABROUTINE
JSRR R6                         ; GO TO THE ADDRESS THAT EXIST INTO R6
ADD R4 R2 #0                    ; PUT THE ROWS NUMBER INTO R4
 
 
 
LEA R0 PROMPT_col              ; PUT INTO R0 PROMPT_col STRING 
PUTS                           ; PRINTING THE STRING THAT EXIST INTO R0 
LD R6 GetNumSub_ptr            ; PUT INTO R6 THE ADDRESS OF GetNum SABROUTINE
JSRR R6                        ; GO TO THE ADDRESS THAT EXIST INTO R6
ADD R5 R2 #0                   ; PUT THE COLOMNS NUMBER INTO R5 



LEA R0 PROMPT_values           ; PUT INTO R0 PROMPT_col STRING 
PUTS                           ; PRINTING THE STRING THAT EXIST INTO R0 
LD R3 MATRIX_ptr               ;  R3= THE MATRIX ADDRESS
LD R6 GetMatrixSub_ptr         ; PUT INTO R6 THE ADDRESS OF GetMatrix SABROUTINE 
JSRR R6                        ; GO TO THE ADDRESS THAT EXIST INTO R6

LD R2 TREE_ptr                 ; R2= THE TREE ADDRESS
LD R6 InsertToTreeSub_ptr      ; PUT INTO R6 THE ADDRESS OF InsertToTree SABROUTINE 
JSRR R6                        ; GO TO THE ADDRESS THAT EXIST INTO R6

LEA R0 PROMPT_sum              ; PUT INTO R0 PROMPT_sum STRING
PUTS                           ; PRINTING THE STRING THAT EXIST INTO R0
LD R0 LIST_ptr                 ; R0= THE LIST ADDRESS
LD R6 PrintListSub_ptr         ; PUT INTO R6 THE ADDRESS OF PrintList SABROUTINE 
JSRR R6                        ; GO TO THE ADDRESS THAT EXIST INTO R6

HALT
; ----------------------------------------------------------------
; Here you'll find useful labels, fills and strings. You should probably use them.
ROW	.fill #0
COL	.fill #0
GetNumSub_ptr		.fill X41F4
GetMatrixSub_ptr	.fill X444C
InsertToTreeSub_ptr	.fill X4834
SummarySub_ptr		.fill X4A28
PrintListSub_ptr	.fill X4C1C
MATRIX_ptr		.fill X5000
LIST_ptr		.fill X5024
TREE_ptr		.fill X50A0
PROMPT_row		.stringz "Enter the number of rows: "
PROMPT_col		.stringz "Enter the number of columns: "
PROMPT_values		.stringz "Enter the matrix values:"
PROMPT_sum		.stringz "Summary:"
; ----------------------------------------------------------------

; ----- Write here your constant/labels/Auxiliary subroutine -----

; ----------------------------------------------------------------
.END