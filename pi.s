# ==============================
#
# Author: Bartosz Bien
#
# This file allows to compute the apprixomated value of Pi
# More details in the README.md file
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
# my_pi - the function computes Pi from the Leibniz formula
#
#	Input:		loop_counter - counter of iterations
#	Output:		None, but the rezult of computations divided by 4 is stored in the register %r13
#
# ===============================

	.type my_pi, @function

my_pi:
	# starting conditions
	mov loop_counter, %rax	
	mov $2, %rbx
	xor %rdx, %rdx
	div %rbx
	mov %rax, %r15	# licznik petli

	mov $1, %r14	# mianownik
	xor %r13, %r13	# 4*pi -> wynik
loop:
	# increment counter 100000 times
	# div
	mov %r14, %rbx
	mov $100000, %rax 
	xor %rdx, %rdx
	div %rbx

	# add
	add %rax, %r13

	# denominator += 2
	mov $2, %r8	
	add %r8, %r14

	# div
	mov %r14, %rbx
	mov $100000, %rax
	xor %rdx, %rdx
	div %rbx

	#sub
	sub %rax, %r13

	# denominator += 2
	mov $2, %r8
	add %r8, %r14

	dec %r15
	jnz loop
end:
	# times 4
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