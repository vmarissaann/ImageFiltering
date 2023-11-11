%include "io.inc"
section .data
numerator db 5
denominator db 2
section .text
global main
main:
    MOV EDX, 0
    MOV ECX, 0
    MOV AL, [numerator]
    MOV CL, [denominator]
    DIV ECX
    shl edx, 1
    cmp edx, ecx
    jb .done
    add eax, 1
    .done:
    PRINT_DEC 1, eax
    ;write your code here
    xor eax, eax
    ret