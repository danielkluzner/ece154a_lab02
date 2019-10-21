##############################################################################
# File: mult.s
# Skeleton for ECE 154a project
##############################################################################

	.data
student:
	.asciiz "Benjamin Liu, Daniel Kluzner" 	# Place your name in the quotations in place of Student
	.globl	student
nl:	.asciiz "\n"
	.globl nl


op1:	.word 7				# change the multiplication operands
op2:	.word 4			# for testing.


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
	jal	multiply		# go to multiply code

	jal	print_result		# print operands to the console

					# Usual stuff at the end of the main
	lw	$ra, 0($sp)		# restore the return address
	addi	$sp, $sp, 4
	jr	$ra			# return to the main program


multiply:
##############################################################################
#s0 = a0
#s1 = a1
#s2 = temp bool
#s3 = 1 digit checker

addi $s0,$a0,0     # first input 
addi $s1,$a1,0     # second input
addi $a2,$0,0      # Multiplication result
addi $s3,$0,1      # 1 digit checker
loop:
    and $s2,$s1,$s3
    bne $s2,$s3,next_bit
    addu $a2,$a2,$s0  # if (multiplicand & 1) result += multiplier << shift
next_bit:
    sll $s0,$s0,1     #  multiplier <<= 1
    sll $s3,$s3,1     #  digit checker <<= 1
    bne $s3,$0,loop
##############################################################################


##############################################################################
# Do not edit below this line
##############################################################################
	jr	$ra



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

	jr $ra