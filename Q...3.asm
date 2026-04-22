         .model small
.stack 100h

.data
num db ?
res dw ?

.code
main proc
    mov ax, @data
    mov ds, ax

    mov ah, 01h
    int 21h
    sub al, 30h
    mov num, al

    mov al, num
    cbw
    push ax
    call fact
    mov res, ax

    mov ah, 4Ch
    int 21h
main endp

fact proc
    pop bx
    pop ax
    cmp ax, 1
    jbe base
    dec ax
    push ax
    push bx
    call fact
    mul byte ptr [num]
    ret

base:
    mov ax, 1
    ret
fact endp

end main
