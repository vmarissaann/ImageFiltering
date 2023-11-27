%include "io.inc"

section .data
pattern_ctr db 0 ; stores number of times the window moves
matrix_row_ctr db 0
matrix_col_ctr db 0 
window_size db 3 ; 3x3
matrix_size db 6 ; 6x6
increment_row db 0

; window info
window_ctr db 0
window_row_ctr db 0

; temporary matrix
matrix db 1, 4, 0, 1, 3, 1, 2, 2, 4, 2, 2, 3, 1, 0, 1, 0, 1, 0, 1, 2, 1, 0, 2, 2, 2, 5, 3, 1, 2, 5, 1, 1, 4, 2, 3, 0
matrix_new db 1, 4, 0, 1, 3, 1, 2, 2, 4, 2, 2, 3, 1, 0, 1, 0, 1, 0, 1, 2, 1, 0, 2, 2, 2, 5, 3, 1, 2, 5, 1, 1, 4, 2, 3, 0

section .text
global main

main:
    ; initialize matrix row incremement
    MOV EAX, [matrix_size]
    INC EAX
    MOV [increment_row], EAX

    ; initializing registers to be 0
    MOV EAX, 0 ; reserved for division operation
    MOV EBX, 0
    MOV ECX, 0
    MOV EDX, 0

    ; initialize empty counter
    MOV ECX, 0x0

    ; number of 3x3 window moves in a row
    ; aka how many columns are accessed in a row
    ; matrix_size - window_size + 1
    MOV AL, [matrix_size]
    SUB AL, [window_size]
    ADD AL, 1
    MOV [pattern_ctr], AL

    ; initialize loop counter
    MOV CL, [pattern_ctr]

    matrix_row:
        ; stores counter for row of matrix in row_ctr
        MOV [matrix_row_ctr], CL

        ; CL initialized for the loop
        MOV CL, [pattern_ctr]

        matrix_col:
            ; stores counter for column of matrix 
            MOV [matrix_col_ctr], CL

            ; CL initialized for row of window
            MOV CL, [window_size]

            window_row:
                ; temp counter to check if it passes through the column 3 times
                MOV EAX, 0

                ; stores counter for row of matrix 
                MOV [window_row_ctr], CL

                ; CL initialized for column of window loop
                MOV CL, [window_size]

                window_col:
                    ADD EAX, 1 ; should be replaced with an array

                loop window_col
                MOV CL, [window_row_ctr]

            loop window_row
            MOV CL, [matrix_col_ctr]

        loop matrix_col
        MOV CL, [matrix_row_ctr]

    loop matrix_row
    PRINT_DEC 1, EAX

    xor eax, eax
    ret


        