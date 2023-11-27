%include "io.inc"

section .data
; input array
; matrix db 1, 4, 0, 1, 3, 1, 2, 2, 4, 2, 2, 3, 1, 0, 1, 0, 1, 0, 1, 2, 1, 0, 2, 2, 2, 5, 3, 1, 2, 5, 1, 1, 4, 2, 3, 0
matrix db 2, 5, 2, 1, 3, 1, 3, 6, 4, 2, 2, 3, 1, 2, 1, 0, 1, 0, 1, 2, 1, 0, 2, 2, 2, 5, 3, 1, 2, 5, 1, 1, 4, 2, 3, 0

; window info
window_size dd 3
window_row_ctr db 0 
sampling_window_size db 0
move_window dd 0

; sum and average
sum db 0 
avg db 0
temp_ebx db 0

; matrix info
matrix_size db 6 
increment_row db 0 

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

    ; CL holds 3
    MOV CL, [window_size]

    window_row:
        ; stores counter for row (3)
        MOV [window_row_ctr], CL

        ; iterates from each col backwards
        ; window_size - 1
        MOV ECX, [window_size]
        SUB ECX, 1
        MOV [move_window], ECX

        ADD EBX, [move_window]

        ; initialize CL for column of a window
        MOV CL, [window_size]

        window_col:

            ; move values of array into EDX
            ; EDX represents an element in the window
            MOVZX EDX, byte [matrix+EBX]

            ; EDX is added into the sum
            ADD [sum], EDX

            ; Subtract to move to next element
            SUB EBX,1 

        loop window_col

        ; move to next row on the window
        MOV AL, [increment_row]
        ADD EBX, EAX
        ; reset window row counter
        MOV CL, [window_row_ctr]

    loop window_row
    PRINT_STRING  "Sum: "
    PRINT_DEC 1, sum
    NEWLINE

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
        PRINT_STRING  "Average: "
        PRINT_DEC 1, eax 
        MOV [avg], eax

        MOV AL, [matrix_size]
        ADD [temp_ebx], AL
        MOV BL, [temp_ebx]

    xor eax, eax
    ret