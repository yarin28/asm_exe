dseg segment
a db 1
b db 2
c db 3
d db 4
dseg ends

cseg segment
     assume cs:cseg,ds:dseg

start:  mov ax,dseg
        mov ds,ax

    Mov  Ah, 4ch
    Int  21h
;if (a > b) { tmp = a; a = b; b = tmp; }
    mov al,[a]
    mov ah,[b]
    cmp al,ah
    jg a_g_b
    jmp after_a_g_b
  a_g_b:
    ; did it for simplicity sake
    xchg al,ah
    mov [a],al
    mov [b],ah
  after_a_g_b:
;if (c > d) { tmp = c; c = d; d = tmp; }
    mov al,[c]
    mov ah,[d]
    cmp al,ah
    jg c_g_d
    jmp after_c_g_d
  c_g_d:
    mov [c],ah
    mov [d],al
  after_c_g_d:
;if (a > c) { tmp = a; a = c; c = tmp; }
    mov al,[a]
    mov ah,[c]
    cmp al,ah
    jg a_g_c
    jmp after_a_g_c
  a_g_c:
    mov [a],ah
    mov [c],al
  after_a_g_c:
;if (b > d) { tmp = b; b = d; d = tmp; }
    mov al,[b]
    mov ah,[d]
    cmp al,ah
    jg b_g_d
    jmp after_b_g_d
  b_g_d:
    mov [b],ah
    mov [d],al
  after_b_g_d:
;if (b > c) { tmp = b; b = c; c = tmp; }
    mov al,[b]
    mov ah,[c]
    cmp al,ah
    jg b_g_c
    jmp after_b_g_c
  b_g_c:
    mov [b],ah
    mov [c],al
  after_b_g_c:



cseg ends
end start

;int tmp;
;if (a > b) { tmp = a; a = b; b = tmp; }
;if (c > d) { tmp = c; c = d; d = tmp; }
;if (a > c) { tmp = a; a = c; c = tmp; }
;if (b > d) { tmp = b; b = d; d = tmp; }
;if (b > c) { tmp = b; b = c; c = tmp; }
; found this online will try to implement.
