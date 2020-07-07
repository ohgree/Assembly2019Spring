TITLE Add and Subtract, Ver. 2 (AddSub2.asm) ; This program adds and subtracts 32-bit unsigned
; integers and stores the sum in a variable. 
INCLUDE Irvine32.inc
.data
val1 DWORD 10000h
val2 DWORD 40000h
val3 DWORD 20000h
finalVal DWORD ?
.code
main PROC
   mov eax,val1
   add eax,val2
   sub eax,val3
   mov finalVal,eax
   call DumpRegs ; display the registers
   exit
main ENDP
END main
