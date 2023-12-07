%include "io.inc"

section .data

; window info
window_size dd 3
window_ctr db 0
window_row_ctr db 0 
sampling_window_size db 0
move_window dd 0
margin db 0
temp db 0

; sum and average
sum dd 0 
avg db 0
temp_ebx db 0
holder_ebx db 0
pattern_ctr db 0 ; stores number of times the window moves

; matrix info
matrix_size_x db 7
matrix_size_y db 4
increment_row db 0
matrix_row_ctr db 0
matrix_col_ctr db 0 
matrix_row_max db 0
matrix_col_max db 0

matrix db 1,1,1,1,1,1,1,1,8,8,8,8,8,1,1,8,8,8,8,8,1,1,1,1,1,1,1,1
new_matrix db 1,1,1,1,1,1,1,1,8,8,8,8,8,1,1,8,8,8,8,8,1,1,1,1,1,1,1,1

section .text
global main

main:
    mov ebp, esp; for correct debugging
    ;margin
    MOV EAX, [window_size]
    MOV EDX, 0
    MOV EBX, 2
    IDIV EBX ; 3/2 = 1 margin on all sides
    
    MOV byte[margin], AL
    
    ; initialize matrix row incremement
    MOV EAX, [matrix_size_x]
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
    MOV AL, [matrix_size_y]
    SUB AL, [window_size]
    ADD AL, 1
    ;MOV [pattern_ctr], AL ; 6 - 3 + 1 = 4

    ; initialize matrix row counter
    MOV [matrix_row_ctr], AL
    MOV [matrix_row_max], AL
    
    
    ;MOV [pattern_ctr], AL ; 6 - 3 + 1 = 4
    
    matrix_row: ; loops 4 times
    
        ; CL initialized for the loop
        ;MOV AL, [pattern_ctr]
        MOV AL, [matrix_size_x]
        SUB AL, [window_size]
        ADD AL, 1
        MOV [matrix_col_ctr], AL
        MOV [matrix_col_max], AL
        
        ; initialize row 0 -> 6 -> 12..etc
        MOV AL, [temp_ebx]
        ADD [holder_ebx], AL

        matrix_col: ; loops 4 times
        
            ; CL initialized for row of window
            MOV CL, [window_size]
            
            ; iterates from each col backwards
            ; window_size - 1
            MOV EAX, [window_size] 
            SUB EAX, 1
            MOV [move_window], EAX ; 3 - 1 = 2
            
           ;moves starting index of window array to BL 0 ->1-->2 -->3
            MOV BL, [holder_ebx]; ; holds address of start of sample window
            
            window_row:
                ; stores counter for row (3)
                MOV [window_row_ctr], CL
                
                ADD EBX, [move_window]; move through the sample window 2 1 0 2 1 0 2 1 0
       
                ; CL initialized for column of window loop
                MOV CL, [window_size]

                window_col:                    
                    ; move values of array into EDX
                    ; EDX represents an element in the window
                    MOVZX EDX, byte [matrix+EBX]
        
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
            
            ; sum
            PRINT_STRING  "Sum: "
            PRINT_UDEC 4, sum
            
            ; get the average and round up
            ; EAX and EDX are used in division operation
            ; move sum value to AL of EAX
            MOV EAX, [sum]
            MOV EDX, 0
        
            ; calculate sampling window size
            MOV EBX, [window_size]
            IMUL EBX, EBX
            MOV [sampling_window_size], EBX ; 3 x 3 = 9
        
            IDIV dword [sampling_window_size]
            SHL EDX, 1 ; remainder divided by 2
            CMP EDX, [sampling_window_size] ; rounding mechanism
            JB .done
            ADD EAX, 1
            
            .done:
                NEWLINE
                PRINT_STRING  "Average: "
                PRINT_DEC 1, EAX 
                NEWLINE
                
                PUSH EAX
                PUSH EBX
                PUSH EDX
                
                
                
                MOV AL, [matrix_row_max]
                MOV BL, [matrix_row_ctr]
                SUB AL, BL
                PUSH EAX
                                
                MOV AL, [matrix_col_max]
                MOV BL, [matrix_col_ctr]
                SUB AL, BL
                MOV BL, AL
                POP EAX
                
                ADD AL, [margin]
                ADD BL, [margin]
                
                PRINT_DEC 1, AL ; Y
                NEWLINE
                PRINT_DEC 1, BL ; X
                NEWLINE

                ; AL * matrix_size_x * 4
                ; BL * 4
                
                PUSH EBX
                MOV BL, [matrix_size_x]
                MUL BL
                POP EBX
                ADD AL, BL
                
                ;MOV AL, [new_matrix + EAX]
                MOV byte [temp], AL

                POP EDX
                POP EBX
                POP EAX
                MOV BL, [temp]
                MOV byte [new_matrix + EBX], AL
                PRINT_DEC 1, [new_matrix + EBX]
                NEWLINE
                ; reset to 0
                MOV AL, 0
                MOV [sum], EAX
                
            MOV CL, [matrix_col_ctr]
            
        MOV AL, [holder_ebx]
        INC AL
        MOV [holder_ebx], AL
        
        ; jump to matrix col
        MOV AL, [matrix_col_ctr]
        SUB AL, 1
        MOV [matrix_col_ctr], AL
        CMP EAX, 0
        JNZ matrix_col
        
        ;initialize holder ebx to be 0 again to start with array 0 in window 3x3
        MOV AL, 0
        MOV [holder_ebx], AL
        
        ;increment for next row in 6x6 matrix
        MOV AL, [matrix_size_x]
        ADD [temp_ebx], AL
        MOV BL, [temp_ebx]
        
        MOV CL, [matrix_row_ctr]
    
    ; jump to matrix row
    MOV AL, [matrix_row_ctr]
    SUB AL, 1
    MOV [matrix_row_ctr], AL
    CMP EAX, 0
    JNZ matrix_row
    
    ; Print the updated matrix
    PRINT_STRING  "Updated Matrix: "
    NEWLINE
    
    MOV EAX, 0
    MOV EBX, new_matrix
    MOV ECX, 7
    MOV EDX, 4
    
    L2:
        MOV ECX, 7
        L1:
            PRINT_UDEC 1, [EBX+EAX]
            PRINT_STRING " "
            ADD EAX, 1
            DEC ECX
            
            CMP ECX, 0
            JNZ L1
            
        NEWLINE
        
        DEC EDX
        CMP EDX, 0
        JNZ L2
    
    xor eax, eax
    ret