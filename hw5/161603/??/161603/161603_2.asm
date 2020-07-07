TITLE Assembly HW3-1 20161603
INCLUDE irvine32.inc
INCLUDE hw5_2.inc

.data
prompt BYTE "Concatenated string : ", 0
;targetStr BYTE "ABCDE", 10 DUP(0)
;sourceStr BYTE "FGH", 0

.code
;---------------------------------------------------------------
StringLen PROC
; get length of null-terminated string
; Receives: arg = null-terminated string pointer(ebp+8)
; Returns: eax = length of string
; Requires: nothing
;---------------------------------------------------------------
   push ebp
   mov ebp, esp
   push ebx
   push esi

   xor eax, eax
   mov esi, [ebp+8]
counting_loop:
   mov bl, [esi]
   cmp bl, 0
   jz break
   inc esi
   inc eax
   jmp counting_loop
break:

   pop esi
   pop ebx
   mov esp, ebp
   pop ebp
   ret 4
StringLen ENDP

;---------------------------------------------------------------
ConcatStr PROC
; Concats two strings
; Receives: null-terminated string pointer: target(ebp+8), source(ebp+12)
; Returns: 
; Requires: nothing
;---------------------------------------------------------------
   push ebp
   mov ebp, esp

   mov edi, [ebp+8]     ;target
   mov esi, [ebp+12]    ;source   (result: target + source)

geteos:
   mov al, [edi]
   cmp al, 0
   jz concat
   inc edi
   jmp geteos
concat:               ;edi = start of null. Overwrite from here
   mov al, [esi]
   cmp al, 0
   jz break
   mov [edi], al
   inc edi
   inc esi
   jmp concat
break:
   mov BYTE PTR [edi], 0 ;terminating with null

   mov esp, ebp
   pop ebp
   ret 4
ConcatStr ENDP

PrintPrmt MACRO msg
   push edx
   mov edx, OFFSET msg
   call WriteString
   pop edx
ENDM

main PROC
   
   push OFFSET targetStr
   call StringLen
   mov ebx, eax

   push OFFSET sourceStr
   call StringLen
   add eax, ebx
   cmp eax, LENGTHOF targetStr - 1

   ja invalid_length
   
   push OFFSET sourceStr
   push OFFSET targetStr
   call ConcatStr
   
   PrintPrmt prompt
   mov edx, OFFSET targetStr
   call WriteString
   call Crlf

invalid_length:
   exit
main ENDP
END main