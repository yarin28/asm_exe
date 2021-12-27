; i had a problem here, the G variable seems to be in an odd place so the bx register can never reach him
Data  Segment
  Lines  Db  'QWERTYUIO1$'
          len = $-Offset Lines
         Db  'QWEyfdfdf!$'
         Db  '23        $'
         Db  '123       $'
P        Dw  Lines, Lines + len, Lines + 2*len, Lines + 3*len
        N = ( $ - P ) /2;type p
G        Dw  ?
Data  Ends
Code  Segment
Assume  Cs: Code, Ds:Data
;*****************************************************************
StrCmp  Proc
       Push  Bp
       Mov   Bp, Sp
       Push  Di
       Mov   Si, [Bp+4]
       mov   di,[Bp +6];7
       Mov   Cx, [Bp+8]
       Dec   Si
       Dec   Di
   L1:
       Inc   Si
       Inc   Di
       Mov   AL, [Si]
       Cmp   AL, [Di]
       je L1 ;8
       Pop   Di
       Pop   Bp
       Ret    6;9
StrCmp   EndP
;*****************************************************************
Start:
    Mov  Ax, Data
    Mov  Ds, Ax
    Mov  DL, 1
    lea bx,P;1
 Lul2:
    Cmp  DL, 1
    Jne  Sof
    Mov  Dl, 0
          Lul3:
      Cmp   Bx, G
      Je    Sof_Lul3
      Push  len
      Push  [Bx +2];3
      Push  [Bx]
      Call  StrCmp
        jb No;4
      Mov   Di, Bx
      mov [G],1;5
      Mov   Ax, [Bx]
      Xchg  Ax, [Bx+2]
       mov [bx],ax;6
No:
      Add   Bx,2
      Jmp   Lul3
Sof_Lul3:
      Mov   G, Di
      Jmp  Lul2
Sof:
     Mov  Ax, 4C00h
     Int  21h
Code Ends
End Start
