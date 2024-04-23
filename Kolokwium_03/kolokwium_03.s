################################################################
#
# Na maks. 10 punktow:
#
# program ma scalic ciagi str1 i str3 zapisujac calosc do str2:
# 
# "abcdefgh\0" + "12345678\0" -> "abcdefgh12345678\0".
#
# Nalezy wydrukowac ciag str2 w oknie terminala.
#
# Zadanie ratunkowe - na maks. 4 punkty: wydrukowanie ciagow str1 i str 2
# funkcja System Call.
#
#################################################################

.globl	_start

.data

str1:		.asciz	"abcdefgh"
str2:		.asciz	"----------------\n"
str3:		.asciz	"12345678"

#################################################################

.text

_start:

# Przykladowe kroki.

# Inicjuj zmienne wartosciami poczatkowymi.
xor	%ecx, %ecx

petla1:

# Usun bledy i odczytaj w prawidlowy sposob elementy ciagow.

mov	str1(,%ecx,1) , %al
mov	str3(,%ecx,1) , %bl

# Sprawdz warunek zakonczenia petli - znaku konca ciagu (NULL).
cmp	$0, %al
je	koniec

# Zapisz kopiowane elementy w miejsca docelowe.
mov	%al, str2(,%ecx,1)
add	$8, %ecx
mov	%bl, str2(,%ecx,1)
sub	$8, %ecx

# Zaktualizuj licznik elementow.
inc	%ecx
jmp	petla1

koniec:

# Wyswietl wynik - ciag "str2" wywolujac System Call.
mov	$2, %eax
mul	%ecx
mov	%eax, %ecx
inc	%ecx

mov	$1, %eax
mov	$1, %edi
mov	$str2, %esi
mov	%ecx, %edx
syscall

# Wywolaj System Call nr 60 - EXIT
mov	$60, %eax
xor	%edi, %edi
syscall

#################################################################
