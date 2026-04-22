          ; ================================
; Basic Text Editor in 8086
; Saves input text to OUTPUT.TXT
; ESC key ends input
; ================================

.MODEL SMALL
.STACK 100h

.DATA
    buffer      DB 1000 DUP(?)     ; text buffer
    buf_len     DW 0               ; number of characters entered
    filename    DB "OUTPUT.TXT",0
    msg_saved   DB 13,10,"Text saved successfully.$"

.CODE
MAIN PROC
    ; initialize data segment
    MOV AX, @DATA
    MOV DS, AX

    ; SI will point to buffer
    LEA SI, buffer

INPUT_LOOP:
    ; read character from keyboard
    MOV AH, 01h
    INT 21h          ; AL = character

    ; check for ESC key
    CMP AL, 27       ; ESC ASCII = 27
    JE SAVE_FILE

    ; check for Enter key
    CMP AL, 13       ; Enter ASCII = 13
    JNE STORE_CHAR

    ; store CR
    MOV [SI], AL
    INC SI
    INC buf_len

    ; store LF
    MOV AL, 10
    MOV [SI], AL
    INC SI
    INC buf_len
    JMP INPUT_LOOP

STORE_CHAR:
    ; store typed character
    MOV [SI], AL
    INC SI
    INC buf_len
    JMP INPUT_LOOP

SAVE_FILE:
    ; create file
    MOV AH, 3Ch
    MOV CX, 0
    LEA DX, filename
    INT 21h
    MOV BX, AX       ; file handle

    ; write buffer to file
    MOV AH, 40h
    MOV CX, buf_len
    LEA DX, buffer
    INT 21h

    ; close file
    MOV AH, 3Eh
    INT 21h

    ; display confirmation message
    MOV AH, 09h
    LEA DX, msg_saved
    INT 21h

    ; exit program
    MOV AH, 4Ch
    INT 21h

MAIN ENDP
END MAIN
