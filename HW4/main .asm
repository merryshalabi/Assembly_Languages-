; 212018535, 50%
; 324007202, 50%
; Convention: Haifa
.Orig x3000
main:

	LEA R0 InputString
	PUTS
	LD R6 STACK_ADDRESS 
	LD R3 GetNumAddressMain
 
	JSRR R3       ; go to get num function 
 
	LEA R3 Matrix
	LD R4 GetMatrixAddressMain

	STR R3 R6 #-2 ; R3= Matrix ADDRESS
	STR R0 R6 #-1 ; R0= N
 
	ADD R6 R6 #-2 ; increase stack size by the number of parameters
	JSRR R4       ; go to get matrix function 
	ADD R6 R6 #2  ; decrease stack size by the number of parameters
 

	ADD R4 R0 #0 ; R4=N
	AND R1 R1 #0 ; R1=i
	ADD R1 R1 #1 ; R2=J 
	ADD R2 R1 #0 ; R1=R2=1
 
	AND R0 R0 #0
	LEA R3 Matrix
	LD R5 FindPathAddressMain
 
	STR R1 R6 #-5 ; I
	STR R2 R6 #-4 ; J
	STR R4 R6 #-3 ; N
	STR R3 R6 #-2 ; Matrix address
	STR R3 R6 #-1 ; Matrix address
 

	ADD R6 R6 #-5 ; increase stack size by the number of parameters
	JSRR R5       ; FindPath(1,1,N,A[1][1] Address,MatrixAddress)
	ADD R6 R6 #5  ; decrease stack size by the number of parameters
 
 
HALT
STACK_ADDRESS	.fill	XBFFF
InputString .stringz "Please enter a number between 2 to 20: "
GetNumAddressMain  .fill x38FC
GetMatrixAddressMain .fill x39C4
FindPathAddressMain .fill x3C80
PrintMatrixAddressMain .fill x3B54
Matrix .blkw #400 #-1


.END