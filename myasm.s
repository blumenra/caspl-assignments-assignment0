section .data                    	; data section, read-write
        an:    DD 0              	; this is a temporary var

section .text                    	; our code is always in the .text section
        global do_Str          	; makes the function appear in global scope
        extern printf            	; tell linker that printf is defined elsewhere 							; (not used in the program)

do_Str:                        	; functions are defined as labels
        push    ebp              	; save Base Pointer (bp) original value
        mov     ebp, esp         	; use base pointer to access stack contents
        pushad                   	; push all variables onto stack
        mov ecx, dword [ebp+8]	; get function argument

;;;;;;;;;;;;;;;; FUNCTION EFFECTIVE CODE STARTS HERE ;;;;;;;;;;;;;;;; 

	mov	dword [an], 0		; initialize answer
    label_here:

        ; Your code goes somewhere around here...

        cmp byte [ecx], 28h ;cheack if '('
        je conv_left_bracket

        cmp byte [ecx], 29h ;cheack if ')'
        je conv_right_bracket

        jmp first_check
        

    first_check:
        cmp byte [ecx], 41h ;cheack if greater or eq to 'A'
        jae second_check
        jmp non_char

    second_check:
        cmp byte [ecx], 5bh ;cheack if greater or eq to 'Z'
        jae third_check
        jmp before_loop_again

    third_check:
        cmp byte [ecx], 61h ;cheack if greater or eq to 'a'
        jae forth_check
        jmp non_char

    forth_check:
        cmp byte [ecx], 7ah ;cheack if smaller or eq to 'z'
        jbe conv_to_upper_case
        jmp non_char


    conv_to_upper_case:
        sub byte [ecx], 32
        jmp before_loop_again


    conv_left_bracket:
        mov     byte [ecx], 3ch
        jmp non_char


    conv_right_bracket:
        mov     byte [ecx], 3eh


    non_char:
        inc word [an]


    before_loop_again:
        inc ecx             ; increment pointer
        cmp byte [ecx], 0   ; check if byte pointed to is zero
        jnz label_here      ; keep looping until it is null terminated
    
        

;;;;;;;;;;;;;;;; FUNCTION EFFECTIVE CODE ENDS HERE ;;;;;;;;;;;;;;;; 

         popad                    ; restore all previously used registers
         mov     eax,[an]         ; return an (returned values are in eax)
         mov     esp, ebp
         pop     ebp
         ret 
		 