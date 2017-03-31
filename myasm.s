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

        cmp byte [ecx], '('     ; cheack if '('
        je conv_left_bracket    ; if '(' go change it into '{'

        cmp byte [ecx], ')'     ; cheack if ')'
        je conv_right_bracket   ; if ')' go change it into '}'

        jmp first_check         ; it is neither '(' not ')'
        

    first_check:
        cmp byte [ecx], 'A'     ; cheack if greater or eq to 'A' (0x41)
        jae second_check        ; if greater or eq to 'A', go check if it is greater or smaller than 'Z'
        jmp non_char            ; else (smaller than 'A') inc the non-char charachters at non-char label

    second_check:
        cmp byte [ecx], 'Z'     ; cheack if greater or eq to 'Z' (0x5b)
        jae third_check         ; if greater or eq to 'Z', go check if it is greater or smaller than 'a'
        jmp before_loop_again   ; else (smaller than 'Z') DONT inc the non-char charachters

    third_check:
        cmp byte [ecx], 'a'     ; cheack if greater or eq to 'a' (0x61)
        jae forth_check         ; if greater or eq to 'a', go check if it is greater or smaller than 'z'
        jmp non_char            ; else (smaller than 'a') inc the non-char charachters at non-char label because it is a char btween 0x5b~0x60

    forth_check:
        cmp byte [ecx], 'z'     ; cheack if !SMALLER! or eq to 'z' (0x7a)
        jbe conv_to_upper_case  ; if !SMALLER! or eq to 'z', go convert this lower-case char into an upper-case char
        jmp non_char            ; else (greater than 'z') inc the non-char charachters at non-char label because it is a char btween 0x7b~0x7f


    conv_to_upper_case:
        sub byte [ecx], 32      ; substruct 32 from this lower-case char in order to convert it into an  upper-case char
        jmp before_loop_again


    conv_left_bracket:
        mov byte [ecx], '{'
        jmp non_char


    conv_right_bracket:
        mov byte [ecx], '}'


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
		 