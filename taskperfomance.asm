section .data
    prompt db "Enter a single-digit number (0-9): ", 0
    below_msg db "The number is below 5.", 10, 0
    equal_msg db "The number is equal to 5.", 10, 0
    above_msg db "The number is above 5.", 10, 0

section .bss
    input resb 2  ; Reserve 2 bytes for input (1 for digit, 1 for newline)

section .text
    global _start

_start:
    ; Print the prompt message
    mov eax, 4          ; sys_write
    mov ebx, 1          ; stdout
    mov ecx, prompt     ; Address of the prompt message
    mov edx, 32         ; Length of the prompt message
    int 0x80            ; System call

    ; Read user input
    mov eax, 3          ; sys_read
    mov ebx, 0          ; stdin
    mov ecx, input      ; Address of the input buffer
    mov edx, 2          ; Read 2 bytes (digit + newline)
    int 0x80            ; System call

    ; Convert ASCII to integer
    mov al, [input]     ; Load the first byte of input
    sub al, '0'         ; Convert ASCII to integer
    cmp al, 5           ; Compare input with 5
    jl below            ; Jump if less than 5
    je equal            ; Jump if equal to 5
    jg above            ; Jump if greater than 5

below:
    ; Print "below 5" message
    mov eax, 4          ; sys_write
    mov ebx, 1          ; stdout
    mov ecx, below_msg  ; Address of the below message
    mov edx, 23         ; Length of the below message
    int 0x80            ; System call
    jmp exit

equal:
    ; Print "equal to 5" message
    mov eax, 4          ; sys_write
    mov ebx, 1          ; stdout
    mov ecx, equal_msg  ; Address of the equal message
    mov edx, 26         ; Length of the equal message
    int 0x80            ; System call
    jmp exit

above:
    ; Print "above 5" message
    mov eax, 4          ; sys_write
    mov ebx, 1          ; stdout
    mov ecx, above_msg  ; Address of the above message
    mov edx, 23         ; Length of the above message
    int 0x80            ; System call

exit:
    ; Exit the program
    mov eax, 1          ; sys_exit
    xor ebx, ebx        ; Exit code 0
    int 0x80            ; System call
