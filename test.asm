TITLE Add and Subtract, Ver. 2 (AddSub2.asm) ; This program adds and subtracts 32-bit unsigned
; integers and stores the sum in a variable. 
INCLUDE Irvine32.inc
.data
dwL LABEL DWORD
wL LABEL WORD
list DWORD 10h, 00h, 20h
ptrW DWORD list
.code
main PROC
   mov eax, list
   call DumpRegs ; display the registers
   exit
main ENDP
END main
