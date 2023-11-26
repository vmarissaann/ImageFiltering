%include "io.inc"
section .data

patternCtr db 0
matrixRowCtr db 0
matrixColCtr db 0
matrix_windowsize db 3
matrix_size db 6

; for window
windowCtr db 0
windowRowCtr db 0

;temporary matrix, but must be called from C
matrix db 1, 4, 0, 1, 3, 1, 2, 2, 4, 2, 2, 3,1, 0, 1, 0, 1, 0, 1, 2, 1, 0, 2, 2, 2, 5, 3, 1, 2, 5, 1, 1, 4, 2, 3, 0
matrix_new db 1, 4, 0, 1, 3, 1, 2, 2, 4, 2, 2, 3,1, 0, 1, 0, 1, 0, 1, 2, 1, 0, 2, 2, 2, 5, 3, 1, 2, 5, 1, 1, 4, 2, 3, 0



section .text
global main
main:
    MOV EAX, 0
    
    ;initialize empty counter
    MOV ECX, 0x0
    ; initializes the number of 3x3 window moves
    ; (6 - window_size +1 )
    MOV AL, [matrix_size]
    SUB AL, [matrix_windowsize]
    ADD AL, 1
    MOV [patternCtr], AL
    
    ; initialize loop counter
    MOV CL, [patternCtr]
    
    matrix_row: 
        ;stores the counter for row of matrix in rowCtr as ECX is initialized for matrix column loop
        MOV [matrixRowCtr], CL
        
        ;CL initialized for matrix column loop
        MOV CL, [patternCtr]
        matrix_col: 
                   ;stores the counter for column  of matrix in colCtr as CL as initialized for sample window ROW loop
                   MOV [matrixColCtr], CL
                   
                   ;CL initialized for ROW sample window loop
                   MOV CL, [matrix_windowsize]
                   window_row: 
                               ;temporary counter just to check if it passes through window_col 3 times
                              MOV EAX, 0
                              ;stores the counter for row of matrix in windowRowCtr as CL as initialized for sample window COL loop
                              MOV [windowRowCtr], CL
                              ;CL initialized for COL sample window loop
                              MOV CL, [matrix_windowsize]
                              window_col:
                                         ADD EAX,1 ; replace with array kineme later
                              loop window_col
                               ;put back window row counter
                              MOV CL, [windowRowCtr]
                             
                   loop window_row
                   ;put back matrix col counter
                   MOV CL, [matrixColCtr]   
                 
                  
        loop matrix_col
        ; put back the counter for matrix row counter
        MOV CL, [matrixRowCtr]
    loop matrix_row
    ;PRINT_DEC 1, EAX
    
    
    
    ;write your code here
    xor eax, eax
    ret