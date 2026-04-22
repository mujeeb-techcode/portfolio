.model small
.stack 100h

.data
prompt db 'Input a String: $'
result db 0Dh,0Ah,'Sorted Array is: $'
arr db 5 dup(?)

.code
main proc
    mov ax,@data
    mov ds,ax

    ; Input prompt
    lea dx,prompt
    mov ah,09h
    int 21h

    ; Read 5 digits
    lea si,arr
    mov cx,5
read:
    mov ah,01h
    int 21h
    mov [si],al
    inc si
    loop read

    ; Bubble Sort
    mov cx,4
outer:
    lea si,arr
    mov bx,cx
inner:
    mov al,[si]
    mov dl,[si+1]
    cmp al,dl
    jbe noswap
    mov [si],dl
    mov [si+1],al
noswap:
    inc si
    dec bx
    jnz inner
    dec cx
    jnz outer

    ; Display result
    lea dx,result
    mov ah,09h
    int 21h

    lea dx,arr
    mov ah,09h
    int 21h

    mov ah,4Ch
    int 21h
main endp
end main
