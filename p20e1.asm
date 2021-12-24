;NUM         EQU int

;------------------------------------------
data segment
  A db 100
  B db 200
  fA db 0
  fB db 0
ends

code segment
  assume ds:data
  assume cs:code
start:
    mov ax, data
    mov ds, ax
    mov al,[A]
    mov ah,[B]
    cmp al,-12
    jle doesnt_match
    cmp al,29
    jge doesnt_match
    inc al
  doesnt_match:
    mov [A],al
    cmp ah,-12
    jle doesnt_match2
    cmp ah,29
    jge doesnt_match2
    inc ah
    mov [A],ah
  doesnt_match2:
    jmp exit

  exit:
    mov ax, 4c00h ; exit to operating system.
    int 21h
ends

end start ; set entry point and stop the assembler.
