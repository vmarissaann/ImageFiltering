%include "io.inc"
section .data
numerator db 9
denominator db 6
section .text
global main
main:
    MOV EDX, 0
   ; MOV ECX, 0
    MOV AL, [numerator]
    ;MOV CL, [denominator]
    IDIV dword [denominator]
    shl edx, 1
    cmp edx, [denominator]
    jb .done
    add eax, 1
    .done:
    PRINT_DEC 1, eax
    ;write your code here
    xor eax, eax
    ret