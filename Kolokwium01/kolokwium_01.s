#################################################################
#
# Program ma przeszukac tablice i wydrukowac w oknie terminala:
#
# (na maks. 7 punktow)
#
# - maksymalna wartosc przechowywana w tablicy (typy 16 bitowe, ze znakiem),
#
# kontynuacja - (na maks. 10 punktow):
#
# - dodatkowo - numer elementu (indeks), w ktorym przechowywana jest najwieksza wartosc.
#
# Zadanie ratunkowe - na maks. 4 punkty: wydrukowanie tekstu "napis"
# np. z wartosciami podanymi przez prowadzacego (funkcja printf, wartosci przekazane w rejestrach).
#
#################################################################



.data

.equ		liczba_elementow, 16

napis:		.asciz	"max = %hd w elemencie %hu\n"

tablica:	.word	64, 4, 3, 3, 0, 8, 7, 10, -1, 8 ,8 ,8 ,-8, 4, 15, 72

element:	.long	0
max:		.long	0


#################################################################

.text
.global main

main:
sub	$8,%rsp


# Przykladowe etapy zadania.

# Inicjuj zmienne wartosciami poczatkowymi.
xor	%ecx, %ecx

petla:

# Usun bledy i odczytaj w prawidlowy sposob element tablicy.

mov	tablica(,%ecx,2) , %ax
# Sprawdz czy odczytana z tablicy wartosc jest wieksza od najwiekszej dotychczas znalezionej,
# jesli tak - zaktualizuj odpowiednie zmienne.
cmp	max, %ax
jle	next

mov	%ax, max
mov	%ecx, element

# Zaktualizuj licznik iteracji, sprawdz warunek zakonczenia petli.
next:
inc	%ecx
cmp	$liczba_elementow, %ecx
jne	petla

koniec:

# Wyswietl wynik (printf) zgodnie z formatowaniem ciagu "str"
# przekazujac argumenty zgodnie ABI.
mov	$napis, %rdi
mov	max, %esi
mov	element, %edx
xor	%al, %al
call	printf

# Koniec funkcji main.

add	$8,%rsp
xor	%eax,%eax
ret

#################################################################
