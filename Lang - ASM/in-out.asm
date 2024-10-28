section .data
    prompt db ">> ", 0
    prompt_len equ $ - prompt

section .bss
    hstdout resq 1
    hstdin resq 1                ; Handle for standard input
    input_buffer resb 64         ; Buffer for user input
    input_len resd 1             ; Variable to store the length of input read

    ; resb 64   Reserves 64 bytes   [ Strings  ]
    ; resd 1    Reserves 4  bytes   [ Integers ]
    ; resq 1    Reserves 8  bytes   [ Long ints]
    ; resd 10   Reserves 40 bytes   [Array 10*4]

section .text
    extern GetStdHandle, WriteConsoleA, ReadConsoleA, ExitProcess
    global WinMain

WinMain:
; Prolog
;---------------
    ; set Frame
    push rbp
    mov rbp, rsp
    sub rsp, 32
;---------------


    mov ecx, -11                ; Standard output
    call GetStdHandle
    mov [rel hstdout], rax      ; Use RIP-relative addressing to store handle

    ; Get handle for standard input
    mov ecx, -10                ; Standard input
    call GetStdHandle
    mov [rel hstdin], rax       ; Store handle in hstdin


    ; Write to the console
    mov rcx, [rel hstdout]  ; rcx: handle to standard output, RIP-relative
    mov rdx, prompt         ; rdx: pointer to the message
    mov r8, prompt_len      ; r8: length of the message
    mov r9, 0               ; r9: reserved, must be NULL
    call WriteConsoleA

; Read in
;----------------------------------------------------------
    mov rcx, [rel hstdin]        ; rcx: handle to standard input
    lea rdx, [rel input_buffer]  ; rdx: pointer to input buffer
    mov r8, 64                   ; r8: buffer size (max number of characters to read)
    lea r9, [rel input_len]      ; r9: pointer to store the number of characters read
    call ReadConsoleA
;----------------------------------------------------------

    ; Optionally, you could echo the input back to the console
    ; Example of printing back the input received
    mov rcx, [rel hstdout]       ; Handle to standard output
    lea rdx, [rel input_buffer]  ; Pointer to the input buffer
    mov r8,  [rel input_len]     ; Length of the input (from input_len variable)
    mov r9, 0                    ; Reserved, must be NULL
    call WriteConsoleA


;---------------
; Clear stack
    mov rsp, rbp
    pop rbp
; Exit code
    mov ecx, 0
    call ExitProcess