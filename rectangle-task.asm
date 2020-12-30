.data
	prompt: 		.asciiz "Please enter four numbers for rectangle: \n"
	rectConfirmation: .asciiz "It's a rectangle\n"
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
	
	c.eq.s $f1, $f3
	bc1t checkOther2
	
	li $v0, 10
	syscall
	
		checkOthers:
			c.eq.s $f3, $f4
			bc1t printConfiramtion
	
		checkOther2:
			c.eq.s $f2, $f4
			bc1t printConfirmation2
	
		printConfiramtion:
			li $v0, 4
			la $a0, rectConfirmation
			syscall
			li $v0, 10
		syscall
	
		printConfirmation2:
			li $v0, 4
			la $a0, rectConfirmation
			syscall
	
