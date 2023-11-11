%include "io.inc"
section .data
matrix_windowsize db 3
windowRowCtr db 0
windowIterate db 0
matrix db 1, 4, 0, 1, 3, 1, 2, 2, 4, 2, 2, 3,1, 0, 1, 0, 1, 0, 1, 2, 1, 0, 2, 2, 2, 5, 3, 1, 2, 5, 1, 1, 4, 2, 3, 0
sum db 0
section .text
global main
main:
    ;write your code here
    MOV ECX, 0
    MOV EAX, 0
    MOV EDX, 0
    ;test
    MOV EAX, 1 ;should be 14
    MOV EAX, 3 ;should be 13
    ; MOVZX EDX, byte [matrix + EAX]
    MOV CL, [matrix_windowsize]
    window_row:             
                              ;stores the counter for row of matrix in windowRowCtr as CL as initialized for sample window COL loop
                              MOV [windowRowCtr], CL
                              ADD EAX, 2
                              ;CL initialized for COL sample window loop
                              MOV CL, [matrix_windowsize]
                              window_col:
                                         MOVZX EDX, byte [matrix+eax]
                                         ADD [sum], EDX
                                         SUB EAX,1 ; replace with array kineme later
                              loop window_col
                              ADD EAX, 7
                               ;put back window row counter
                              MOV CL, [windowRowCtr]
                             
    loop window_row
    PRINT_DEC 1, sum
  
   ; PRINT_DEC 1, [matrix+1]
    ;NEWLINE
    
    xor eax, eax
    ret