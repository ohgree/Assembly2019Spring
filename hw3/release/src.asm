TITLE Assembly HW3-1 20161603
INCLUDE irvine32.inc

.data
prompt BYTE "Type_A_String_To_Reverse: ", 0
prompt2 BYTE "Bye!", 0dh, 0ah, 0 ; crlf
input BYTE 42 DUP(0)

.code
;---------------------------------------------------------------
reverse PROC USES esi ecx ebx
; Reverses and flip cases of string
; Receives: EDX pointing to array of BYTES
;			EAX = length of string (excluding null character)
; Returns:  EDX pointing to changed array of BYTES
;		    EAX = length of string (excluding null character)
; Requires: nothing
;---------------------------------------------------------------
      mov esi, edx
      mov ecx, eax
L1:	movzx ebx, BYTE PTR [esi]        ; pushing characters to stack
      push ebx
      inc esi
      loop L1

B1:   mov ecx, eax
      mov esi, edx
L2:   pop ebx
      cmp bl, 'A'                      ; if bl = [A-Za-z], jump to P1, else, jump to B2
      jb B2
      cmp bl, 'Z'
      jbe P1
      cmp bl, 'a'
      jb B2
      cmp bl, 'z'
      ja B2
P1:	xor ebx, 00100000b     ; 00100000b - uppercase <-> lowercase
B2:	mov [esi], bl
      inc esi
      loop L2
      ret
reverse ENDP
    
main PROC
      mov ecx, LENGTHOF input
L1:	mov edx, OFFSET prompt
      call WriteString
      mov edx, OFFSET input
      call ReadString
      cmp eax, LENGTHOF input - 1         ; check if input exceeded 40 characters
      jae L1
      cmp eax, 0
      jz B1
      call reverse
      call WriteString
      call crlf
      jmp L1
B1:	mov edx, OFFSET prompt2
      call WriteString
      exit
main ENDP
END main