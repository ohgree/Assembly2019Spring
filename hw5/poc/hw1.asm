TITLE Assembly HW3-1 20161603
INCLUDE irvine32.inc
INCLUDE hw5_1.inc

.data
prompt BYTE "Before sort : ", 0
prompt2 BYTE "After sort : ", 0
endmsg BYTE "Bye!", 0ah, 0dh, 0

;LenData DWORD 7
;ArrData DWORD 510013h, 10001h, 20003h, 10005h, 510021h, 20001h, 10002h

.code
;---------------------------------------------------------------
SortPairs PROC
; Sort pairs
; Receives: arg = array ptr(ebp+8), arraylen(ebp+12)
; Returns:
; Requires: nothing
;---------------------------------------------------------------
   push ebp
   mov ebp, esp
   sub esp, 8
;odd indexes - ascending order / decending order
;getting number of odd indexes
   xor edx, edx;
   mov eax, [ebp+12]  ;length of array
   mov ebx, 2
   div ebx
   cmp edx, 0
   jz skip
   inc eax
skip:
   mov [ebp-4], eax ; [ebp-4] = number of odd indexes
; processing ----------
   mov ecx, [ebp-4]
   mov edi, [ebp+8]   ;offset of array

   push LenData
   push OFFSET ArrData
   call PrintAllHex
   call Crlf
   call Crlf
;---
outerL:
   push ecx
   mov eax, [edi] ; eax = x coord/y coord
   ror eax, 16 ; ax = xcoord
   mov esi, edi
;------
innerL: ;get minimum & maximum memory addr
   mov ebx, [esi] ;ebx = temp
   ror ebx, 16
   
   cmp ax, bx
   jb next
   ; ax >= bx
   ; to test: x coord == new x coord
   jne makenew
   ; process for ax = bx
   ror eax, 16
   ror ebx, 16
   cmp ax, bx
   pushfd
   ror eax, 16
   ror ebx, 16
   popfd
   ja next
makenew:
   mov eax, ebx  ; case: ax < bx process
   mov [ebp-8], esi
next:
   add esi, 8

   loop innerL
;------ output: [esi-8] = addr of optimal element to swap with
   mov esi, [ebp-8]
   pop ecx
   
   push LenData
   push OFFSET ArrData
   call PrintAllHex

   mov eax, [edi]
   mov ebx, [esi]
   call DumpRegs
   mov [edi], ebx
   mov [esi], eax

   add edi, 8
   
   push LenData
   push OFFSET ArrData
   call PrintAllHex
   call Crlf

   loop outerL
;---

;even indexes - descending order / ascending order
   mov ecx, [ebp+12]
   sub ecx, [ebp-4] ; [ebp-4] = number of odd indexes
   mov edi, [ebp+8]   ;offset of array
   add edi, 4

   push LenData
   push OFFSET ArrData
   call PrintAllHex
   call Crlf
   call Crlf
;---
outerL2:
   push ecx
   mov eax, [edi] ; eax = x coord/y coord
   ror eax, 16 ; ax = xcoord
   mov esi, edi
;------
innerL2: ;get minimum & maximum memory addr
   mov ebx, [esi] ;ebx = temp
   ror ebx, 16
   
   cmp ax, bx
   ja next2
   ; ax >= bx
   ; to test: x coord == new x coord
   jne makenew2
   ; process for ax = bx
   ror eax, 16
   ror ebx, 16
   cmp ax, bx
   pushfd
   ror eax, 16
   ror ebx, 16
   popfd
   jb next2
makenew2:
   mov eax, ebx  ; case: ax < bx process
   mov [ebp-8], esi
next2:
   add esi, 8

   loop innerL2
;------ output: [esi-8] = addr of optimal element to swap with
   mov esi, [ebp-8]
   pop ecx
   
   push LenData
   push OFFSET ArrData
   call PrintAllHex

   mov eax, [edi]
   mov ebx, [esi]
   call DumpRegs
   mov [edi], ebx
   mov [esi], eax

   add edi, 8
   
   push LenData
   push OFFSET ArrData
   call PrintAllHex
   call Crlf

   loop outerL2
;---

   push LenData
   push OFFSET ArrData
   call PrintAllHex

   mov esp, ebp
   pop ebp
   ret 8
SortPairs ENDP

PrintAllHex PROC
; args - ArrayPtr(ebp+8), ArrayLen(ebp+12)
   push ebp
   mov ebp, esp
   pushad
   
   mov ecx, [ebp+12]
   mov esi, [ebp+8]
array_loop:
   mov eax, [esi]
   call WriteHex
   mov al, ' '
   call WriteChar
   add esi, 4
   loop array_loop
   call crlf

   popad
   mov esp, ebp
   pop ebp
   ret 8
PrintAllHex ENDP

PrintPrmt MACRO msg
   push edx
   mov edx, OFFSET msg
   call WriteString
   pop edx
ENDM

main PROC
   PrintPrmt prompt
   push LenData
   push OFFSET ArrData
   call PrintAllHex
   
   push LenData
   push OFFSET ArrData
   call SortPairs

   PrintPrmt prompt2
   push LenData
   push OFFSET ArrData
   call PrintAllHex

   PrintPrmt endmsg
   exit
main ENDP
END main