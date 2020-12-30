.data
	prompt: 		.asciiz "Please enter four numbers for square: \n"
	message: 	.asciiz "They are equal\n"
	sqConfirmation: .asciiz "It's a square\n"
	zero: 		.double 0.0
.text
	main:
	# Display message to user.
	li $v0, 4
	la $a0, prompt
	syscall
	
	# Get float first number from user
	li $v0, 6
	syscall
	add.s $f1, $f1, $f0
	
	# Get float second number from user
	li $v0, 6
	syscall
	add.s $f2, $f2, $f0
	
	# Get float third number from user
	li $v0, 6
	syscall
	add.s $f3, $f3, $f0
	
	# Get float fourth number from user
	li $v0, 6
	syscall
	add.s $f4, $f4, $f0
	
	
	c.eq.s $f1, $f2
	bc1t checkOthers
	
	li $v0, 10
	syscall
	
	checkOthers:
		c.eq.s $f3, $f4
		bc1t printConfiramtion
	
	printConfiramtion:
		li $v0, 4
		la $a0, sqConfirmation
		syscall
