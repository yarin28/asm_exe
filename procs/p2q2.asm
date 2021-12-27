;1. byte ptr di
;2. [bx+di],1
;3.si,[bx]
;4. inc si
;5.ret 4
;6.arrp
;7. word ptr -1
data segment
    ar1  dw  s1, s2, -1
    ar2  dw  s3, s4, s5, -1
    ar3  dw  s6, -1
    arP  dw  ar1, ar2, ar3, -1
    s1   db   "exploit",0
    s2   db   "database",0
    s3   db   "basmah",0
    s4   db   "mamram",0
    s5   db   "cyber",0
    s6   db   "computersgraphics",0
    flags   db 26 dup(0)
    p_flags dw flags
ends

stack segment
    dw   128  dup(0)
ends

code segment
     assume cs:code, ds:data
;-----------------------------------------------------------
ScanCharsInString Proc
         Push  Bp
         mov  bp, sp
         Mov  Di,  [bp+4]            ;   pointer to first char of string
     L3:
         mov al,byte ptr[di];1
         Cmp   AL, 0
         Je    Sof_L3
         push  di
         mov   bx, [bp+6]
         mov   ah,0
         mov   di, ax
         sub   di, 97
         add [bx+di],1;2
         pop   di
         Inc   Di
         Jmp   L3
  Sof_L3:
         Pop  Bp
         Ret  4
ScanCharsInString EndP
;-----------------------------------------------------------
ScanArrayOfPontersToStrings Proc
       Push  Bp
       mov  bp, sp
       push  bx
       Mov  si,[bx]
  L2:
       Cmp   [Si], word ptr -1
       Je    Sof_L2
       Push  [bp+6]
       Push  [Si]
       Call   ScanCharsInString
       inc si;4
       Jmp  L2
Sof_L2:
       pop   bx
       Pop  Bp
       ret 4;5
ScanArrayOfPontersToStrings EndP
start:
    mov ax, data
    mov ds, ax

    Lea  bx,arP         ; pointer to array of pointers to arrays of pointers to string
;--------------------------------
;  while  for array of pointers to pointers
L1:
    Cmp  [Bx], word ptr -1
    Je   Zeu
    Lea  Dx, Flags
    Push Dx
    Push [Bx]           ; pointer to array of pointers to string
    Call ScanArrayOfPontersToStrings
    Add  Bx, 2
    Jmp  L1
Zeu:
    mov ax, 4c00h ; exit to operating system.
    int 21h
ends

end start ; set entry point and stop the assembler.
