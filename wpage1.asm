; multi-segment executable file template.

data segment
    ; add your data here!
 A DB 1, 7, 0
ends

stack segment
    dw   128  dup(0)
ends

code segment
start:
; set segment registers:
    mov ax, data
    mov ds, ax
    mov es, ax
    xor ax,ax
    xor bx,bx
    xor cx,cx
    xor dx,dx

Mov AL, -1
CBW
Mov BX, 200
DIV BL


    mov ax, 4c00h ; exit to operating system.
    int 21h    
ends

end start ; set entry point and stop the assembler.
