%include "io.inc"
section .data

patternCtr db 0 ;stores the number of times the window moves
matrixRowCtr db 0 ; stores counter in row
matrixColCtr db 0 ; stores counter in column
matrix_windowsize db 3 ;stores window size (3x3)
matrix_size db 6 ;stores matrix size (6x6)

;matrix operations
increment_row db 0 ;increments row to next matrix row
temp_ebx db 0;temporary holder for ebx keeps track of where the row is in matrix

; for window
windowCtr db 0
windowRowCtr db 0
sampling_window_size db 9 ; 3x3

;operation
sum db 0 ; sum
avg db 0

;temporary matrix, but must be called from C
matrix db 1, 4, 0, 1, 3, 1, 2, 2, 4, 2, 2, 3,1, 0, 1, 0, 1, 0, 1, 2, 1, 0, 2, 2, 2, 5, 3, 1, 2, 5, 1, 1, 4, 2, 3, 0
matrix_new db 1, 4, 0, 1, 3, 1, 2, 2, 4, 2, 2, 3,1, 0, 1, 0, 1, 0, 1, 2, 1, 0, 2, 2, 2, 5, 3, 1, 2, 5, 1, 1, 4, 2, 3, 0



section .text
global main
main:
    ;initializing incrementer for next row in window iteration
    MOV EAX, [matrix_size]
    INC EAX
    MOV [increment_row], EAX
    
    MOV EAX, 0
    MOV EBX, 0
    ;initialize empty counter
    MOV ECX, 0x0
    ; initializes the number of 3x3 window moves
    ; (6 - window_size +1 ) this just the math pattern btw
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
                              ;stores the counter for row of matrix in windowRowCtr as CL as initialized for sample window COL loop
                              MOV [windowRowCtr], CL
                              
                              ;emptying registers for division operation
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
                              ; add 7 to proceed to next row of 3x3 window matrix
                              MOV AL, [increment_row]
                              ADD EBX, EAX
                              ;put back window row counter
                              MOV CL, [windowRowCtr]
                             
                   loop window_row
                   ;put back matrix col counter
                   MOV CL, [matrixColCtr]  
                   MOV AL, [sum]
                   MOV EDX, 0
                ; EAX <-- EAX div s32
                ; EDX <-- EDX mod s32
                IDIV dword [sampling_window_size]
                shl edx, 1
                ;help this is not working starting this part. check out innerlooplogic.asm to see how it works 
                ;its basically the round and avg function but the jmp here is not working
                ;also i got the code lang sa stackoverflow idk how it works HAHAH
                
                ;cmp edx, [sampling_window_size]
                ;jb .done
               ; add eax, 1
                ;.done:
               ; PRINT_STRING  "Average: "
                ;PRINT_DEC 1, eax ;replace with replacing new array with new value
                ;MOV [avg], eax
                ;TO DO: insert logic of replacing the array here
                   
                  
        loop matrix_col
        ; put back the counter for matrix row counter
        MOV CL, [matrixRowCtr]
        
        ;increment counter for matrix row
        MOV AL, [matrix_size]
        ADD [temp_ebx], AL
        MOV BL, [temp_ebx]
    loop matrix_row
    
    
    ;write your code here
    xor eax, eax
    ret