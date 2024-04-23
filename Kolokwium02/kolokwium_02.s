###############################################################
#
# Na maks. 10 punktow:
#
# Program ma obliczyc i wydrukowac w oknie terminala
# srednia wartosc elementow przechowywanych w tablicy (liczby calkowite, 16 bitowe, bez znaku).
#
# Zadanie ratunkowe - na maks. 4 punkty: wydrukowanie tekstu "napis"
# np. z wartosciami podanymi przez prowadzacego (funkcja printf, wartosci przekazane w rejestrach).
#
#################################################################

.globl	main

.data

.equ	liczba_elementow, 16

napis:		.asciz	"avg = %hd\n"

tablica:	.word	64, 4, 3, 3, 0, 8, 7, 10, 1, 8 ,8 ,8 , 8, 4, 15, 72

avg:		.word	0

#################################################################

.text

main:
sub	$8,%rsp


# Przykladowe etapy zadania.

# Inicjuj zmienne wartosciami poczatkowymi.

xor	%ecx, %ecx

petla:

# Usun bledy i odczytaj w prawidlowy sposob element tablicy.

mov	tablica(,%ecx,2) , %ax


mov	avg, %dx
add	%ax, %dx
mov	%dx, avg
# Zaktualizuj licznik iteracji, sprawdz warunek zakonczenia petli.

inc	%ecx
cmp	$liczba_elementow, %ecx

jne	petla

koniec:

# Oblicz srednia.

# Wyswietl wynik (printf) zgodnie z formatowaniem ciagu "str"
# przekazujac argumenty zgodnie ABI.
mov	$napis, %rdi

xor	%dx, %dx
mov	avg, %ax
mov	$liczba_elementow, %bx
test	%bx, %bx
jz	handle_zero

div	%bx
movzx	%ax, %esi
call	printf

# Koniec funkcji main.
handle_zero:
add	$8,%rsp
xor	%eax,%eax
ret

################################################################
