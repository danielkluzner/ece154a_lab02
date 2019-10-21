##############################################################################
# File: div.s
# Skeleton for ECE 154a project
##############################################################################
	.data
student:
	.asciiz "Student" 	# Place your name in the quotations in place of Student
	.globl	student
nl:	.asciiz "\n"
	.globl nl


op1:	.word 5				# divisor for testing
op2:	.word 20			# dividend for testing


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

addi $t8,$0,0      # counter for the loop
addi $t9,$0,8      # limit for the loop

# a0 = B
# a1 = A

add $s1,$0,$0     # R'
add $s2,$0,$0     # R
add $s3,$0,$0     # D
add $s4,$0,$0     # Q
addi $s5,$0,128      # 1 digit checker



loop:
    beq $t8, $t9, done
    
    sll $s1, $s1, 1 # shift R'
    and $t7, $s5, $a1 # next bit of A
    beq $t7, $s5, onebit
        # if A-bit == 0
        add $s2, $s1, $0
        j skip1
    onebit:
        # if A-bit == 1
        addi $s2, $s1, 1
    skip1:
    subu $s3, $s2, $a0 # D = R - B
    slt $t5, $s3, $0
    bne $t5, $0, yes
        # if D >= 0
        sll $s4, $s4, 1
        addi $s4, $s4, 1
        add $s1, $s3, $0
        j skip2
    yes: # if D < 0
        sll $s4, $s4, 1
        add $s1, $s2, $0
    skip2:

    srl $s5, $s5, 1 # shift digit checker

    addi $t8, $t8, 1
    j loop

done: 
    add $s2, $s1, $0 # R = R'
    add $a3, $s2, $0
    add $a2, $s4, $0


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