section .data
    hello db "Hello World!!", 0 ; Hello world constant
    str_len  equ $ - hello         ; Length Hello world!!

section .bss
    hstdout resq 1              ; Reserve 64-bit space for standard output handle

section .text
    extern GetStdHandle, WriteConsoleA, ExitProcess ; Windows.h apis
    global WinMain

WinMain:
    ; Get the STDOUT
    ; rcx - first argument in calling convention
    mov rcx, -11
    call GetStdHandle
    ; Use RIP-relative addressing to store handle
    ; Don't ask me to explain, I am dumb
    mov [rel hstdout], rax

    ; Write to the console
    ; rcx: handle to standard output, RIP-relative
    mov rcx, [rel hstdout]
    ; rdx: pointer to the message
    mov rdx, hello
    ; r8: length of the message
    mov r8, str_len
    ; r9: reserved, must be NULL
    mov r9, 0
    ; Align stack to 16 bytes - Win64 requirement
    sub rsp, 40
    call WriteConsoleA
    ; Restore stack alignment
    add rsp, 40

    ; Exit the process
    ; ecx is the exit code
    mov ecx, 0
    call ExitProcess

; This one isn't fully my code