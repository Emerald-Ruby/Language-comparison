; Hi! lets see me code conditions in asm

section .data
    NEWLINE db 10
    TAB     db 9

    PROMPT db "Please pick one of the following", 0
    prompt_len equ $ - PROMPT

    TYPE db "type"
    type_len equ $ - TYPE

    TS db "typescript", 0
    ts_len equ $ - TS

    JS_ db "javascript", 0
    js_len equ $ - JS_

    ANYTHING db "Or anything!", 0
    any_len equ $ - ANYTHING

;-------------------------------------------------
;       Output message
;-------------------------------------------------
    nothing      db  "That's nothing!"    , 0
    nothing_len  equ $ - nothing

    safety       db  "Safety!"            , 0
    safety_len   equ $ - safety

    jts          db  "Ew ew ew ew away!"  , 0
    jts_len      equ $ - jts

    anything     db  "Hmm yes I see, "    ; No 0 ("\0")
    anything_len equ $ - anything

section .bss
    hstdout resq 1
    hstdin resq 1                ; Handle for standard input
    input_buffer resb 64         ; Buffer for user input
    input_len resd 1             ; Variable to store the length of input read


section .text
    extern GetStdHandle, WriteConsoleA, ReadConsoleA, ExitProcess ; Windows.h apis
    global WinMain ; `int main()` in C

; args :
; rdx  : String*
; r8   : size_t
print:
; Prolog
    push rbp
    mov rbp, rsp
    sub rsp, 32

    ; Write to the console
    mov rcx, [rel hstdout]  ; rcx: handle to standard output, RIP-relative
    mov r9, 0               ; r9: reserved, must be NULL
    call WriteConsoleA

    mov rsp, rbp
    pop rbp
    ret

; rdx   : string*
; r8    : size_t
print_newline:
;   Prolog
;-------------------------
    push rbp
    mov rbp, rsp
;-------------------------
;   Body
;-------------------------
    test r10, r10
    jne .no_tab
;   Print a tab
;-------------------------
    push rdx
    push r8
    mov rdx, TAB
    mov r8, 1
    call print
    pop r8
    pop rdx
;-------------------------
    .no_tab:
    call print

    push rdx
    push r8

    mov rdx, NEWLINE
    mov r8, 1
    call print
    pop r8
    pop rdx
;   Exit the function
;-------------------------
    mov rsp, rbp
    pop rbp
    ret

WinMain:
; Prolog
    push rbp        ; Someone else's Stack Frame
    mov rbp, rsp
    sub rsp, 32     ; 32 bytes for stack shadow padding

    mov ecx, -11            ; STDOUT
    call GetStdHandle       ; HANDLE
    mov [rel hstdout], rax  ; Put in the address space of hstdout

    mov ecx, -10                ; STDIN
    call GetStdHandle           ; HANDLE
    mov [rel hstdin], rax       ; Store handle in hstdin


    mov rdx, PROMPT
    mov r8 , prompt_len
    call print_newline

    mov r10, 0
    mov rdx, TYPE
    mov r8 , type_len
    call print_newline

    mov r10, 0
    mov rdx, TS
    mov r8 , ts_len
    call print_newline

    mov r10, 0
    mov rdx, JS_
    mov r8 , js_len
    call print_newline

    mov r10, 0
    mov rdx, ANYTHING
    mov r8 , any_len
    call print_newline

; Read in
;----------------------------------------------------------
    mov rcx, [rel hstdin]        ; rcx: handle to standard input
    lea rdx, [rel input_buffer]  ; rdx: pointer to input buffer
    mov r8, 64                   ; r8: buffer size (max number of characters to read)
    lea r9, [rel input_len]      ; r9: pointer to store the number of characters read
    call ReadConsoleA
;----------------------------------------------------------

; Doesn't do a full string comparision
; a little trick, COMPARE THE SIZE
    mov rax, [rel input_len]
; is it nothing?
    cmp rax, 2
    je  .nothing
; else is it something starting with "t" ending with "e"
    cmp rax, 6
    je  .maybe_safety
.not_safety:
; else does it have "t" "r" at the end or "t" "e" or "j" "a" at the start
    cmp rax, 12
    je  .maybe_ts
.not_tsjs:
    jmp .anything

.nothing:
    mov rdx, nothing
    mov r8 , nothing_len
    call print
    jmp .end_of_ifs
.safety:
    mov rdx, safety
    mov r8, safety_len
    call print
    jmp .end_of_ifs
.ew:
    mov rdx, jts
    mov r8, jts_len
    call print
    jmp .end_of_ifs
    jmp .end_of_ifs
.anything:
    mov rdx, anything
    mov r8, anything_len
    call print
    lea rdx, [rel input_buffer]  ; Pointer to the input buffer
    mov r8,  [rel input_len]     ; Length of the input (from input_len variable)
    call print
.end_of_ifs:

; Return
    mov rsp, rbp    ; mov stack back
    pop rbp         ; Restore previous stack frame

    mov ecx, 0      ; exit code
    call ExitProcess

;-------------------------------------------------------------------

.maybe_safety:
    mov rcx, input_buffer
    mov bl, byte [rcx]
    cmp rbx, 't'
    je .continue_safety
    jmp .not_safety
    .continue_safety:
    mov bl, byte [rcx+3]
    cmp rbx, 'e'
    je .safety
    jmp .not_safety

; T y p e s c r i p t
; 0 1 2 3 4 5 6 7 8 9

.maybe_ts:
    mov rcx, input_buffer
    mov bl, byte [rcx]
    cmp bl, 't'
    jne .maybe_js
    mov bl, byte [rcx+3]
    cmp bl, 'e'
    jne .maybe_js
    mov bl, byte [rcx+6]
    cmp bl, 'r'
    jne .not_tsjs
    mov bl, byte [rcx+9]
    cmp bl, 't'
    je .ew
    jmp .not_tsjs

.maybe_js:
    mov rcx, input_buffer
    mov bl, byte [rcx]
    cmp bl, 'j'
    jne .not_tsjs
    mov bl, byte [rcx+3]
    cmp bl, 'a'
    jne .not_tsjs
    mov bl, byte [rcx+6]
    cmp bl, 'r'
    jne .not_tsjs
    mov bl, byte [rcx+9]
    cmp bl, 't'
    je .ew
    jne .not_tsjs

; J a v a s c r i p t
; 0 1 2 3 4 5 6 7 8 9