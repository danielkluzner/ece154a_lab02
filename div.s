##############################################################################
# File: div.s
# Skeleton for ECE 154a project
##############################################################################

	.data
student:
	.asciiz "Benjamin Liu, Daniel Kluzner" 	# Place your name in the quotations in place of Student
	.globl	student
nl:	.asciiz "\n"
	.globl nl


op1:	.word 7				# divisor for testing
op2:	.word 19			# dividend for testing


	.text

	.globl main
main:					# main has to be a global label
	addi	$sp, $sp, -4		# Move the stack pointer
	sw 	$ra, 0($sp)		# save the return address

	move	$t0, $a0		# Store argc
	move	$t1, $a1		# Store argv
				
	li	$v0, 4			# print_str (system call 4)
	la	$a0, student		# takes the address of string as an argument 
	syscall	

	slti	$t2, $t0, 2		# check number of arguments
	bne     $t2, $zero, operands
	j	ready

operands:
	la	$t0, op1
	lw	$a0, 0($t0)
	la	$t0, op2
	lw	$a1, 0($t0)
		

ready:
	jal	divide			# go to multiply code

	jal	print_result		# print operands to the console

					# Usual stuff at the end of the main
	lw	$ra, 0($sp)		# restore the return address
	addi	$sp, $sp, 4
	jr	$ra			# return to the main program


divide:
##############################################################################
# Your code goes here.
# Should have the same functionality as running
#	divu	$a1, $a0
#	mflo	$a2
#	mfhi	$a3
##############################################################################


##############################################################################
# Do not edit below this line
##############################################################################
	jr	$ra


# Prints $a0, $a1, $a2, $a3
print_result:
	move	$t0, $a0
	li	$v0, 4
	la	$a0, nl
	syscall

	move	$a0, $t0
	li	$v0, 1
	syscall
	li	$v0, 4
	la	$a0, nl
	syscall

	li	$v0, 1
	move	$a0, $a1
	syscall
	li	$v0, 4
	la	$a0, nl
	syscall

	li	$v0, 1
	move	$a0, $a2
	syscall
	li	$v0, 4
	la	$a0, nl
	syscall

	li	$v0, 1
	move	$a0, $a3
	syscall
	li	$v0, 4
	la	$a0, nl
	syscall

	jr $ra
