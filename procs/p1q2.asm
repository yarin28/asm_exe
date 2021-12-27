; the program return in the ar2 array 1, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0
; the perpus of this program is to check if the number is prime
Data   Segment
   Ar1   Db  11,24,33,19,18
	    Len=$ - Offset Ar1
   Ar2   Db  Len  Dup(0)
Data  Ends
Code   Segment
 Assume Ds:Data,Cs:Code
;----------------------------------------------------------------
Fun  Proc
		    Push   Bp
		    Mov    Bp, Sp
		    Mov    Bx, [Bp+6]
		    Mov    Si, [Bp+4]
		    Mov    Cl, 2
		    Mov    Ah, 0




		    Mov    Al, [Bx]
		    Div    Cl
		    Cmp    Ah, 0
		    Je     No
		    Mov    Dh, Al
		    Mov    Cl, 3
LO:
		    Mov  Ah, 0
		    Mov  Al, [Bx]
		    Div  Cl
		    Cmp  Ah, 0
		    Je   No
		    Add  Cl, 2
		    Cmp  Cl, Dh
    Jle  LO
		    Mov  [Si], 1
No:
		    Pop  Bp
		    Ret  4
Fun  EndP
;----------------------------------------------------------------
Start:
				     Mov  Ax,Data
				     Mov  Ds,Ax

				     Lea  Bx,Ar1
				     Lea  Si,Ar2
Lo1:
				     Cmp   Bx,Offset Ar1+Len
				     Je    Sof
				     Push  Bx
				     Push  Si
				     Call  Fun
				     Inc   Si
				     Inc   Bx
				     Jmp   Lo1
 Sof:
;    E X I T    T O     D O S
		 Mov    ax,4c00h
		 Int    21h
Code  Ends
End   Start
