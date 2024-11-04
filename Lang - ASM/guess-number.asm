section .data
    NL              db  10
    prompt          db  ">> "
    prompt_len      equ $ - prompt

    please_enter    db  "Please enter a number from 0 to 9"
    pe_len          equ $ - please_enter

    low             db  "That's a little too low"
    low_len         equ $ - low

    high            db  "That's a little too high"
    high_len        equ $ - high

    correct         db  "That's correct! Well done!"
    correct_len     equ $ - correct
    

section .bss
    stdio_out resq 1
    stdio_in  resq 1

section .text
    extern ExitProcess, GetStdHandle
    extern WriteConsoleA, ReadConsoleA
    extern time
    global WinMain

print:
    push rbp
    mov rbp, rsp
    sub rsp, 40
    push rcx
    push r9

    mov rcx, [rel stdio_out]
    mov r9 , 0
    call WriteConsoleA

.defer_print:
    pop r9
    pop rcx
    mov rsp, rbp
    pop rbp
    ret

println:
    push rdx
    push r8

    call print
    mov rdx, NL
    mov r8 , 1
    call print

    pop r8
    pop rdx
    ret

WinMain:
    push rbp
    mov rbp, rsp
    sub rsp, 64+32

    mov ecx, -11
    call GetStdHandle
    mov [rel stdio_out], rax

    mov ecx, -10
    call GetStdHandle
    mov [rel stdio_in], rax

; A = RAX * (RBX>>2)
    xor rcx, rcx
    call time
    shr rax, 2
    mov rbx, rax
    xor rcx, rcx
    call time
    imul rax, rbx
; B = A % 15
    xor rdx, rdx
    mov rcx, 15
    div rcx
    mov rax, rdx
; C = B - 4
    sub rax, 5
; if C is negative
    test rax, rax
    jns .done
    neg rax
    .done:
; Number
    mov byte [rbp-1], al
    add al, 48

;--------------------------------------
.WL1:
    mov rdx, please_enter
    mov r8 , pe_len
    call println
    mov rdx, prompt
    mov r8 , prompt_len
    call print

    mov rcx, [rel stdio_in]
    lea rdx, [rbp-34]
    mov r8 , 32
    lea r9 , [rbp-66]
    call ReadConsoleA

    mov al, byte [rbp-34]
.valid_input:
    cmp al, 48
    jl .WL1
    cmp al, 57
    jg .WL1
    sub al, 48
.L1:
    cmp al, byte [rbp-1]
    jne .L2
    mov rdx, correct
    mov r8 , correct_len
    call println
    jmp .defer_WinMain
.L2:
    cmp al, byte [rbp-1]    ; if (user_guess > random_num)
    jl .L3
    mov rdx, high
    mov r8 , high_len
    call println
    jmp .WL1
.L3:
    mov rdx, low
    mov r8 , low_len
    call println
    jmp .WL1

.defer_WinMain:
    mov rsp, rbp
    pop rbp
;----------------------------------
    mov rcx, 0
    call ExitProcess