TITLE Assembly HW3-3 POC 20161603
INCLUDE irvine32.inc

.data
prmt1 BYTE "Type_A_String: ", 0
prmt2 BYTE "A_Word_for_Search: ", 0
prmt3 BYTE "Found", 0dh, 0ah, 0        ; crlf
prmt4 BYTE "Not found", 0dh, 0ah, 0    ; crlf
endmsg BYTE "Bye!", 0dh, 0ah, 0        ; crlf
text BYTE 42 DUP(0)
pat BYTE 42 DUP(0)

.code
;--------------------------------------------------------------
IsAlphaNumeric PROC
; Checks if a character is alphanumeric
; Receives: AL containing character value
; Returns:  EAX = 1 if character is alphanumeric
;           EAX = 0 if character is non-alphanumeric character
; Requires: nothing
;--------------------------------------------------------------
      cmp al, '0'
      jl E0
      cmp al, '9'
      jle E1
      cmp al, 'A'
      jl E0
      cmp al, 'Z'
      jle E1
      cmp al, 'a'
      jl E0
      cmp al, 'z'
      jle E1
E0:   xor eax, eax
      ret
E1:   mov eax, 1
      ret
IsAlphaNumeric ENDP
;---------------------------------------------------------------
find PROC USES esi edi
; Check if pattern is found in string, word-wise
; Receives: EBX pointing to text string
;			   ECX = pattern string length
;			   EDX pointing to pattern string
; Returns:  EAX = 1 if pattern is found
;           EAX = 0 if pattern is not found
; Requires: nothing
;---------------------------------------------------------------
      xor esi, esi          ; text index
L1:   xor edi, edi          ; pattern string index
      mov al, [ebx+esi]
      cmp al, 0             ; check for null char in text
      jz E0                 ; return with eax = 0
      push ecx
      push esi

L2:   mov al, [ebx+esi]     ; loop matching pattern
      cmp al, [edx+edi]
      jne B1
      inc esi
      inc edi
      loop L2
      pop esi
      pop ecx
      cmp al, '.'           ; exceptions for trailing '.' character. Sorry I don't want to use my brain at all
      je E0
      jmp match

B1:   pop esi
      pop ecx
B2:   inc esi
      jmp L1

match:cmp esi, 0            ; (Check left) check if the matched part is the beginning of character
      je T1
      mov al, [ebx+esi-1]   ; check character before the matched part
      call IsAlphaNumeric
      cmp eax, 0
      je T1
      jmp B2
T1:   add edi, esi          ; (Check right) check character after the matched part
      mov al, [ebx+edi]
      call IsAlphaNumeric   ; Non-alphanumeric value -> return with eax=1
      cmp eax, 0
      jz E1
      jmp B2
E1:   mov eax, 1
      ret
E0:   xor eax, eax  
      ret
find ENDP
    
main PROC
L1:   mov edx, OFFSET prmt1        ; Enter a plain text
      call WriteString
      mov edx, OFFSET text
      mov ecx, LENGTHOF text
      call ReadString
      cmp eax, 0
      jz B1
      cmp eax, LENGTHOF text - 1
      jae L1
      mov ebx, edx

L2:   mov edx, OFFSET prmt2        ; Enter a key
      call WriteString
      mov edx, OFFSET pat
      mov ecx, LENGTHOF pat
      call ReadString
      cmp eax, 0				
      jz B1
      cmp eax, LENGTHOF pat - 1
      jae L2

      mov ecx, eax
      call find
      cmp eax, 0
      jz M1
      mov edx, OFFSET prmt3
      call WriteString
      jmp L1
M1:   mov edx, OFFSET prmt4
      call WriteString
      jmp L1
B1:	mov edx, OFFSET endmsg
      call WriteString
      exit
main ENDP
END main