; the program will return the array in hex
;str1 - return the numbers
;help - convert the number to digit
Data Segment
	  Ar    dw  22,16,35,17
	 	    Len =  ( $ - Ar )/2
	  Str1  db  Len*5   dup('0')
	  Help  db  '0123456789ABCDEF'
	D     dw  10h
Data  Ends
Code  Segment
 Assume cs:Code, ds:Data
;-----------------------------
	 Operation Proc  Near
		     Push  bp
		     Mov   bp, sp
		     Push  bx
		     Push  di

		     Mov   bx, [bp+4]
		     Mov   di, [bp+6]
		     Add   di, 4
		     Mov   al, ','
		     Mov   [di], al
		     Mov   ax, [bx]
LO:
		     Cmp   ax, 0
		     Je    Sof_Lo
		     Mov   Dx, 0
		     Div   D
		     Mov   si, [bp+8]
		     Add   si, dx
		     Mov   cl, [si]
		     Dec   di
		     Mov   [di], cl
		     Jmp   LO
Sof_Lo:
		     Pop   di
		     Pop   bx
		     Pop   bp
		     Ret   6
Operation  Endp
;----------------------------------------
Begin:
		   Mov    ax, Data
		   Mov    ds, ax
		   Lea    bx, ar
		   Lea    di, Str1
L01:
		     Push   Offset Help
     Push   di
		     Push   bx
     Call   Operation
		     Inc    bx
		     Inc    bx
		     Add    di, 5
		     Cmp    bx, Offset Ar + Len*Type Ar
		     JL     L01
		 Mov    ax,4c00h
		 Int   21h
Code Ends
End  Begin
