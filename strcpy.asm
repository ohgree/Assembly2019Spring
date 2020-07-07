TITLE String Copy (strcpy.asm)

; Program Description: strcpy using indirect addressing
; Author:
; Creation Date:
; Revisions:
; Date:

INCLUDE Irvine32.inc
.data
; variables
source BYTE "This is the source string", 0;
target BYTE LENGTHOF source DUP(?)
.code
main PROC
; executable codes
   mov ecx, LENGTHOF source
   mov esi, OFFSET source
   mov edi, OFFSET target
L1:
   mov al, [esi]
   mov [edi], al
   add esi, TYPE source
   add edi, TYPE target
   loop L1
   call DumpRegs
   exit
main ENDP
; additional procedures
END main