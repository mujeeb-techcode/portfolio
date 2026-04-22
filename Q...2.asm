.model small
.stack 100h

.data
arr db 5 dup(?)

.code
main proc
    mov ax, @data
    mov ds, ax

    mov si, 0
    mov cx, 5

in2:
    mov ah, 01h
    int 21h
    sub al, 30h
    mov arr[si], al
    inc si
    loop in2

    call sortdesc

    mov ah, 4Ch
    int 21h
main endp

sortdesc proc
    mov cl, 5
    dec cl

o2:
    mov si, 0
    mov ch, 5
    dec ch

i2:
    mov al, arr[si]
    mov bl, arr[si+1]
    cmp al, bl
    jae ns2
    mov arr[si], bl
    mov arr[si+1], al
ns2:
    inc si
    dec ch
    jnz i2
    dec cl
    jnz o2
    ret
sortdesc endp

end main
