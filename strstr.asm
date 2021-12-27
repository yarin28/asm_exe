Null  = -1 ; 0ffffh

data segment
    ; add your data here!
    Str1  db 'shalom abc 123 abc',0
	     ;Len1 = $-Str1
    Str2  db 'abc',0
	     ;Len2 = $-Str2
	Mes1  Db 'Found$'
	Mes2  Db 'Not Found$'
ends
ends

stack segment
    dw   128  dup(0)
ends

code segment
      assume cs:code, ds:data
;----------------------------------
Strstr Proc
       push bp
       Mov Bp, Sp
			 push bx
			 push cx
			 push si
			 push dx
			 mov bx,[bp+6]
			 mov si,[bp+4]
			 loop1:
			 cmp [bx],0
			 je cant_find
				loop2:
				cmp [si],0
				je found
				mov dl,byte ptr [si]
				cmp dl,byte ptr [bx]
				jne continue_loop_1
				inc si
				inc bx
				jmp loop2
				continue_loop_1:
				inc bx
				mov si,[bp+4]
				jmp loop1
			 found:
			 mov ax,bx
			 jmp sof
			 cant_find:
			 mov ax,0
			 sof:
			 pop dx
			 pop si
			 pop cx
			 pop bx
       pop  bp
	   Ret  4
Strstr EndP
;----------------------------------
start:
; set segment registers:
    mov ax, data
    mov ds, ax
    ; ax = strstr(str1,str2)
	; if ( ax )
	;    puts("Found");
	; else
	;    puts("Not Found");
    push offset str1; i reversed this
    push offset str2
    call Strstr
	cmp  ax, Null
	jne  Found1
	lea  dx, Mes2
	mov  ah, 9
	int  21h
	jmp  sof1
Found1:
	lea  dx, Mes1
	mov  ah, 9
	int  21h
 sof1:
    mov ax, 4c00h ; exit to operating system.
    int 21h
ends

end start ; set entry point and stop the assembler.
