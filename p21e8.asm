;NUM         EQU int
data segment
s db 0
m db 0
h db 0
input db 0

ends

code segment
  assume ds:data
  assume cs:code
start:
    mov ax, data
    mov ds, ax
    mov ch,[input]
    div ch,24
    mov h,[al]
    div ah,60
    mov m,[al]
    div ah,60
    mov s,[al]
  exit:
    mov ax, 4c00h ; exit to operating system.
    int 21h
ends

end start ; set entry point and stop the assembler.
