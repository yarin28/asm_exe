Data Segment
X1 db 0
X2 db -1
X3 db 0fdh
X4 db 0aah
X5 db -100
X6 db 64h
Map dw 0ffh
Data Ends
Code Segment
Assume Cs:Code, Ds:Data
Zzzz:
    Mov Ax,Data
    Mov Ds,Ax
    Mov Ax,Map
    Mov Bl,X4
    Cmp X3,Bl
    Jl M1
    Add Ax,1b
M1:
    Cmp Bl,X3
    Jb M2
    Add Ax,11b
M2:
    Mov Bl,X3
    Sub X6,Bl
    Je M3
    Add Ax,111b
M3:
    Mov Bl,X5
    Sub Bl,X4
    Ja M4
    Add Ax,1111b
M4:
    Mov Ch,X1
    Cmp X2,Ch
    Jle M5
    Add Ax,11111b
M5:
    Cmp Bl,X4
    Jbe M6
    Add Ax,101010b
M6:
    Mov Bl,X5
    Neg Bl
    Mov X2,Bl
    Jg M7
    Add Ax,10101011b
M7: Mov Map,Ax
    Mov Ax,4C00h; exits the program
    Int 21h
Code Ends
End Zzzz
