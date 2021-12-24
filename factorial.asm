; multi-segment executable file template.

MyData segment
    N    dw    8        
    Res  dw    ?
ends

stack segment
    dw   128  dup(0)
ends

code segment
    assume  cs:code, ds:mydata
start:  
     mov   ax, mydata
     mov   ds, ax
     
     ;  res=1
     ;  for(i=2; i<=n; i++)
     ;    res *= i 
     
     ;  res=1
     ;  for(i=2; i<=n; i++) 
     ;     temp=0
     ;     for(j=1; j<=i; j++)
     ;        temp = temp + res   
     ;     res = temp
      
     mov  res, 1 
     mov  cx, 2
For1:
         Cmp  Cx,N
         Ja  End_For
            ; res = res*cx= 0+res+res+ .... + res  cx times
            mov  ax, 0   
            mov  dx, 1
    For2:  
           Cmp  dx, cx
           Ja  End_For2
           add  ax, res
           Inc  dx
           Jmp  For2 
    End_For2:  
              mov  res, ax
              Inc  Cx
              Jmp  For1
End_For:


    mov ax, 4c00h ; exit to operating system.
    int 21h    
ends

end start ; set entry point and stop the assembler.
