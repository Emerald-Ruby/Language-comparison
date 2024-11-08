section .data
    nl           db     10
    tab          db     9
    arrow        db     ">> "

    prompt       db     "Please enter on of the following"
    prompt_len   equ    $ - prompt

    type         db     "type"
    type_len     equ    $ - type

    ts           db     "typescript"
    js_          db     "javascript"
    tsjs_len     equ    $ - js_

    anything     db     "Or anything!"
    anything_len equ    $ - anything


    nothing      db     "That's nothing!"
    nothing_len  equ    $ - nothing

    safety       db     "safety!"
    safety_len   equ    $ - safety

    the_scripts  db     "Ew ew ew ew away!"
    scripts_len  equ    $ - the_scripts

    ic           db     "Hmm yes I see, "
    ic_len       equ    $ - ic


section .bss
    stdio_out resq 1
    stdio_in  resq 1

section .text
    extern ExitProcess
    extern GetStdHandle
    extern WriteConsoleA, ReadConsoleA
    global WinMain

; rdx
; r8
print:
;----------------------
;   Prolog
    push rbp
    mov  rbp, rsp
    push rcx
    push r9
    sub  rsp, 32
;----------------------
; Body
    mov  rcx, [rel stdio_out]
    mov  r9 , 0
    call WriteConsoleA
;----------------------
;   End
.defer_print:
    pop  r9
    pop  rcx
    mov  rsp, rbp
    pop  rbp
    ret



; rbx for tabs
println:
;----------------------
    push rbp
    mov  rbp, rsp
    push rdx          ; rbp - 4
    push r8           ; rbp - 8
    push rbx
;----------------------

    test rbx, rbx
    jz .print
    push rdx
    push r8
    mov  rdx, tab
    mov  r8 , 1
    call print
    pop  r8
    pop  rdx
.print:
    call print

    mov  rdx, nl
    mov  r8 , 1
    call print

;----------------------
.defer_println:
    pop  rbx
    pop  r8
    pop  rdx
    pop  rbp
    ret

;   rsi     stra*
;   rdx     strb*
;   rdi     num_loops
compare_str:
    push rbp
    mov  rbp, rsp

    push rsi
    push rdx
    push rdi
    mov  rax, 1
; While [loop]
.W1:
    ; test rdi, rdi doesn't work?
    test edi, edi
    jz  .defer_compare_str
    mov  cl, byte [rsi]
    cmp  cl, byte [rdx]
    jne .return_false
    inc  rsi
    inc  rdx
    dec  rdi
    jmp  .W1

.return_false:
    mov rax, 0
.defer_compare_str:
    pop  rdi
    pop  rdx
    pop  rsi
    mov  rsp, rbp
    pop  rbp
    ret


WinMain:
;----------------------
;   Prolog
    push rbp
    mov  rbp, rsp
    sub  rsp, 112       ; [rbp - 64], [rbp - 68]
;----------------------
;   Body

    mov  rcx, -11
    call GetStdHandle
    mov  [rel stdio_out], rax

    mov  rcx, -10
    call GetStdHandle
    mov  [rel stdio_in], rax

;------------------------------
    mov  rdx, prompt
    mov  r8 , prompt_len
    call println

    mov  rbx, 1
    mov  rdx, type
    mov  r8 , type_len
    call println
    mov  rdx, ts
    mov  r8 , tsjs_len
    call println
    mov  rdx, js_
    mov  r8 , tsjs_len
    call println
    mov  rdx, anything
    mov  r8 , anything_len
    call println
;------------------------------
    mov  rdx, arrow
    mov  r8 , 3
    call print


;------------------------------
;   User input
;   Always returns \n\0
    mov  rcx, [rel stdio_in]
    lea  rdx, [rbp - 64]
    mov  r8 , 64
    lea  r9 , [rbp - 68]
    call ReadConsoleA
;------------------------------


;------------------------------
;   Fix the \n\0 len
    mov  rax, [rbp - 68]
    sub  rax, 2
    mov  [rbp - 68],  rax
;------------------------------


;------------------------------
    lea  rsi, [rbp - 64]
    mov  rdi, rax
.L1:
    test dil, dil
    jnz  .L2
    mov  rdx, nothing
    mov  r8 , nothing_len
    call print
    jmp .defer_WinMain
.L2:
    cmp  edi, type_len
    jne  .L3
    lea  rdx, [rel type]
    call compare_str
    test al, al
    jz  .L3
    mov  rdx, safety
    mov  r8 , safety_len
    call print
    jmp .defer_WinMain
.L3:
    lea  rdx, [rel ts]
    call compare_str
    test al, al
    jz  .L3A
    jmp .L3B
.L3A:
    lea  rdx, [rel js_]
    call compare_str
    test al, al
    jz  .L4
.L3B:
    mov  rdx, the_scripts
    mov  r8 , scripts_len
    call print
    jmp .defer_WinMain
.L4:
    mov  rdx, ic
    mov  r8 , ic_len
    call print
    mov  rdx, rsi
    mov  r8 , rdi
    call print
;----------------------
;   End of the program
.defer_WinMain:
    mov  rsp, rbp
    pop  rbp

    mov  rcx, 0
    call ExitProcess