;NUM         EQU int
data segment

ends

code segment
  assume ds:data
  assume cs:code
start:
    mov ax, data
    mov ds, ax
    mov ax, data
    mov ds, ax
    mov es, ax
    xor ax,ax
    xor bx,bx
    xor cx,cx
    xor dx,dx
    Mov AX, 0FFE2h
CWD
Mov BX, 7
IDIV BX

    mov ax, 4c00h ; exit to operating system.
    int 21h
ends

end start ; set entry point and stop the assembler.
