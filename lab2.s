#################################################################
#
# Laboratorium 2. 
# Wywolanie System Calls
# Wydrukowanie ciagu tekstowego w oknie terminala
# Prosta petla "for" (rozne sposoby)


# Nazwa (etykieta - label) programu glownego
# jest to wskaznik - adres pierwszej instrukcji programu

.globl _start

# Definicje stalych, uzywanych w programie (opcjonalnie)

.equ	sys_write,	1
.equ	sys_exit,	60
.equ	stdout,	1
.equ	iterations,	5
.equ	strlen, 	new_line + 1 - str


#################################################################
#
# Alokacja pamieci - zmienne statyczne, 8/16/32/64 bitowe,
# z nadana wartoscia poczatkowa

.data

str:		.ascii	"iteracja nr: x"
new_line:	.byte	0x0A
counter:	.byte	0

#################################################################
#
# Program glowny

.text

_start:


# Zadania: (1. i 2. - z poprzednich zajec)

# - 3 - wydrukuj ciag tekstowy "str" "n" razy - w petli for

# - 4 - korekcja ASCII - zmodyfikuj "x" w ciagu "str" tak,
# aby w jego miejscu drukowana byla wartosc licznika iteracji "counter"

# - 1 - zrobione - przekaz argumenty i wywolaj System Call nr 1 (sys_write)
mov	$iterations, %rcx
loop_start:

push	%rcx

mov	%cl, %al
add	$48, %al
mov	%al, str+13

mov	$sys_write , %eax
mov	$stdout , %edi
mov	$str , %esi
mov	$strlen , %edx
syscall

pop	%rcx

dec	%rcx
jnz	loop_start


# - 2 - zrobione -  przekaz argumenty i wywolaj System Call nr 60 (sys_exit)

mov	$sys_exit , %eax
xor	%edi , %edi
syscall

# Koniec programu

