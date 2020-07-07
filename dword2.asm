TITLE Program Template (Template.asm)

; Program Description:
; Author:
; Creation Date:
; Revisions:
; Date:

INCLUDE Irvine32.inc
.data
; variables
bigEndian BYTE 12h, 34h, 56h, 78h
littleEndian DWORD ?
.code
main PROC
; executable codes
   mov littleEndian, 0
   mov ecx, LENGTHOF bigEndian
   mov esi, OFFSET bigEndian
   mov edi, OFFSET littleEndian
   add esi, 3
L1:mov al, [esi]
   mov [edi], al
   dec esi
   inc edi
   loop L1
   mov eax, littleEndian
   call DumpRegs
   exit
main ENDP
; additional procedures
END main