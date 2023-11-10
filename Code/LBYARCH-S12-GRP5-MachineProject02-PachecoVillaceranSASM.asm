%include "io.inc"
section .data
patternCtr db 0
matrix_windowsize db 3
matrix_size db 6

section .text
global main
main:
    ; initializes the number of 3x3 window moves
    MOV AL, [matrix_size]
    SUB AL, [matrix_windowsize]
    ADD EAX, 1
    MOV [patternCtr], EAX
    
    
    
    ;division
   ; mov eax, 2296         ; dividend low half
   ; mov edx, 0             ; dividend high half = 0.  prefer  xor edx,edx

   ; mov ebx, 9            ; divisor can be any register or memory

;div ebx  
    
    ;write your code here
    xor eax, eax
    ret