%include "io.inc"
section .data
patternCtr db 0
rowCtr db 0
matrix_windowsize db 3
matrix_size db 6
;temporary matrix, but must be called from C
matrix db 1, 4, 0, 1, 3, 1, 2, 2, 4, 2, 2, 3,1, 0, 1, 0, 1, 0, 1, 2, 1, 0, 2, 2, 2, 5, 3, 1, 2, 5, 1, 1, 4, 2, 3, 0

section .bss
matrix_new resb 36 ;Reserve 36 bytes for matrix_new


section .text
global main
main:
    ; initializes the number of 3x3 window moves
    ; (6 - window_size +1 )
    MOV AL, [matrix_size]
    SUB AL, [matrix_windowsize]
    ADD EAX, 1
    MOV [patternCtr], EAX
    
    ; temporary counter
    MOV EAX, 0
    ; initialize loop counter
    MOV ECX, [patternCtr]
    row: ADD EAX, 1 ;replace with arrays moving
        MOV [rowCtr], ECX
        MOV CL, [patternCtr]
        SUB CL, 1
        
        col: ADD EAX,1 ;replace with arrays moving
        loop col
        MOV ECX, [rowCtr]
    loop row
    PRINT_DEC 1, EAX
    
    
    
    
    ;division
   ; mov eax, 2296         ; dividend low half
   ; mov edx, 0             ; dividend high half = 0.  prefer  xor edx,edx

   ; mov ebx, 9            ; divisor can be any register or memory

;div ebx  
    
    ;write your code here
    xor eax, eax
    ret