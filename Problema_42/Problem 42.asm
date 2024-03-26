%include "io.inc"

section .data
n dd 4
m dd 3
A_1 dw 1, 0, 3, 0, 4, 5, 2, 20, 2, 3, 10, 18
A_2 dw 1, 0, 3, 0, 4, 5, 2, 20, 2, 3, 10, 18
section .bss
i resb 4
result resb 4
d1 resb 4
d2 resb 4
cociente resb 4
factor1 resb 4
factor2 resb 4
resto resb 4
length resb 2
section .text
global CMAIN
CMAIN:
    mov ebp, esp; for correct debugging
    
    mov [i], byte 0
    mov eax, [n]
    mov [factor1], eax
    mov eax, [m]
    mov [factor2], eax
    call Multiply
    mov eax, [factor1]
    mov [length], eax
    
    for1:
    movzx eax, byte [i]
    movzx ebx, word [A_1 + eax*2]
    movzx ecx, word [A_2 + eax*2]
    sub ebx, ecx
    mov [result], ebx
    
    movzx ecx, word [i]
    mov [d1], ecx 
    movzx ecx, word [m]
    mov [d2], ecx
    call Positive_Division
    call Rst
    cmp [resto], byte 0
    jne sigue
    cmp [i], byte 0
    je sigue
    NEWLINE
    sigue:
    movzx eax, word [result]
    PRINT_DEC 2, eax
    PRINT_STRING ' '
    
    add [i], byte 1
    movzx eax, byte [i]

    cmp [length], eax
    je end
    jmp for1
    end:
    ;write your code here
    xor eax, eax
    ret
    
    
    
Rst:
    movzx eax, word [d2]
    movzx ebx, word [cociente]
    
    mov [factor1], eax
    mov [factor2], ebx
    
    call Multiply
    movzx eax, word [d1]
    sub eax, [factor1]
    mov [resto], eax 
    
    xor eax, eax
    ret
    
Positive_Division:
    movzx eax, word [d1]
    movzx ebx, word [d2]
    mov ecx, 0
    
    pd_while:
        cmp eax, ebx
        jl pd_end
        sub eax, ebx
        add ecx, 1
        jmp pd_while
        
    pd_end:
        mov [cociente], ecx
        xor eax, eax
        ret
        
Multiply:
    movzx eax, word [factor1]
    movzx ebx, word [factor2]
    cmp ebx, 0 
    je zero
    cmp eax, 0
    je zero
 
    jmp m_while
    
    m_while:
        sub ebx, 1     
        cmp ebx, 0 
        je m_end
        
        add eax, [factor1]
        jmp m_while
       
    zero:
    mov eax, 0 
    m_end:
    mov ecx, 1
    mov [factor1], eax
    xor eax, eax
    ret