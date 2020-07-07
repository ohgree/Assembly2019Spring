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
   mov esi, 0
   mov edi, 3
   mov ecx, LENGTHOF bigEndian
L1:
   mov al, bigEndian[esi]
   mov BYTE ptr littleEndian[edi], al 
   inc esi
   dec edi
   loop L1
   mov eax, littleEndian
   call DumpRegs
   exit
main ENDP
; additional procedures
END main