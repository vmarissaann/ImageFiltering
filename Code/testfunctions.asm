%include "io.inc"
section .data
matrix_windowsize db 3
matrix_allwindow db 0
windowRowCtr db 0
windowIterate db 0
sampling_window_size dd 9 ;should be depending on C program
;NOTE: should be double word integer
matrix db 1, 4, 0, 1, 3, 1, 2, 2, 4, 2, 2, 3,1, 0, 1, 0, 1, 0, 1, 2, 1, 0, 2, 2, 2, 5, 3, 1, 2, 5, 1, 1, 4, 2, 3, 0
sum db 0

section .text
global main
main:

    ;initializing registers to be 0
    MOV EAX, 0 ; reserved for division operation
    ;MUL
    MOV ECX, 0
    MOV EBX, 0
    MOV EDX, 0
    ;test
    MOV EBX, 1 ;should be 14
    ;MOV EBX, 3 ;should be 13
    ; MOVZX EDX, byte [matrix + EAX]
    MOV CL, [matrix_windowsize]
    window_row:             
                              ;stores the counter for row of matrix in windowRowCtr as CL as initialized for sample window COL loop
                              MOV [windowRowCtr], CL
                              ADD EBX, 2
                              ;CL initialized for COL sample window loop
                              MOV CL, [matrix_windowsize]
                              window_col:
                                         MOVZX EDX, byte [matrix+EBX]
                                         ADD [sum], EDX
                                         SUB EBX,1 ; replace with array kineme later
                              loop window_col
                              ADD EBX, 7
                               ;put back window row counter
                              MOV CL, [windowRowCtr]
                             
    loop window_row
    PRINT_STRING  "Sum: "
    PRINT_DEC 1, sum
    NEWLINE
    
    ;ROUND and AVERAGE function
    ;registers used in division operation: EAX, EDX
    ; move sum value to AL of EAX such that it can be used for division operation
    ; numerator = sum
    ; denominator = sampling_window_size
     MOV AL, [sum]
     MOV EDX, 0
    ; EAX <-- EAX div s32
    ; EDX <-- EDX mod s32
    IDIV dword [sampling_window_size]
    shl edx, 1
    cmp edx, [sampling_window_size]
    jb .done
    add eax, 1
    .done:
    PRINT_STRING  "Average: "
    PRINT_DEC 1, eax ;replace with replacing new array with new value
    
    ;once it iterates through the entire 3x3 window
    
    xor eax, eax
    ret