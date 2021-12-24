;NUM         EQU int
data segment
X = 45
A1 Dw 65, 66, 69, 70
A2 Db 2 Dup ('1234', 45*2-56)
A3 Dw X
A4 Dw $
Data Ends
;W1 Dw 399, -210, 1600
;W2 Dw 3 Dup (';!' , 2)
;W3 Db 'ABCDE', -68, 0
;W4 Dw '8', '9', 'C'

;A1 Dw 65, 66, 69, 70
;A2 Dw A1
;A3 Dw 2 Dup ('Ab', 13)
;A4 Dw 4 Dup ('A')

;A1 DB 5 Dup ('AB',78 ) ;A2 Dw A1
;A3 Dw -100, 789, 0Bc56h; bad one
;A4 Dw A2, A2,A3
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
