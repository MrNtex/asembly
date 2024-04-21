#################################################################

# Nazwa (etykieta - label) programu glownego
# jest to wskaznik - adres pierwszej instrukcji programu

.globl _start

# Definicje stalych, uzywanych w programie (opcjonalnie)

.equ	sys_write,	1
.equ	sys_exit,	60
.equ	stdout,	1
.equ	strlen, 	new_line + 1 - str


#################################################################
#
# Alokacja pamieci - zmienne statyczne, 8/16/32/64 bitowe,
# z nadana wartoscia poczatkowa

.data

str:		.ascii	"Hello!"
new_line:	.byte	0x0A

#################################################################
#
# Program glowny

.text

_start:

# Zadania:

# - 1 - zrobione - przekaz argumenty i wywolaj System Call nr 1 (sys_write)


mov	$sys_write , %eax
mov	$stdout , %edi
mov	$str , %esi
mov	$strlen , %edx
syscall

# Koniec programu

# - 2 - zakoncz poprawnie program
# np. przekaz argumenty i wywolaj System Call nr 60 (sys_exit)
mov $sys_exit, %eax
syscall

