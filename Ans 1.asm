.model small
.stack 100h

.data
    arr     db 8, 3, 7, 1, 5   
    n       db 5
    target  db 7
    index   dw -1              

.code
main proc
    mov ax, @data
    mov ds, ax


    mov cl, n
    dec cl

outer_loop:
    mov si, 0
    mov ch, n
    dec ch

inner_loop:
    mov al, arr[si]
    mov bl, arr[si+1]

    cmp al, bl
    jbe no_swap

    ; swap
    mov arr[si], bl
    mov arr[si+1], al

no_swap:
    inc si
    dec ch
    jnz inner_loop

    dec cl
    jnz outer_loop


    mov si, 0
    mov cl, n

search_loop:
    mov al, arr[si]
    cmp al, target
    je found

    inc si
    loop search_loop
    jmp exit

found:
    mov index, si      

exit:
    mov ah, 4Ch
    int 21h

main endp
end main
