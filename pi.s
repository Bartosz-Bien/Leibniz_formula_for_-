# ==============================
#
# Imie:		Bartosz
# Nazwisko:	Bien
# Nr albumu:	407460
# Grupa:	Inzynieria Obliczeniowa, gr. 1
#
# =============================
#
# To compile:	gcc [-no-pie] -o pi pi.s
# To run:	./pi
#
# ==============================

	.data
fmt:
	.string	"PI = %d,%d\n"

loop_counter:
	.quad	0
	
# ===============================

	.text
	.global main

# ===============================

main:
	mov $10000, %rax
	mov %rax, loop_counter
        call my_pi

        xor %rdi, %rdi
        call exit
        ret

# ===============================
#
# my_pi - oblicza liczbe pi ze wzoru Leibniza
#
#	Wejscie:	loop_counter - liczba przejsc petli
#	Wyjscie:	Explicit brak, ale rezultat obliczen podzielony przez 4 w %r13
#
# ===============================

	.type my_pi, @function

my_pi:
	# warunki poczatkowe
	mov loop_counter, %rax	
	mov $2, %rbx
	xor %rdx, %rdx
	div %rbx
	mov %rax, %r15	# licznik petli

	mov $1, %r14	# mianownik
	xor %r13, %r13	# 4*pi -> wynik
loop:
	# zwiekszam licznik o 10000
	# div
	mov %r14, %rbx
	mov $100000, %rax 
	xor %rdx, %rdx
	div %rbx

	# add
	add %rax, %r13

	# mianownik += 2
	mov $2, %r8	
	add %r8, %r14

	# div
	mov %r14, %rbx
	mov $100000, %rax
	xor %rdx, %rdx
	div %rbx

	#odejmij
	sub %rax, %r13

	# mianownik += 2
	mov $2, %r8
	add %r8, %r14

	dec %r15
	jnz loop
end:
	# razy 4
	mov %r13, %rbx
	mov $4, %rax
	xor %rdx, %rdx
	mul %rbx

#	mov %rax, %rax		# to improve readability
	mov $100000, %rbx
	xor %rdx, %rdx
	div %rbx

	mov $fmt, %rdi
	mov %rax, %rsi
#	mov %rdx, %rdx		# to improve readability
	xor %rax, %rax
	call printf 

	ret
