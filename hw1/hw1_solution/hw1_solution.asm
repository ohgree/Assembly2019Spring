TITLE Assignment 1 Solution

INCLUDE irvine32.inc

.data	;beginnig of the data segment
INCLUDE hw1.inc

.code
main PROC
	; 12 =			 8 + 4 = 001100(2)
	; 51 = 32 + 16 + 2 + 1 = 110011(2)
	;  5 =			 4 + 1 = 000101(2)
	mov ecx, val1	; ecx: val1
	add ecx, ecx	; ecx: val1 + val1 = 2val1 
	mov ebx, ecx	; ebx: 2val1
	add ebx, ebx	; ebx: 2val1 + 2val1 = 4val1
	mov eax, ebx	; eax: 4val1
	add eax, eax	; eax: 4val1 + 4val1 = 8val1
	add eax, ebx	; eax: 8val1 + 4Val1 = 12val1
	; eax: 12val1, ebx: 4val1, ecx: 2val1

	mov ecx, val2	; ecx: val2
	add eax, ecx	; eax: 12val1 + val2
	add ecx, ecx	; ecx: val1 + val1 = 2val2
	add eax, ecx	; eax: 12val1 + 3val2
	add ecx, ecx	; ecx: 2val2 + 2val2 = 4val2
	add ecx, ecx	; ecx: 4val2 + 4val2 = 8val2
	add ecx, ecx	; ecx: 8val2 + 8val2 = 16val2
	add eax, ecx	; eax: 12val1 + 3val2 + 16val2 = 12val1 + 19val2
	add ecx, ecx	; ecx: 16val2 + 16val2 = 32val2
	add eax, ecx	; eax: 12val1 + 51val2
	; eax: 12val1 + 51val2, ebx: 4val1, ecx: 32val2

	mov ecx, val4	; ecx: val4
	sub ecx, val3	; ecx: val4 - val3
	sub eax, ecx	; eax: 12val1 + 51val2 - (val4 - val3)
	add ecx, ecx	; ecx: 2(val4 - val3)
	add ecx, ecx	; ecx: 4(val4 - val3)
	sub eax, ecx	; eax: 12val1 + 51val2 -5(val4 - val3)
	; eax: 12val1 + 51val2 - 5(val4 - val3), ebx: 4val1, ecx: 4(val4 - val3)

	call DumpRegs	; display registers
	exit	
main ENDP	;the end of procedure 'main'
END main	;the last line of programs to be assembled.