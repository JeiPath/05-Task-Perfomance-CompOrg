section .data
    prompt db "Enter a single-digit number (0-9): ", 0
    below_msg db "The number is below 5.", 0
    equal_msg db "The number is equal to 5.", 0
    above_msg db "The number is above 5.", 0

section .bss
    input resb 1

section .text
    global _start

_start:
    ; Call procedure to get input
    call get_input

    ; Compare input with 5
    mov al, [input]       ; Load input into AL
    sub al, '0'           ; Convert ASCII to integer
    cmp al, 5             ; Compare input with 5
    jl below              ; Jump if less than 5
    je equal              ; Jump if equal to 5
    jg above              ; Jump if greater than 5

below:
    ; Print "below 5" message
    mov edx, len below_msg
    mov ecx, below_msg
    call print_msg
    jmp exit

equal:
    ; Print "equal to 5" message
    mov edx, len equal_msg
    mov ecx, equal_msg
    call print_msg
    jmp exit

above:
    ; Print "above 5" message
    mov edx, len above_msg
    mov ecx, above_msg
    call print_msg

exit:
    ; Exit program
    mov eax, 60
    xor edi, edi
    syscall

; Procedure to get input
get_input:
    mov eax, 3            ; sys_read
    mov ebx, 0            ; stdin
    mov ecx, input        ; Buffer to store input
    mov edx, 1            ; Read 1 byte
    int 0x80              ; System call
    ret

; Procedure to print message
print_msg:
    mov eax, 4            ; sys_write
    mov ebx, 1            ; stdout
    int 0x80              ; System call
    ret