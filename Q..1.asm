.model small
.stack 100h

.data
arr     db 5 dup(?)
n       db 5
target  db ?
index   dw -1

.code
main proc
    mov ax, @data
    mov ds, ax

    mov si, 0
    mov cx, 5

in1:
    mov ah, 01h
    int 21h
    sub al, 30h
    mov arr[si], al
    inc si
    loop in1

    mov ah, 01h
    int 21h
    sub al, 30h
    mov target, al

    mov cl, n
    dec cl

o1:
    mov si, 0
    mov ch, n
    dec ch

i1:
    mov al, arr[si]
    mov bl, arr[si+1]
    cmp al, bl
    jbe ns1
    mov arr[si], bl
    mov arr[si+1], al
ns1:
    inc si
    dec ch
    jnz i1
    dec cl
    jnz o1

    mov si, 0
    mov cl, n

s1:
    mov al, arr[si]
    cmp al, target
    je f1
    inc si
    loop s1
    jmp e1

f1:
    mov index, si

e1:
    mov ah, 4Ch
    int 21h
main endp
end main
