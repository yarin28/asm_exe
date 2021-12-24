;NUM         EQU int
data segment
arr db 1, "y", "@", "2" ,3, "x", "y", "z",db 100 dup (0)
ends
stack segment
db 100h dup(0)
ends
code segment
  assume ds:data
  assume cs:code
start:
    mov ax, data
    mov ds, ax

  exit:
    mov ax, 4c00h ; exit to operating system.
    int 21h
ends

end start ; set entry point and stop the assembler.
