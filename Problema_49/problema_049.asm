%include "io.inc"

section .data
n dw 11
L dw 8, 5, 20, 4, 6, 3, 10, 2, 5, 4, 1

;respuesta >>> 1 2 3 4 4 20 10 8 5 5 6

section .bss
minChild resb 4
index resb 4
i resb 4
factor1 resb 4
factor2 resb 4
d1 resb 4
d2 resb 4
cociente resb 4
section .text
global CMAIN
CMAIN:
    mov ebp, esp; for correct debugging
    call BuildHeap
    call Print_Array
    xor eax, eax
    ret 
    
;BuildHeap Method
BuildHeap:

    ; getting the start index
    movzx eax, word [n]
    mov [d1], eax
    mov [d2], byte 2
    call Positive_Division
    movzx eax, word [cociente]
    sub eax, 1
    mov [i], eax
    
    ; For loop
    for:
        cmp [i], byte 0
        jl final
        movzx ebx, word [i]
        push ebx
        call HeapyFy
        pop eax
        sub eax, 1
        mov [i], eax
        jmp for
        
    final:
        ret
    
; HeapyFy Method    
HeapyFy:
    ; set value to minChild
    movzx eax, byte [i]
    mov [factor1], eax
    mov [factor2], byte 2
    call Multiply
    movzx eax, word [factor1]
    movzx ebx, word [L + eax * 2 + 2]
    mov [minChild], ebx
    add eax, 1
    mov [index], eax
    
    ; checking that is the minor child
    movzx eax, word [index]
    add eax, 1
    cmp eax, [n]
    jl if_1
    jmp while
    if_1:
    movzx ebx, word [L + 2 * eax]
    cmp [minChild], ebx
    jg grather_1
    jmp while
    grather_1:
    mov [minChild], ebx
    mov [index], eax
    
    ; while loop
    while:
        movzx eax, byte [i]
        movzx ebx, word [L + 2 * eax]
        
        cmp ebx, [minChild]
        jle end
        
        ; swap
        
        movzx ecx, word [index]
        mov ax, [L + 2*ecx]
        movzx edx, word [i]
        mov bx, [L + 2 * edx]
        mov [L + 2*ecx], bx
        mov [L + 2 * edx], ax
        
        
        ;checking if node is leaf
        movzx eax, word [n]
        mov [d1], eax
        mov [d2], byte 2
        call Positive_Division
        movzx eax, word [cociente]
        cmp [index], eax
        jl continue_1
        ret
        
        continue_1:
        ; set value to minChild
        movzx eax, byte [index]
        mov [i], eax
        mov [factor1], eax
        mov [factor2], byte 2
        call Multiply
        movzx eax, word [factor1]
        movzx ebx, word [L + eax * 2 + 2]
        mov [minChild], ebx
        add eax, 1
        mov [index], eax
        
        ; checking that is the minor child
        movzx eax, word [index]
        add eax, 1
        cmp eax, [n]
        jl if_2
        jmp while
        if_2:
        movzx ebx, word [L + 2 * eax]
        cmp [minChild], ebx
        jg grather_2
        jmp while
        grather_2:
        mov [minChild], ebx
        mov [index], eax
        
     end:
        ret
   
    
; helpful methods 
    
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
    
 ; Print an array
 Print_Array:
 
    mov eax, 0
    mov [i], eax
    print_loop:
        movzx eax, word [n]
        cmp [i], eax
        jge end_print
        movzx eax, word [i]
        movzx eax, byte [L + eax*2]
        PRINT_UDEC 1, eax
        PRINT_STRING '   '
        add [i], byte 1
        jmp print_loop
    
    end_print:
        ret
     
 
 