;1. lea
;2.
;3.
;4.
;5.
;6.
Data Segment
 	   Adr         Dw Mess0, Mess1, Mess2, Mess3
    Mess0     Dw Mess4 + 3
                   Db   4
    Mess1     Dw Mess3 + 3
                   Db   7
                   Db ' a bed'
   Mess2      Dw Mess1 + 3
                    Db   6
                    Db ' of roses'
   Mess3      Dw  Mess2 + 3
                    Db   9
                    Db ' is not'
   Mess4      Dw Mess1 + 3
                    Db  4
                    Db 'life'
   Result Db  50 Dup('$')
Data  Ends
Code Segment
  Assume   Cs:Code, Ds:Data
Start:
      Mov   Ax, Data
      Mov   Ds, Ax
      Mov   CH, 0
     lea     Bx, Adr
      Mov   Dx, (Mess0 - Adr)/2
      Lea     Di, Result
   Next:
       Mov  Si, [Bx]
       Mov  CL, [si+2]
       mov si,[si]
      L1:
          Mov  AL, [Si]
          Mov  [Di], Al
                    inc di
                  inc si
          Loop  L1
       Add  Bx, 2
       cmp bx,8
       Jnz   Next
       Mov   Ax, 4C00h
       Int   21h
Code  Ends
End  Start
