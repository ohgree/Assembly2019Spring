TITLE Assembly HW3-1 20161603
INCLUDE irvine32.inc
INCLUDE hw5_3.inc

.data
prompt BYTE "Position value : ", 0

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
FindNextMatch PROC
; Find secondly-matched index from target, searching by source
; Receives: null-terminated string pointer: target(ebp+8), source(ebp+12)
; Returns: eax = index
; Requires: nothing
;---------------------------------------------------------------
   push ebp
   mov ebp, esp

   sub esp, 4
   mov DWORD PTR [ebp-4], 0       ;bool foundOnce

   mov edi, [ebp+8]     ;target

outer:
   mov al, [edi]
   cmp al, 0
   jz nomatch           ;end of string -> no pattern found
   push edi

   mov esi, [ebp+12]    ;source
inner:
   mov al, [esi]

   cmp al, 0
   jz found             ;end of pattern -> found pattern

   cmp al, [edi]
   jne b_inner          ;pattern mismatch -> break inner loop

   inc edi
   inc esi
   jmp inner

b_inner:
   pop edi
   inc edi
   jmp outer

found:
   mov eax, [ebp-4]
   cmp eax, 0
   jnz matched          ;foundOnce is already set -> found matching pattern
   mov DWORD PTR [ebp-4], 1
   jmp b_inner

matched:
   pop eax
   sub eax, [ebp+8]
   mov esp, ebp
   pop ebp
   ret 8
nomatch:
   mov eax, -1
   mov esp, ebp
   pop ebp
   ret 8
FindNextMatch ENDP


PrintPrmt MACRO msg
   push edx
   mov edx, OFFSET msg
   call WriteString
   pop edx
ENDM


main PROC
   push OFFSET target
   call StringLen
   mov ebx, eax

   push OFFSET source
   call StringLen
   cmp ebx, eax
   jl invalid
   
   push OFFSET source
   push OFFSET target
   call FindNextMatch
   mov pos, eax
   cmp eax, 0
   jl invalid

   PrintPrmt prompt
   mov eax, pos
   call WriteDec
   call Crlf

invalid:
   exit
main ENDP
END main