       .model small
.stack 100h

.data
msg1 db 'Enter 5 numbers: $'
msg2 db 0Dh,0Ah,'Enter number to search: $'
msg3 db 0Dh,0Ah,'Found at index: $'
msg4 db 0Dh,0Ah,'Not found$'

arr db 5 dup(?)
key db ?
index db 1

.code
main proc
    mov ax,@data
    mov ds,ax

    ; Input array
    lea dx,msg1
    mov ah,09h
    int 21h

    lea si,arr
    mov cx,5
input:
    mov ah,01h
    int 21h
    mov [si],al
    inc si
    loop input

    ; Input search number
    lea dx,msg2
    mov ah,09h
    int 21h

    mov ah,01h
    int 21h
    mov key,al

    ; Linear Search
    lea si,arr
    mov cx,5
    mov index,1

search:
    mov al,[si]
    cmp al,key
    je found
    inc si
    inc index
    loop search

    ; Not found
    lea dx,msg4
    mov ah,09h
    int 21h
    jmp exit

found:
    lea dx,msg3
    mov ah,09h
    int 21h

    mov al,index
    add al,30h
    mov dl,al
    mov ah,02h
    int 21h

exit:
    mov ah,4Ch
    int 21h
main endp
end main
