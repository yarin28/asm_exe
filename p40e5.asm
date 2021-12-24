;page 40 exe 5
;NOTE-> there is a problem that i dont want to fix:
;    the array must be in the start of the datasegment!
; the program will check if the array is a polindrom and will return the size
;of the polindorm, for example in this arr the size will be 3.
;c code
;""" c
;int i=length_of_array
;j = length_of_array/2-1;
;for(i=length_of_array/2,i<length_of_array;i++)
;{
;  if(arr[i]==arr[j])
;  {
;    lev++;
;    if (lav_max<lev)
;    {
;      lev_max=lev
;    }
;    else
;    {
;      lev=0
;    }
;  }
;  i++;
;  j++;
;}
;end_lev = lev;
;
;"""
;LOCALS @@; this if for the local labels
data segment
arr db 3,24,4,2,9,67,0,1,67,9,2,19,24,3
len dw $-arr
lev dw 0
ends
stack segment
db 256 dup(0)
ends

code segment
  assume ds:data
  assume cs:code

 ; will just compare the to addresess that was passed by the stack!
 ; will return the result with ax
 check_is_equal proc
  push bp
  mov bp,sp
  xor ax,ax
  push bx
  push di
  push si
  mov di,[ bp+4 ]
  mov si,[ bp+6 ]
  mov bh,byte ptr [di]
  mov bl,[si]
  cmp bh,bl
  jne cisnt_equal
  inc ax
  cisnt_equal:
  pop si
  pop di
  pop bx
  pop bp
  ret 4
 endp check_is_equal
 xor_everything proc
  xor ax,ax
  xor bx,bx
  xor cx,cx
  xor dx,dx
  xor si,si
  xor di,di
  ret

endp xor_everything
start:
    mov ax, data
    mov ds, ax
    call xor_everything
    ;j=length_of_array
    add bx,[ len ]
    shr bl ,1
    mov di,bx
    ;i=length_of_array
    mov si,di
    dec di
    lea bx,arr
    cmp si,[len]
    loop1:
    je xend_loop
    push di
    push  si
    call check_is_equal
    cmp ax,1; true or false, 1=> true
    je xis_equal
    xisnt_equal:; dx is used as the current count of polindrom the variable
    ;is used as the "max"
    xor dx,dx
    jmp xend_first_if
    xis_equal:
    inc dx
    push ax
    mov ax,[lev]
    cmp dx,ax
    pop ax
    jl xend_first_if
    mov [lev],dx
    xend_first_if:
    dec di
    inc si
    jmp loop1
  xend_loop:

  exit:
    mov ax, 4c00h ; exit to operating system.
    int 21h
ends

end start ; set entry point and stop the assembler.
