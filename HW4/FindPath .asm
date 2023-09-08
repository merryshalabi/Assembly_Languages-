; 212018535, 50%
; 324007202, 50%
; Convention: Haifa
.Orig x3C80
FindPath:
;;;;;;FindPath(i,j,N,CellAddress,MatrixAddress);;;;
    ; Increase stack size by number of registers to backup
	ADD R6 R6 #-6
    ; Backup registers for local use
	STR R1 R6 #0
	STR R2 R6 #1
	STR R3 R6 #2
	STR R4 R6 #3
	STR R5 R6 #4
	STR R7 R6 #5

	LDR R1 R6 #6 ; R1=i
    LDR R2 R6 #7 ; R2=j
    LDR R3 R6 #8 ; R3=N
    LDR R4 R6 #9 ; R4= CellAddress
    LDR R5 R6 #10 ; R5=MatrixAddress
;;;;;;;;;if(i=n&&j=n);;a[i][j]=*;;go to print;;;;
IF1:
	NOT R5 R2   
	ADD R5 R5 #1 ; R5=-j
	ADD R5 R5 R1 ; R5=-J+i
	BRnp IF2     ; if I!=J go to if2 
	ADD R5 R3 #0 ; R5=N
	NOT R5 R5 
	ADD R5 R5 #1 ; R5=-N
	ADD R5 R5 R1 ; if I!=N (R5= I-N) go to if2
	BRnp IF2

	LD R5 Star_Ascii_PrintMatrix
	STR R5 R4 #0  ; A[I][J]=*
	LDR R5 R6 #10 ; R5=MatrixAddress 

	STR R3 R6 #-2 ; R3=N  
	STR R5 R6 #-1 ; R5=MatrixAddress

	LD R5 PrintMatrixAddress
	ADD R6 R6 #-2  ; update R6
	JSRR R5        ; go to PrintMatrix function
	ADD R6 R6 #2   ; decrease stack size by the number of parameters

    
	BR EndOfFindPath

;;;;;;;;if((1=<(j+1)=<N)&&A[I][J+1]=1);;A[I][J]=*;;;FindPath(I,J+1,N);;IF(R0=-1) RETURN;;;;
;;;check if the we can go one cell right in the matrix;;;;
IF2:

	NOT R5 R3    ; R5=-N
	ADD R5 R5 #1 ; R5 = -N+1
	ADD R5 R2 R5 ; R5 = R2-N+1 ; J+1-N>0 Out of range
	ADD R5 R5 #1 
	BRp IF3      ; if J+1-N>0 go to IF 3
	ADD R5 R2 #0 ;  R5 = R2+1 -1 ; R2< 1 Out of range 
	BRn IF3
	LDR R5 R4 #1 ; R5=A[i][j+1] if R5 = 1 
	ADD R5 R5 #-1 ; if A[i][j+1]!=1 go to IF3
	BRnp IF3

	LD R5 Star_Ascii_PrintMatrix
	STR R5 R4 #0 ; A[i][j]=*

	ADD R2 R2 #1 ; R2= J+1
	ADD R4 R4 #1 ; Move the pointer to A[i][j+1]

	LDR R5 R6 #10 ; R5=MatrixAddress 

	STR R1 R6 #-5 ; I
	STR R2 R6 #-4 ; J+1
	STR R3 R6 #-3 ; N
	STR R4 R6 #-2 ; A[i][j+1] Address
	STR R5 R6 #-1 ; MatrixAddress


	ADD R6 R6 #-5 ; update R6
	JSR FindPath  ; FindPath(I,J+1,N,A[i][j+1] Address,MatrixAddress)
	ADD R6 R6 #5  ; decrease stack size by the number of parameters
    
    ADD R2 R2 #-1 
	ADD R4 R4 #-1
     
	ADD R5 R0 #1 ; if R0=-1 the user doesn't want another solution go to end
	BRz EndOfFindPath

;;;;;;;;if((1=<(I+1)=<N)&&A[I+1][J]=1);;A[I][J]=*;;;FindPath(I+1,J,N);;IF(R0=-1) RETURN;;;;
;;;check if the we can go one cell up in the matrix;;;;
IF3:

	NOT R5 R3    ; R5=-N
	ADD R5 R5 #1 ; R5 = R1+1-N ; R1-N+1>0 Out of range
	ADD R5 R1 R5 ; R5= -N+1+i >0
	ADD R5 R5 #1
	BRp IF4
	ADD R5 R1 #0 ;  R5 = R1+1 -1 ; R1< 1 Out of range 
	BRn IF4
	ADD R5 R4 R3 ; R5= A[I][J] + N
	LDR R5 R5 #0 ; R5=A[i+1][j] if R5 = 1 
	ADD R5 R5 #-1
	BRnp IF4

	LD R5 Star_Ascii_PrintMatrix
	STR R5 R4 #0 ; A[i][j]=*

	ADD R1 R1 #1 ; R1= I+1
	ADD R4 R4 R3 ; Move the pointer to A[i+1][j]

	LDR R5 R6 #10 ; R5=MatrixAddress 

	STR R1 R6 #-5 ; I+1
	STR R2 R6 #-4 ; J
	STR R3 R6 #-3 ; N 
	STR R4 R6 #-2 ; A[i+1][j] Address
	STR R5 R6 #-1 ; MatrixAddress


	ADD R6 R6 #-5 ; update R6
	JSR FindPath  ; FindPath(I+1,J,N,A[i+1][j] Address,MatrixAddress)
	ADD R6 R6 #5  ; decrease stack size by the number of parameters
	
    ADD R1 R1 #-1 
	NOT R5 R3
	ADD R5 R5 #1
	ADD R4 R4 R5
	
	
	ADD R5 R0 #1 ; if R0=-1 the user doesn't want another solution go to end
	BRz EndOfFindPath

;;;;;;;;if((1=<(I-1)=<N)&&A[I-1][J]=1);;A[I][J]=*;;;FindPath(I-1,J,N);;IF(R0=-1) RETURN;;;;
;;;check if the we can go one cell down in the matrix;;;;
IF4:

	NOT R5 R3    ; R5=-N
	ADD R5 R5 #1 ; R5 = R1-1-N ; R1-N-1>0 Out of range
	ADD R5 R1 R5 
	ADD R5 R5 #-1
	BRp IF5
	ADD R5 R1 #-2 ;  R5 = R1 -2 ; R1<= 2 Out of range 
	BRn IF5
	NOT R5 R3    ; R5 = -N
	ADD R5 R5 #1
	ADD R5 R4 R5 ; R5= A[I][J] - N
	LDR R5 R5 #0 ; R5=A[i-1][j] if R5 = 1 
	ADD R5 R5 #-1
	BRnp IF5

	LD R5 Star_Ascii_PrintMatrix
	STR R5 R4 #0  ; A[i][j]=*

	ADD R1 R1 #-1 ; R2= I-1
	NOT R5 R3
	ADD R5 R5 #1
	ADD R4 R4 R5  ; Move the pointer to A[i-1][j]

	LDR R5 R6 #10 ; R5=MatrixAddress 

	STR R1 R6 #-5 ; I-1
	STR R2 R6 #-4 ; J
	STR R3 R6 #-3 ; N
	STR R4 R6 #-2 ; A[i-1][j] Address
	STR R5 R6 #-1 ; MatrixAddress


	ADD R6 R6 #-5 ; update R6
	JSR FindPath  ; FindPath(I-1,J,N,A[i-1][j] Address,MatrixAddress)
	ADD R6 R6 #5  ; decrease stack size by the number of parameters
	 
    ADD R1 R1 #1
	ADD R4 R4 R3

	ADD R5 R0 #1 ; if R0=-1 the user doesn't want another solution go to end
	BRz EndOfFindPath

;;;;;;;;if((1=<(J-1)=<N)&&A[I][J-1]=1);;A[I][J]=*;;;FindPath(I,J-1,N);;IF(R0=-1) RETURN;;;;
;;;check if the we can go one cell left in the matrix;;;;
IF5:

	NOT R5 R3    ; R5=-N
	ADD R5 R5 #1
	ADD R5 R2 R5 ; R5 = R2-N ; R2-N>0 Out of range
	ADD R5 R5 #-1
	BRp IF6
	ADD R5 R2 #-2 ;  R5 = R1 -1 ; R1< 1 Out of range 
    BRn IF6
	LDR R5 R4 #-1 ; R5=A[i][j-1] if R5 = 1 
	ADD R5 R5 #-1
	BRnp IF6

	LD R5 Star_Ascii_PrintMatrix
	STR R5 R4 #0 ; A[i][j]=*

	ADD R2 R2 #-1 ; R2= J-1		
	ADD R4 R4 #-1 ; Move the pointer to A[i][j-1]

	LDR R5 R6 #10 ; R5=MatrixAddress 

	STR R1 R6 #-5 ; I
	STR R2 R6 #-4 ; J-1 
	STR R3 R6 #-3 ; N
	STR R4 R6 #-2 ; A[i][j-1] Address
	STR R5 R6 #-1 ; MatrixAddress


	ADD R6 R6 #-5 ; update R6
	JSR FindPath  ; FindPath(I,J-1,N,A[i][j-1] Address,MatrixAddress)
	ADD R6 R6 #5  ; decrease stack size by the number of parameters
    
    ADD R2 R2 #1
	ADD R4 R4 #1

	ADD R5 R0 #1 ; if R0=-1 the user doesn't want another solution go to end
	BRz EndOfFindPath

;;;;;;;;;;;;IF(I=1;J=1&&R=0) -> print no solution ;;;;; IF(I=1,J=1&&R0>0) -> print no another solution
;;; check if we in the first cell in matrix then no solution or no another solution
IF6:
	ADD R5 R1 #-1      ; if I!=1 go to EndOfFindPath
	BRnp EndOfFindPath
	ADD R5 R2 #-1      ; if J!=1 go to EndOfFindPath
	BRnp EndOfFindPath
	ADD R0 R0 #0       ; if I=J=1 and R0=0 that means that we didn't go to PrintMatrix go to NoSolution
	BRz NoSolution     
	BRn EndOfFindPath
	
    ; if R0 is positive that mean we did go to print matrix but there is no another solution
	ADD R5 R0 #0
	LEA R0 No_Another_Solution_String
	PUTS
	LD R0 Enter_Ascii_FindPath
	OUT
    ADD R0 R5 #0
	BR EndOfFindPath

NoSolution:
    ADD R5 R0 #0
	LEA R0 No_Solution_String
	PUTS
	LD R0 Enter_Ascii_FindPath
	OUT
    ADD R0 R5 #0


EndOfFindPath:
		
	AND R5 R5 #0
	ADD R5 R5 #1  
	STR R5 R4 #0  ; A[I][J]=1 
	 ; Restore backed up registers from the stack
	LDR R1 R6 #0  
	LDR R2 R6 #1
	LDR R3 R6 #2
	LDR R4 R6 #3
	LDR R5 R6 #4
	LDR R7 R6 #5
    ; update R6
	ADD R6 R6 #6


RET



Star_Ascii_PrintMatrix .fill #42
PrintMatrixAddress .fill x3B54
No_Solution_String .stringz "OH NO! It seems the mouse has no luck in this maze."
No_Another_Solution_String .stringz "OH NO! It seems the mouse could not find another solution for this maze."
Enter_Ascii_FindPath .fill #10
.END