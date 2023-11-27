%include "io.inc"
section .data
matrix_windowsize db 3 ; window dimension such that 3x3
windowRowCtr db 0 ; counter for window row
sampling_window_size dd 9 ;should be depending on C program
;NOTE: should be double word integer
matrix db 1, 4, 0, 1, 3, 1, 2, 2, 4, 2, 2, 3,1, 0, 1, 0, 1, 0, 1, 2, 1, 0, 2, 2, 2, 5, 3, 1, 2, 5, 1, 1, 4, 2, 3, 0
sum db 0 ; sum
matrix_size db 6 ; size of matrix ( 6x6 ), but should be depending on input in C
increment_row db 0 ;incrementer for next row
avg db 0

section .text
global main
main:
    ;initializing incrementer for next row
    MOV EAX, [matrix_size]
    INC EAX
    MOV [increment_row], EAX
    ;initializing registers to be 0
    MOV EAX, 0 ; reserved for division operation
    MOV ECX, 0
    MOV EBX, -1
    MOV EDX, 0
    ;Testing moving of array
    INC EBX
        ;MOV EBX, 1 ;should be 14
        ;MOV EBX, 3 ;should be 13
    MOV CL, [matrix_windowsize]
    window_row:             
                              ;stores the counter for row of matrix in windowRowCtr as CL as initialized for sample window COL loop
                              MOV [windowRowCtr], CL
                              ; iterates through entire row starting from row 2 -> row 1 - > row 0, hence EBX +2
                              ADD EBX, 2
                              ;CL initialized for COL sample window loop
                              MOV CL, [matrix_windowsize]
                              window_col:
                                         ; moves value of array into EDX
                                         MOVZX EDX, byte [matrix+EBX]
                                         ; EDX is added into sum container
                                         ADD [sum], EDX
                                         ;subtract such that row row 2 -> row 1 - > row 0
                                         SUB EBX,1 
                              loop window_col
                              ADD EBX, [increment_row] ; add 7 to proceed to next row of 3x3 window matrix
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
        MOV [avg], eax
        ; average should have these outputs: 
       
    
    ;once it iterates through the entire 3x3 window
    
    xor eax, eax
    ret