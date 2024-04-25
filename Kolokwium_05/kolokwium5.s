#################################################################
#
#Na maks. 7 punktow:
#program ma wykonac dzialanie (a + b + c + d ) / 8 i wyswietlic wynik.
#
#Liczby a, b i c (32 bitowe ze znakiem) maja zostac przekazane
#jako parametry z linii komend.
#
#Na maks. 10 punktow - dopisac obsluge bledow.
#Np. jak liczba przekazanych parametrow jest rozna od 4
#wyjdz po wydrukowaniu odpowiedniego komunikatu.
#
##Zadanie ratunkowe - na maks. 4 punkty: wydrukowanie tekstu "str"
#z wartosciami (w rejestrach) podanymi przez prowadzacego (funkcja "printf").
#
#################################################################

.globl    main

.data

str:        .asciz    "(%d + %d + %d + %d) / 8 = %d\n"
err:        .asciz     "Zbyt duzo argumentow\n"

arg_a:        .long    0
arg_b:        .long    0
arg_c:        .long    0
arg_d:        .long    0
result:       .long    0

#################################################################

.text

main:

sub    $8,%rsp

#Przykladowe etapy zadania.
#Sprawdz warunek:
#jezeli liczba parametrow jest rozna od 5 to wyjdz
#wydrukuj odpowiedni komunikat i wyjdz.
#Konwersja string->int przekazanych jako parametry liczb.
#program:

# argc
cmp	$5, %edi
jne	error

mov	8(%rsi), %rdi
call	atoi32
mov	%rax, arg_a
mov	16(%rsi), %rdi
call	atoi32
mov	%rax, arg_b
mov	24(%rsi), %rdi
call	atoi32
mov	%rax, arg_c
mov	32(%rsi), %rdi
call	atoi32
mov	%rax, arg_d

mov	arg_a, %r9d
add	arg_b, %r9d
add	arg_c, %r9d
add	arg_d, %r9d

shr	$3, %r9d

mov	$str, %rdi
mov	arg_a, %esi
mov	arg_b, %edx
mov	arg_c, %ecx
mov	arg_d, %r8d
#mov	$1, %r9d
xor	%eax, %eax
call	printf
#Wykonaj dzialanie (a + b + c + d) / 8.
#Wyswietl wynik (printf) zgodnie z formatowaniem ciagu "str"
#przekazujac argumenty zgodnie ABI.
error:
mov	$err, %rdi
xor	%eax, %eax
call	printf

#Koniec funkcji main.

koniec:
add    $8,%rsp
xor    %eax,%eax
ret

#################################################################
#sprobuj sobie to przekopiowac do notatnika i sprawdz czy dziala

.type   atoi32, @function

atoi32:
        PUSH    %rcx
        xor     %rax, %rax      # suma
        xor     %rcx, %rcx      # używane do sprawdzenia czy znak jest ujemny
        movzx   (%rdi), %rdx
        test    %rdx, %rdx      # sprawdzenie czy pierwszy znak = '\0'
        jz      .done
        cmp     $'-', %rdx      # sprawdzenie czy ujemna
        je      .process_sign
.next_digit:
        movzx   (%rdi), %rdx
        test    %rdx, %rdx      # sprawdzanie czy znak = '\0'
        jz      .done
        sub     $'0', %rdx      # zamienienie znaku na numer ('1'-'0' = 1, '9'-'0' = 9 itp)
        imul    $10, %rax       # pomnożenie przez 10 wyniku (zrobienie miejsca dla aktualnego znaku)
        add     %rdx, %rax
        inc     %rdi            # nastepny znak
        jmp     .next_digit
.done:
        test    %rcx,   %rcx
        jz      .skip_negation
        neg     %rax
.skip_negation:
        POP     %rcx
        ret
.process_sign:
        inc     %rdi            # następny znak
        mov     $1, %rcx        # zaznaczenie flagi, że liczba ujemna
        jmp     .next_digit
