;https://imgur.com/lcGng9P
;NUM         EQU int
data segment

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

