#################################################################
#
# Laboratorium 5.
# Switch-case-break, adresowanie tablic,
# przekazanie argumentow i wywolanie funkcji jezyka C.
#
# Program ma wykonac wybrana operacje logiczna (arytm.) oraz wyswietlic:
# jej nazwe, argumenty i wynik.
#
# Argumenty do programu nalezy przekazac jako parametry z linii komend:
#
# ./swcs arg1 arg2 nr_operacji_logicznej

.globl	main

#################################################################
#
# Alokacja pamieci - zmienne statyczne z nadana wartoscia poczatkowa.

.data

str_and:	.asciz	"%u AND %u = %u\n"
str_or:		.asciz	"%u OR %u = %u\n"
str_xor:	.asciz	"%u XOR %u = %u\n"
str_add:	.asciz	"%u + %u = %u\n"
str_def:	.asciz	"DEFAULT\n"

arg_1:		.long	0
arg_2:		.long	0
result:		.long	0
case_no:	.long	0


# --- 2b --- uzupelnic
# Tablica skokow - adresow kolejnych sekcji switcha.
L:		.byte	0
H:		.byte	4

jump_table:
	.quad c_and
	.quad c_or
	.quad c_xor
	.quad c_def

#################################################################
#
# program glowny

.text

.extern atoi
.extern printf

main:

# --- 1a ---
#
# Przekazywanie parametrow z linii komend.
#
# Sprawdz, czy z linii komend przekazano trzy parametry,
# jesli nie - wyjdz (opcjonalnie zwracajac -1 w %eax).

cmp	$4, %edi
jz	convert_argv

mov	$-1, %eax
ret
# ...

convert_argv:

# Wyrownanie wierzcholka stosu do granicy 16 bajtow (8 bajtow w dol).
sub	$8,%rsp

# --- 1b ---
#
# Konwertuj przekazane parametry (argv) z ciagu tekstowego na liczbe calkowita,
# np. jedna z funkcji biblioteki stdlib.h (np. atoi, strtol).

mov	8(%rsi),%rdi
call	atoi
mov	%eax,arg_1

# Kolejne parametry:
# ...
mov	16(%rsi), %rdi
call	atoi
mov	%eax, arg_2

mov	24(%rsi), %rdi
call	atoi
mov	%eax, case_no

# --- 2a --- Switch - Case.
#
# Sprawdz, czy podany nr przypadku miesci sie w stablicowanym zakresie.

cmp	$L,%rax
jl	c_def
cmp	$H,%rax
jg	c_def


# Czesc wspolna dla wszystkich przypadkow (za wyjatkiem default - mozna zoptymalizowac).

mov	arg_1,%esi
mov	arg_2,%edx
mov	%edx,%ecx

# --- 2c ---
#
# Skok posredni - do adresu odczytanego z tablicy (do odpowiedniego przypadku).

mov	case_no, %eax
cltq
mov	jump_table(,%rax,8), %rax
jmp	*%rax

# W kazdym z przypadkow (oprocz default) wykonaj odpowiednia operacje
# logiczna/arytmetyczna oraz przekaz niezbedne argumenty do funkcji printf.

c_add:
add	%esi,%ecx
mov	$str_add,%rdi
jmp	brk

c_and:
and	%esi,%ecx
mov	$str_and,%rdi
jmp	brk

c_or:
or	%esi,%ecx
mov	$str_or,%rdi
jmp	brk

c_xor:
xor	%esi,%ecx
mov	$str_xor,%rdi
jmp	brk

c_def:

mov	$str_def,%rdi

brk:

# Czesc wspolna (dla wszystkich przypadkow).

# --- 3 ---

# Wywolaj funkcje printf z uprzednio umieszczonymi w odpowiednich rejestrach (wg ABI):
# adresem ciagu, argumentami i wynikiem operacji.

# ...

call	printf

# Przesun wskaznik stosu o 8 bajtow w gore aby prawidlowo sciagnac adres powrotu.
add	$8,%rsp

# Powrot z main, w %eax kod bledu.

xor	%eax,%eax
ret

#################################################################
