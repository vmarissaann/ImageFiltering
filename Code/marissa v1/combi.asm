%include "io.inc"

section .data

; window info
window_size dd 3
window_ctr dd 0
window_row_ctr dd 0 
sampling_window_size dd 0
move_window dd 0

; sum and average
sum dd 0 
avg dd 0
temp_ebx dd 0
holder_ebx dd 0
mul_temp dd 0
pattern_ctr dd 0 ; stores number of times the window moves

; matrix info
matrix_size dd 6 
increment_row dd 0
matrix_row_ctr dd 0
matrix_col_ctr dd 0 

; temporary matrix
; matrix db 2, 5, 2, 1, 3, 1, 3, 6, 4, 2, 2, 3, 1, 2, 1, 0, 1, 0, 1, 2, 1, 0, 2, 2, 2, 5, 3, 1, 2, 5, 1, 1, 4, 2, 3, 0
matrix dd 1, 4, 0, 1, 3, 1, 2, 2, 4, 2, 2, 3, 1, 0, 1, 0, 1, 0, 1, 2, 1, 0, 2, 2, 2, 5, 3, 1, 2, 5, 1, 1, 4, 2, 3, 0

section .text
global main

main:
    ;PRINT_DEC 4, [matrix+8]
    ; initialize matrix row incremement
    MOV EAX, [matrix_size]
    INC EAX
    MOV [increment_row], AL

    ; initializing registers to be 0
    MOV EAX, 0 ; reserved for division operation
    MOV EBX, 0
    
    ; initialize empty counter
    MOV ECX, 0x0

    ; number of 3x3 window moves in a row
    ; aka how many columns are accessed in a row
    ; matrix_size - window_size + 1
    MOV AL, [matrix_size]
    SUB AL, [window_size]
    ADD AL, 1
    MOV [pattern_ctr], AL

    ; initialize matrix row counter
    MOV [matrix_row_ctr], AL
    

    matrix_row:
        ; CL initialized for the loop
        MOV AL, [pattern_ctr]
        MOV [matrix_col_ctr], AL
        
        ;initialize row 0 -> 6 ->12..etc
        MOV AL, [temp_ebx]
        ADD [holder_ebx], AL

        matrix_col:
       
            ; CL initialized for row of window
            MOV CL, [window_size]
            
            ; iterates from each col backwards
            ; window_size - 1
            MOV EAX, [window_size]
            SUB EAX, 1
            MOV [move_window], EAX
            
           ;moves starting index of window array to BL 0 ->1-->2 -->3
            MOV BL, [holder_ebx]
            
            window_row:
                ; stores counter for row (3)
                MOV [window_row_ctr], CL
                
                ADD EBX, [move_window]
       
                ; CL initialized for column of window loop
                MOV CL, [window_size]

                window_col:                    
                    ; move values of array into EDX
                    ; EDX represents an element in the window
                    MOV [mul_temp],EBX
                    IMUL EBX, 4
                    MOV EDX, [matrix+EBX]
                    MOV EBX, [mul_temp]
        
                    ; EDX is added into the sum
                    ADD [sum], EDX
                    ; Subtract to move to next element
                    SUB EBX, 1 

                loop window_col
                
                ; move to next row on the window
                MOV AL, [increment_row]
                ADD EBX, EAX
                ; reset window row counter
                MOV CL, [window_row_ctr]

            loop window_row
            
            ; TODO: find what is affecting the sum, it should be 15
            PRINT_STRING  "Sum: "
            PRINT_DEC 1, sum
            
            ; get the average and round up
            ; EAX and EDX are used in division operation
            ; move sum value to AL of EAX
            MOV AL, [sum]
            MOV EDX, 0
        
            ; calculate sampling window size
            MOV EBX, [window_size]
            IMUL EBX, EBX
            MOV [sampling_window_size], EBX
        
            IDIV dword [sampling_window_size]
            SHL EDX, 1
            CMP EDX, [sampling_window_size]
            JB .done
            ADD EAX, 1
            
            .done:
                NEWLINE
                PRINT_STRING  "Average: "
                PRINT_DEC 1, EAX 
                NEWLINE
                NEWLINE
                MOV [avg], BL
                ; TODO: need to reset sum to 0 somewhere here (DONE)
                MOV AL,0
                MOV [sum], AL
                
            MOV CL, [matrix_col_ctr]
        MOV AL, [holder_ebx]
        INC AL
        MOV [holder_ebx], AL
        
        ; TODO: change this so that it loops accordingly
        ; this is a placeholder to test if the problem was the range
        ; it was the range lol so we need to rework it with a jump
        MOV AL, [matrix_col_ctr]
        SUB AL, 1
        MOV [matrix_col_ctr], AL
        CMP EAX, 0
        JNZ matrix_col
        
        ;initialize holder ebx to be 0 again to start with array 0 in window 3x3
        MOV AL, 0
        MOV [holder_ebx],AL
        
        ;increment for next row in 6x6 matrix
        MOV AL, [matrix_size]
        ADD [temp_ebx], AL
        MOV BL, [temp_ebx]
        
        MOV CL, [matrix_row_ctr]
    
    ; TODO: change this so that it loops accordingly
    ; this is a placeholder to test if the problem was the range
    ; it was the range lol so we need to rework it with a jump
    MOV AL, [matrix_row_ctr]
    SUB AL, 1
    MOV [matrix_row_ctr], AL
    CMP EAX, 0
    JNZ matrix_row
    
    xor eax, eax
    ret