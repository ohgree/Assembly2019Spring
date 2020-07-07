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
; Reverses and flip cases of string
; Receives: EBX pointing to plain text string
;			ECX = key string length
;			EDX pointing to key string
; Returns:  EBX pointing to plain text string
;			EDX pointing to key string
; Requires: nothing
;---------------------------------------------------------------
	xor esi, esi          ; plain text index
	xor edi, edi          ; key string index
L1: mov al, [ebx+esi]
	cmp al, 0    ; check for null char in text
	je E1
	cmp edi, ecx
	jl E2
	xor edi, edi
E2: mov al, [ebx+esi]
	xor al, [edx+edi]
	mov [ebx+esi], al
	inc esi
	inc edi
	jmp L1
E1: ret
XORText ENDP
	
main PROC
	mov edx, OFFSET text
	mov ecx, LENGTHOF text
	call ReadString
	mov ebx, edx
	mov edx, OFFSET key
	mov ecx, LENGTHOF key
	call ReadString
	mov ecx, eax
	call XORText
	mov edx, ebx
	call WriteString
	call crlf
	call DumpRegs
	exit
main ENDP
END main