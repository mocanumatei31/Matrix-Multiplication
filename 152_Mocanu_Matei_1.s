.data
m1: .space 40100
m2: .space 40100
c: .space 4
n: .space 4
len2: .space 4
leg: .space 400
Int: .asciz "%d"
Int2: .asciz "%d\n"
IntAfis: .asciz "%d "
Enter: .asciz "\n"
test: .asciz "test\n"
index: .space 4
x: .space 4
cnt: .space 4
i: .space 4
j: .space 4
pow: .space 4
left: .space 4
right: .space 4
len: .space 4
.text
matrix_mult:
pushl %ebp
movl %esp, %ebp
pushl %ebx
pushl %edi
pushl %esi
movl $0, %ecx
movl $0, %edx
f_linii:
cmp %ecx, 20(%ebp)
je f_exit
movl $0, %edx
	f_coloane:
	cmp %edx, 20(%ebp)
	je f_lininc
	movl 8(%ebp), %edi
	movl 12(%ebp), %esi
	movl $0, %ebx
	movl %ecx, %eax
	pushl %edx
	movl $0, %edx
	mull 20(%ebp)
	popl %edx
	addl %edx, %eax
	pushl %eax
		for_calcul:
		cmp %ebx, 20(%ebp)
		je f_colinc
		movl 8(%ebp), %edi
		movl 12(%ebp), %esi
		movl %ecx, %eax
		pushl %edx
		pushl %ebx
		movl $0, %edx
		mov 20(%ebp), %ebx
		mull %ebx
		popl %ebx
		popl %edx
		addl %ebx, %eax
		pushl %ebx
		movl (%edi, %eax, 4), %ebx
		pushl %ebx
		movl -20(%ebp), %ebx
		movl %ebx, %eax
		pushl %edx
		pushl %ebx
		movl $0, %edx
		movl 20(%ebp), %ebx
		mull %ebx
		popl %ebx
		popl %edx
		addl %edx, %eax
		movl (%esi, %eax, 4), %ebx
		popl %eax
		pushl %edx
		mull %ebx
		popl %edx
		movl 16(%ebp), %edi
		movl -16(%ebp), %ebx
		addl %eax, (%edi, %ebx, 4)
		popl %ebx
		incl %ebx
		jmp for_calcul
	f_colinc:
	incl %edx
	popl %eax
	jmp f_coloane
f_lininc:
incl %ecx
jmp f_linii
f_exit:
popl %esi
popl %edi
popl %ebx
popl %ebp
ret
 
.global main
main:
pushl $c
pushl $Int
call scanf
popl %ebx
popl %ebx
pushl $n
pushl $Int
call scanf
popl %ebx
popl %ebx
movl $0, index
movl $0, %ecx
lea leg, %edi
et_loop:
movl index, %ecx
cmp n, %ecx
je et_prepgenmat
pushl %eax
pushl %ecx
pushl %edx
pushl $x
pushl $Int
call scanf
popl %ebx
popl %ebx
popl %edx
popl %ecx
popl %eax
movl x, %eax
movl %eax, (%edi, %ecx, 4)
inc %ecx
movl %ecx, index
jmp et_loop
et_prepgenmat:
movl $0, cnt
lea m1, %esi
jmp et_genmat
et_genmat:
movl cnt, %ecx
cmp %ecx, n
je et_taskcheck
movl (%edi, %ecx, 4), %edx
cmp $0, %edx
je et_incr
pushl %eax
pushl %ecx
pushl %edx
pushl $x
pushl $Int
call scanf
popl %ebx
popl %ebx
popl %edx
popl %ecx
popl %eax
movl cnt, %eax
movl n, %ebx
movl $0, %edx
mull %ebx
addl x, %eax
lea m1, %esi
movl $1, (%esi, %eax, 4)
lea m2, %esi
movl $1, (%esi, %eax, 4)
movl (%edi, %ecx, 4), %edx
dec %edx
movl %edx, (%edi, %ecx, 4)
jmp et_genmat
et_incr:
movl cnt, %ecx
inc %ecx
movl %ecx, cnt
jmp et_genmat
et_taskcheck:
movl c, %ecx
cmp $3, %ecx
je et_cer2
et_afis:
movl $0, i
for_linii:
movl i, %ecx
cmp %ecx, n
je et_exit
movl $0, j
	for_coloane:
	movl j, %ecx
	cmp %ecx, n
	je et_enter
	movl i, %eax
	movl n, %ebx
	movl $0, %edx
	mull %ebx
	addl j, %eax
	lea m1, %esi
	movl (%esi, %eax, 4), %ebx
	pushl %eax
	pushl %ecx
	pushl %edx
	pushl %ebx
	pushl $IntAfis
	call printf
	popl %ebx
	popl %ebx
	popl %edx
	popl %ecx
	popl %eax
	inc j
	jmp for_coloane
et_enter:
pushl $Enter
call printf
popl %edx
inc i
jmp for_linii
 
et_cer2:
pushl $pow
pushl $Int
call scanf
popl %ebx
popl %ebx
pushl $left
pushl $Int
call scanf
popl %ebx
popl %ebx
pushl $right
pushl $Int
call scanf
popl %ebx
popl %ebx
movl n, %eax
movl n, %ebx
mull %ebx
mov %eax, len
mov $4, len2
mull len2
mov %eax, len2
movl $1, cnt
pushl %ebx
pushl %ecx
pushl %edx
pushl %esi
pushl %edi
pushl %ebp
//valoarea 192 corespunde apelului de sistem pentru functia mmap2
movl $192, %eax
//%ebx corespunde adresei de unde se incepe mapping-ul, iar prin atribuirea
//valorii 0 nu este impusa o anumita adresa de memorie pentru asta
movl $0, %ebx
//deoarece mres este o matrice patratica cu n^2 elemente intregi,
// in %ecx vom pune valorea 4*(n^2), calculata in len2
movl len2, %ecx
//valoarea 3 reprezinta utilizarea PROT_READ si PROT_WRITE, ceea
//ce ofera permisiunea de a citi si modifica ce e stocat in memorie
movl $3, %edx
//valoarea 34 reprezinta flagurile MAP_PRIVATE|MAP_ANONYMOUS,
//care creeaza in memoria alocata un sir de elemente cu valoarea 0
movl $34, %esi
//fd ia valoarea -1 deoarece, idn cauza utilizarii MAP_ANONYMOUS,
// nu este folosit un fisier pentru mapping
movl $-1, %edi
//valoarea de 0 pentru offset este fortata de utilizarea la flag
// a MAP_ANONYMOUS
movl $0, %ebp
int $0x80
popl %ebp
popl %edi
popl %esi
popl %edx
popl %ecx
popl %ebx
mov pow, %ecx
cmp $0, %ecx
je et_pow0
et_rez2:
mov cnt, %ecx
cmp %ecx, pow
je et_afis2
pushl n
pushl %eax
pushl $m2
pushl $m1
call matrix_mult
popl %ebx
popl %ebx
popl %eax
popl %ebx
incl cnt
movl $0, i
et_resetm1:
movl i, %ecx
cmp %ecx, len
je et_rez2
lea m1, %edi
movl %eax, %esi
pushl %eax
movl (%esi, %ecx, 4), %eax
movl %eax, (%edi, %ecx, 4)
popl %eax
movl $0, (%esi, %ecx, 4)
incl i
jmp et_resetm1
et_pow0:
mov $0, i
et_clearm1:
movl i, %ecx
cmp %ecx, len
je et_genpow0
lea m1, %edi
movl $0, (%edi, %ecx, 4)
incl i
jmp et_clearm1
et_genpow0:
mov $0, i
et_gennpow0:
movl i, %ecx
cmp %ecx, n
je et_afis2
lea m1, %edi
movl i, %eax
mull n
addl i, %eax
movl $1, (%edi, %eax, 4)
incl i
jmp et_gennpow0
et_afis2:
mov %eax, %ebx
mov len2, %ecx
mov $91, %eax
int $0x80
mov left, %eax
mull n
add right, %eax
lea m1, %esi
movl (%esi, %eax, 4), %ebx
pushl %ebx
pushl $Int2
call printf
popl %ebx
popl %ebx
et_exit:
pushl $0
call fflush
popl %ebx
movl $1, %eax
xor %ebx, %ebx
int $0x80