TITLE Assembly Homework 1
INCLUDE Irvine32.inc
.data
INCLUDE hw1.inc
.code
main proc
   mov eax, val4
   sub eax, val3
   mov edx, 5
   mul edx
   mov ebx, eax
   mov eax, val2
   mov edx, 51
   mul edx
   sub eax, ebx
   mov ebx, eax
   mov eax, val1
   mov edx, 12
   mul edx
   add ebx, eax

   mov eax, val3
   sub eax, val4
   mov edx, 15
   mul edx
   mov ecx, eax
   mov eax, val2
   mov edx, 13
   mul edx
   sub eax, ecx
   mov ecx, eax
   mov eax, val1
   mov edx, 14
   mul edx
   add ecx, eax

   mov eax, ebx
   mov ebx, ecx
   call DumpRegs
   exit
main endp
end main