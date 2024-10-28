section .data
    numbera equ 129

section .bss
    hstdout resq 1              ; Reserve 64-bit space for standard output handle

section .text
    extern GetStdHandle, WriteConsoleA, ExitProcess ; Windows.h apis
    global WinMain                                  ; `int main()` in C

WinMain:
    ; Get the STDOUT
    mov rcx, -11            ; rcx - first argument in calling convention
    call GetStdHandle
    mov [rel hstdout], rax  ; Use RIP-relative addressing to store handle

; char, Str*
; The max a 64bit number can be is 20 + '\0' = 21
    sub rsp, 21
    mov rsi, rsp        ; str*

; Setup
    mov rax, numbera        ; numbera
    mov rbx, 10

    mov rcx, 20             ; max len
    mov rdi, 1              ; len
    mov byte [rsi + 20], 0  ; "\0"

.loop_num:
    dec rcx             ; max len - 1
    xor rdx, rdx        ; Clear the remainder
    div rbx             ; numbera / rbx : Quotient:rax Remainder:rdx
    
    add dl, '0'         ; Add 0x30 or '0' in ascii to the lower 8bits

    mov [rsi + rcx], dl ; Ascii of the remainder in *temp[rsi]
    inc rdi             ; len + 1
    
    test rax, rax       ; is rax = 0?
    jne .loop_num       ; if not loop
    
    add rsi, rcx
    add rsp, rcx


    ; Write to the console
    mov rcx, [rel hstdout]  ; rcx: handle to standard output, RIP-relative
    mov rdx, rsi            ; rdx: pointer to the message
    mov r8, rdi             ; r8: length of the message
    mov r9, 0               ; r9: reserved, must be NULL
    sub rsp, 40             ; Align stack to 32 bytes - Win64 requirement
    call WriteConsoleA

    add rsp, 40 ; Restore stack alignment
    add rsp, rdi; clean up *str

    ; Exit the process
    ; ecx is the exit code
    mov ecx, 0
    call ExitProcess