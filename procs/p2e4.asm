CODE SEGMENT
    ASSUME CS:CODE
      T DB LEN-1,-10,2,35,-5,70
         LEN=$-T
      P DW SOF,T
  FIRST: 
            POP SI
          ; MOV SI,P                ;(1)
MOV BP,SP
SUB SP,LEN-1
Mov DI,0
MOV CX,DI
MOV BX,[BP]
MOV CL,[BX]
INC BX
FI_AG:      MOV AL,[BX]
Cmp AL,0
JGE GO
NEG AL
GO: 		MOV [BP-(LEN-1)+DI],AL
INC DI
INC BX
LOOP FI_AG
JMP SI
SECOND: 
      	PUSH BP
MOV BP,SP
MOV CX,LEN-1
Mov DI,0
Mov AL,0
SHOOV: 	ADD AL,[BP+4+DI]
INC DI
LOOP SHOOV
POP BP
RET LEN-1                 ;(2)
START:
 PUSH CS
 POP  DS
 PUSH P+2
       CALL FIRST
       CALL SECOND
SOF: 
       MOV AH,4CH
       INT 21H
CODE ENDS
END START
