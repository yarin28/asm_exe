; multi-segment executable file template.

data segment
    X db  23
    Y db  -69
    Z DB  ?
data ends

stack segment
    dw   128  dup(0)
ends

code segment
    assume cs:code, ds:data   
    
    
hathala:
; set segment registers:
    mov ax, data
    mov ds, ax
  
  
    mov  al, x
    add  al, y
    mov  z, al
  
    
    mov ax, 4c00h ; exit to operating system.  
    int 21h    
code ends

end hathala ; set entry point and stop the assembler.
