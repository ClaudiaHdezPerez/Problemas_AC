%include "io.inc"

section .data
a dd 20
b dd 3
c dd 3
d dd 14
section .bss
factor1 resb 4
factor2 resb 4
A resb 4
B resb 4
mcm1 resb 4
mcm2 resb 4
MCM_result resb 4
cociente resb 4
resto resb 4
d1 resb 4
d2 resb 4
numerador resb 4
denominador resb 4
temp resb 4
section .text

global CMAIN
CMAIN:
    mov ebp, esp; for correct debugging
    
    call Rest_Fractions
    mov eax, [numerador]
    mov ebx, [denominador]
    
    PRINT_DEC 4, eax
    NEWLINE
    NEWLINE
    PRINT_DEC 4, ebx
    NEWLINE
    xor eax, eax
    ret
 
; Region para calcular el mcd   
MCD:
    mov eax, [A]
    mov ebx, [B]
    while:
        cmp eax, ebx
        je end
        jl less
        mov ecx, eax
        mov eax, ebx
        mov ebx, ecx
        
        less:
        sub ebx, eax
        jmp while
    end:
    mov [A], eax
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

; Region donde se realiza la division    
Positive_Division:
    mov eax, [d1]
    mov ebx, [d2]
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
  
; Region donde se calcula el mcm
MCM:
    mov eax, [mcm1]
    mov ebx, [mcm2]
    mov [A], eax
    mov [B], ebx
    
    call MCD
    
    mov eax, [mcm1]
    mov ebx, [mcm2]
    mov [factor1], eax
    mov [factor2], ebx
    call Multiply
    
    mov eax, [A]
    mov ebx, [factor1]
    
    mov [d1], ebx
    mov [d2], eax
    
    call Positive_Division
    mov eax, [cociente]
    mov [MCM_result], eax
    
    xor eax, eax
    ret
    
 ; Region donde se restan las fracciones
Rest_Fractions:
    mov eax, [b]
    mov ebx, [d]
    
    mov [mcm1], eax
    mov [mcm2], ebx
    call MCM
    mov ebx, [MCM_result]
    mov [denominador], ebx
    mov eax, [b]
    mov [d1], ebx
    mov [d2], eax
    
    call Positive_Division
    mov ecx, [cociente]
    mov [numerador], ecx
    
    mov eax, [a]
    mov ebx, [numerador]
    mov [factor1], eax
    mov [factor2], ebx
    
    call Multiply
    mov eax, [factor1]
    mov [numerador], eax
    
    mov eax, [d]
    mov ebx, [denominador]
    mov [d1], ebx
    mov [d2], eax
    call Positive_Division
    mov ecx, [cociente]
    mov eax, [c]
    mov [factor1], eax
    mov [factor2], ecx
    
    call Multiply
    mov ecx, [factor1]
    mov eax, [numerador]
    sub eax, ecx
    mov [numerador], eax
    
    ret