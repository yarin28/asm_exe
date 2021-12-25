; exe - https://imgur.com/a/LNYd5Dw
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
 ;cl - the amount to be repeted
 ;dl - the char to be repted
 extract proc
  push bp
  mov bp,sp
  push ax
  push cx
  push dx
  xor cx,cx
  mov cl,byte ptr [bx]
  mov dl, byte ptr [ bx+1 ]
  call push_the_rest_of_array
  call duplicate_the_num
  loop_to_the_second_number:





  pop dx
  pop cx
  pop ax
  pop bp
  ret


endp extract
  ; proc to push all the elements after the the number of tines the number -2 places fowerd( why 2 places? because there is the @, number ,the number itself )
push_the_rest_of_array proc


  push bp
  mov bp,sp
  push ax
  push bx
  push si
  push di
  mov di,bx
  add di,cx
  dec di; add this later
  mov si,cx
  ;inc bx; now is the poitner to the value of the first num (toe one to be repeted by the extraction)

  inc bx ;now in the next element of the string that will be sent the all way to the back
  cmp si,0
  je end_exchange_proc
  looop_to_si:
  mov al,byte ptr [bx]
  mov [di],al
  inc bx
  inc di
  dec si
  cmp si,0
  jne looop_to_si


end_exchange_proc:
  pop di
  pop si
  pop bx
  pop ax
  pop bp
  ret

endp push_the_rest_of_array
duplicate_the_num proc
push bp
mov bp,sp
push ax
push bx
push cx
push dx
push si
dec bx
mov al , byte ptr[bx+1]
;for(cx,cx>0;cx++)
;{
;  [bx]=ax
;}
dloop1:
  mov [bx],al
  inc bx
  loop dloop1

pop si
pop dx
pop cx
pop bx
pop ax
pop bp
ret

endp duplicate_the_num

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
    inc bx; moving bx to the number of thines to be repeted
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
