data segment
arr db "1y@23xyz",db 100 dup(0)
len dw $-arr
ends
stack segment
db 100h dup(0)
ends
code segment
  assume ds:data
  assume cs:code
 extract proc
  push bp
  mov bp,sp
  push ax
  push cx
  push dx
  inc bx
  mov cl,byte ptr [bx]
  loop_to_the_second_number:
  

  loop loop_to_the_second_number


  pop dx
  pop cx
  pop ax
  pop bp
  ret


endp extract
exchange proc

  push bp
  mov bp,sp
  push ax
  push cx
  push dx
  
  pop dx
  pop cx
  pop ax
  pop bp
  ret

endp exchange

start:
    mov ax, data
    mov ds, ax
    xor bx,bx
    xor cx,cx
    xor ax,ax
    lea bx, arr
    loop_for_extraction:
      mov al,byte ptr[bx]
      cmp al,"@"
      je found_the_@
      jmp didnt_found_the_@
    found_the_@:
    inc bx
    call extract
    didnt_found_the_@:
      inc bx
      cmp bx,len
      jne loop_for_extraction

  exit:
    mov ax, 4c00h ; exit to operating system.
    int 21h
ends

end start ; set entry point and stop the assembler.
