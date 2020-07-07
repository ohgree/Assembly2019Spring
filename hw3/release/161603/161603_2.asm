TITLE Assembly HW3-2 POC 20161603
INCLUDE irvine32.inc

.data
prmt1 BYTE "Enter a plain text : ", 0
prmt2 BYTE "Enter a key : ", 0
prmt3 BYTE "Original Text : ", 0
prmt4 BYTE "Encrypted Text : ", 0
prmt5 BYTE "Decrypted Text : ", 0
endmsg BYTE "Bye!", 0dh, 0ah, 0        ; crlf
text BYTE 41 DUP(0)
key BYTE 11 DUP(0)

.code
;---------------------------------------------------------------
XORText PROC USES eax esi edi
; XOR text with given key
; Receives: EBX address to plain text string
;			ECX = key string length
;			EDX address to key string
; Returns:  EBX address to xor'ed text string
;			EDX address to key string
; Requires: nothing
;---------------------------------------------------------------
	   xor esi, esi          ; plain text index
	   xor edi, edi          ; key string index
L1:   mov al, [ebx+esi]
	   cmp al, 0    ; check for null char in text
	   je E1
	   cmp edi, ecx
	   jl E2
	   xor edi, edi
E2:   mov al, [ebx+esi]
	   xor al, [edx+edi]
	   mov [ebx+esi], al
	   inc esi
	   inc edi
	   jmp L1
E1:   ret
XORText ENDP
	
main PROC
L1:	mov edx, OFFSET prmt1        ; Enter a plain text
	   call WriteString
	   mov edx, OFFSET text
	   mov ecx, LENGTHOF text
	   call ReadString
	   cmp eax, 0
	   jz B1

	   mov ebx, edx
	   mov edx, OFFSET prmt2        ; Enter a key
	   call WriteString
	   mov edx, OFFSET key
	   mov ecx, LENGTHOF key
	   call ReadString
	   call crlf

	   push edx
	   mov edx, OFFSET prmt3
	   call WriteString              ; Original Text
	   mov edx, ebx
	   call WriteString
	   call crlf
	   pop edx

	   mov ecx, eax
	   call XORText

	   push edx
	   mov edx, OFFSET prmt4
	   call WriteString               ; Encrypted text
	   mov edx, ebx
	   call WriteString
	   call crlf
	   pop edx

	   mov ecx, eax
	   call XORText

	   mov edx, OFFSET prmt5
	   call WriteString               ; Decrypted text
	   mov edx, ebx
	   call WriteString
	   call crlf
	   call crlf

	   jmp L1
B1:	mov edx, OFFSET endmsg
	   call WriteString
	   exit
main ENDP
END main