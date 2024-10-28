section .data
    hello db "Hello World!!", 0 ; Hello world constant
    str_len  equ $ - hello      ; Length Hello world!!

section .bss
    hstdout resq 1              ; Reserve 64-bit space for standard output handle

section .text
    extern GetStdHandle, WriteConsoleA, ExitProcess ; Windows.h apis
    global WinMain ; `int main()` in C

WinMain:
; Prolog
    ; Set the stack frame
    push rbp
    mov rbp, rsp
    sub rsp, 32             ; Space for calling convention

    ; Get the STDOUT
    mov ecx, -11            ; rcx - first argument in calling convention
    call GetStdHandle
    mov [rel hstdout], rax  ; Use RIP-relative addressing to store handle

    ; Write to the console
    mov rcx, [rel hstdout]  ; rcx: handle to standard output, RIP-relative
    mov rdx, hello          ; rdx: pointer to the message
    mov r8, str_len         ; r8: length of the message
    mov r9, 0               ; r9: reserved, must be NULL
    call WriteConsoleA

; Restore the stack
    mov rsp, rbp
    pop rbp

    ; Exit the process
    ; ecx is the exit code
    mov ecx, 0
    call ExitProcess