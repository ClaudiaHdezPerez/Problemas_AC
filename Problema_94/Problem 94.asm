%include "io.inc"

section .data
l dw 0
section .bss 
count resb 4
factor1 resb 4
factor2 resb 4
result resb 4
section .text
global CMAIN
CMAIN:
    mov ebp, esp; for correct debugging
    
    mov eax, [l]
    mov ebx, 1
    mov [count], ebx
    
    ; ciclo para la potencia
    while:
        mov [factor1], eax
        mov ebx, [l]
        mov [factor2], ebx
        call Multiply
        mov eax, [factor1]
        mov [result], eax
        
        mov ecx, 2
        cmp [count], ecx
        je end
        mov ecx, 1
        add [count], ecx
        jmp while
        
        
    end:   
    mov eax, [result]     
    PRINT_UDEC 4, eax
    NEWLINE
    xor eax, eax
    ret
    
    
 ; Region donde se realiza la multiplicacion
Multiply:
    mov eax, [factor1]
    mov ebx, [factor2]
    cmp ebx, 0 
    je zero
    
    cmp eax, 0
    je zero
   
    m_while:
        sub ebx, 1     
        cmp ebx, 0 
        je m_end
        
        add eax, [factor1]
        jmp m_while
       
    zero:
    mov eax, 0 
    m_end:
    mov [factor1], eax
    xor eax, eax
    ret