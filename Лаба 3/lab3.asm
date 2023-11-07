
.model small
.stack 100h

.data
    student_info db 'Filippenko Dmitry 241', 0
    output_format db 'Number: %u', 10, 0
    number1 db 75
    number2 dd 65536

.code
org 100h

start:

    mov ax, @data
    mov ds, ax
    mov dx, offset student_info
    mov ah, 9
    int 21h

    ; Çàäàíèå 3.1: Âûâîä ÷èñëà, õðàíÿùåãîñÿ â ðåãèñòðå AL
    mov al, byte ptr number1
    call print_al

    ; Çàäàíèå 3.2: Âûâîä ÷èñëà, õðàíÿùåãîñÿ â ðåãèñòðå EAX
    mov eax, dword ptr number2
    call print_eax

    mov ah, 4Ch
    int 21h

print_al:
    mov ah, 0
    mov bl, 10
    div bl
    push ax
    pop dl
    add dl, '0'
    mov ah, 2
    int 21h
    ret

print_eax:
    mov ebx, 10
    xor edx, edx
	
print_eax_loop:
    div ebx
    push dx
    or eax, eax
    jnz print_eax_loop
	
print_eax_next_digit:
    pop dx
    add dl, '0'
    mov ah, 2
    int 21h
    dec dl
    jnz print_eax_next_digit
    ret
