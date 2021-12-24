;NUM         EQU int

data segment
A db 1
B db 2
C db 3
min db 0
ends

code segment
  assume ds:data
  assume cs:code
start:
    mov ax, data
    mov ds, ax

    mov ah,[A]
    mov al,[B]
    cmp ah,al
    jl a_bigger
    jmp b_bigger
  a_bigger:
    mov al,[C]
    cmp ah,al
    jl a_biggest
    jmp c_biggest
  a_biggest:
    mov [MAX],ah
    jmp exit
  b_bigger:
    mov ah,[B]
    mov al,[C]
    cmp ah,al
    jl b_biggest
    jmp c_biggest
  c_biggest:
    mov [MAX],ah
    jmp exit
  c_biggest:
    mov [MAX],al
    jmp exit

  exit:
    mov ax, 4c00h ; exit to operating system.
    int 21h
ends

end start ; set entry point and stop the assembler.
