%include "asm_io.inc"  ; Include the I/O functions (assumed to be in asm_io.inc)

section .data
    integer1 dd 18       ; First integer
    integer2 dd 60        ; Second integer

section .bss
    result resd 1        ; Reserve space for the result

section .text
    global asm_main

asm_main:
    pusha                ; Save all general-purpose registers

    mov eax, [integer1]   ; Load the value of integer1 into eax
    add eax, [integer2]   ; Add the value of integer2 to eax
    mov [result], eax     ; Store the result in the 'result' variable

    push eax              ; Push the result onto the stack to pass it to print_int
    call print_int        ; Call the print_int function to print the result
    add esp, 4            ; Clean up the stack (4 bytes for the pushed value)

    popa                 ; Restore all general-purpose registers

    mov eax, 0            ; Return 0 as the exit status
    ret                   ; Return from asm_main
