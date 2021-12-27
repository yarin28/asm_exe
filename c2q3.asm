; multi-segment executable file template.

data segment
    ar dw 23, -56, 56, 6, 34
       Len = ($-ar)/2
    Res Dw ?
ends

stack segment
    dw   128  dup(0)
ends

;-------------------------------------------
;short MaxElement(short*p, int n)
;{
;	short m;
;	if ( n == 1 )
;		return *p;
;	m = MaxElement(p + 1, n - 1);
;	return m > *p ? m : *p;
;}
code segment
MaxElement  Proc
  push bp
  mov bp,sp
  sub sp,2; for m
  push bx
  push cx
  push dx
  mov bx,[bp+4]
  mov cx,[bp+6]
  cmp cx,1
  jg next
  mov ax,[bx]
  jmp sof
next:
  add bx,2
  sub cx,1
  push cx
  push bx
  call MaxElement
  mov bx,[bp+4]
  cmp ax,[bx]
  jg sof
  mov ax,[bx]

sof:
  pop dx
  pop cx
  pop bx
  add sp,2
  pop bp
  ret 4
MaxElement  Endp
;-------------------------------------------
start:
; set segment registers:
    mov ax, data
    mov ds, ax
    ; short Res = MaxElement(ar, sizeof(ar) / sizeof(ar[0]));
    push len
    push offset ar
    call MaxElement
    Mov  Res, Ax
    mov ax, 4c00h ; exit to operating system.
    int 21h
ends

end start ; set entry point and stop the assembler.
