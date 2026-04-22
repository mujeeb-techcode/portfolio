.MODEL SMALL
.STACK 100h

.DATA
array DB 12,4,8,20,10
n DB 5

.CODE
MAIN PROC
    MOV AX,@DATA
    MOV DS,AX
    CALL SORT
    MOV AH,4Ch
    INT 21h
MAIN ENDP

SORT PROC
    MOV CL,n
    DEC CL
O2:
    MOV SI,0
    MOV CH,CL
I2:
    MOV AL,array[SI]
    CMP AL,array[SI+1]
    JAE N2
    XCHG AL,array[SI+1]
    MOV array[SI],AL
N2:
    INC SI
    DEC CH
    JNZ I2
    DEC CL
    JNZ O2
    RET
SORT ENDP
END MAIN
