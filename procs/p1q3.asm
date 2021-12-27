data segment
str1 db "i love to write asm"
len1 db $-str1
str2 db "asm"
len2 db $-str2
flag db 0
ends

code segment
  assume ds:data
  assume cs:code
check_end proc
  push bp
  mov bp,sp
  push bx
  push si
  lea bx,str1
  add bl,[len1]
  sub bl,[len2]
  push cx
  mov cl,[len2]
  lea si,str2
  lo1:
    mov al,byte ptr[bx]
    mov ah,byte ptr[si]
    cmp al,ah
    jne bad
    loop lo1
  good:
  mov [flag],1
  jmp csof
  bad:
    mov [flag],0

  csof:
    pop cx
    pop si
    pop bx
    pop bp
    ret

endp check_end
start:
    mov ax, data
    mov ds, ax
    call check_end
  exit:
    mov ax, 4c00h ; exit to operating system.
    int 21h
ends

end start ; set entry point and stop the assembler.
