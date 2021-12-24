;NUM         EQU int

data segment
A db 1
B db 2
C db 3
FLAG db 0
ends

code segment
  assume ds:data
  assume cs:code
start:
    mov ax, data
    mov ds, ax
    mov al,[A]
    add al,[B]
    cmp al,[C]
    jg good
    mov al,[A]
    add al,[C]
    cmp al,[B]
    jg good
    mov al,[B]
    add al,[C]
    cmp al,[A]
    jg good
    mov [FLAG],0
    jmp exit
  good:
    mov [FLAG],1
    jmp exit


  exit:
    mov ax, 4c00h ; exit to operating system.
    int 21h
ends

end start ; set entry point and stop the assembler.
