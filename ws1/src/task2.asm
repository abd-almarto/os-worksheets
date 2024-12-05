%include "asm_io.inc"

section .data
    ; Messages
    promptNumTimes db "Enter the number of times to print the welcome message (between 50 and 100): ", 0
    errorMessage db "Error: Number must be between 50 and 100", 10, 0
    welcomeMsg db "Welcome!", 0
    newline db 10, 0

    ; Messages for array and range operations
    sumMsg db "The sum of the array is: ", 0
    promptStart db "Enter the start of the range (1-100): ", 0
    promptEnd db "Enter the end of the range (1-100): ", 0
    rangeErrorMsg db "Error: Invalid range. The start must be <= end, and both between 1 and 100.", 10, 0
    sumRangeMsg db "The sum of the range is: ", 0

section .bss
    numTimes resd 1      ; store number of times to print the message
    array resd 100       ; array of 100 elements
    sum resd 1           ; sum for array operations
    rangeStart resd 1    ; start of the range
    rangeEnd resd 1      ; end of the range

section .text
    global asm_main

asm_main:
    ; Step 1: Ask for the number of times to print the message
    mov eax, promptNumTimes
    call print_string
    call read_int             ; read integer input
    mov [numTimes], eax       ; store it in numTimes

    ; Validate the input number
    mov eax, [numTimes]
    cmp eax, 50
    jl print_error            ; if numTimes < 50, jump to error
    cmp eax, 100
    jg print_error            ; if numTimes > 100, jump to error

    ; Loop to print the welcome message
    mov ecx, [numTimes]       ; set loop counter to numTimes
print_loop:
    push ecx                  ; save loop counter
    mov eax, welcomeMsg
    call print_string         ; print "Welcome!"
    mov eax, newline
    call print_string         ; print newline
    pop ecx                   ; restore loop counter
    loop print_loop           ; decrement and repeat if ecx != 0

    ; Step 2: Array Initialization and Summation
    ; Initialize the array with values from 1 to 100
    mov ecx, 100              ; loop counter for 100 elements
    xor edi, edi              ; index for the array
init_loop:
    mov eax, edi
    add eax, 1                ; store values from 1 to 100
    mov [array + edi*4], eax
    inc edi                   ; increment index
    loop init_loop

    ; Sum the array
    xor eax, eax              ; clear eax (sum accumulator)
    xor edi, edi              ; reset index
    mov ecx, 100              ; loop counter for summing
sum_loop:
    add eax, [array + edi*4]  ; add each element to eax
    inc edi                   ; move to next element
    loop sum_loop

    mov [sum], eax            ; store the sum

    ; Print the sum of the array
    mov eax, sumMsg
    call print_string
    mov eax, [sum]
    call print_int
    call print_nl             ; print newline

    ; Step 3: Sum a User-Defined Range of the Array
    ; Ask for the start of the range
    mov eax, promptStart
    call print_string
    call read_int
    mov [rangeStart], eax

    ; Ask for the end of the range
    mov eax, promptEnd
    call print_string
    call read_int
    mov [rangeEnd], eax

    ; Validate the range
    mov eax, [rangeStart]
    mov ebx, [rangeEnd]
    cmp eax, ebx
    jg print_range_error       ; if start > end, jump to error
    cmp eax, 1
    jl print_range_error       ; if start < 1, jump to error
    cmp ebx, 100
    jg print_range_error       ; if end > 100, jump to error

    ; Sum the range
    xor eax, eax              ; clear eax (sum)
    mov ecx, [rangeEnd]
    sub ecx, [rangeStart]
    inc ecx                   ; calculate the number of elements in range
    mov edi, [rangeStart]
    dec edi                   ; adjust for zero-indexed array
sum_range_loop:
    add eax, [array + edi*4]  ; sum array[edi]
    inc edi
    loop sum_range_loop

    mov [sum], eax            ; store the result

    ; Print the result of the sum of the range
    mov eax, sumRangeMsg
    call print_string
    mov eax, [sum]
    call print_int
    call print_nl             ; print newline

    jmp end_program

print_error:
    mov eax, errorMessage
    call print_string         ; print error message
    jmp end_program

print_range_error:
    mov eax, rangeErrorMsg
    call print_string         ; print error message

end_program:
    mov eax, 0
    ret 