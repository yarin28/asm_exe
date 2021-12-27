;-----------------------------
data segment
   N   Dw 1273;27693
   Res Db ?
ends
;-----------------------------
stack segment
    dw   128  dup(0)
ends
;-----------------------------
code segment
    assume cs:code,ds:data
start:
; set segment registers:
    mov ax, data
    mov ds, ax
    ; Res = MaxDigit(n)
    push N
    call MaxDigit
    mov  Res, al
    mov ax, 4c00h ; exit to operating system.
    int 21h
ends
MaxDigit proc
  push bp
  mov bp,sp
  push cx
  push dx
  mov ax,[bp+4];n
  cmp ax,10
  jl sof
  mov dx,0
  mov cx,10
  div cx
  push ax
  call MaxDigit
  cmp ax,dx; dx has the mudolo
 sof:
  pop dx
  pop cx
  pop bp
  ret 2
endp MaxDigit
end start ; set entry point and stop the assembler.
