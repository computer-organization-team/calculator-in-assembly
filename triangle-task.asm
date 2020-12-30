.data
	prompt: 				.asciiz "Please enter three numbers for trinangle: \n"
	triConfirmation:	.asciiz "It's a triangle \n"
	errorMessage: 	.asciiz "Not a triangle \n"
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
	
	# First Comparable
	add.s $f4, $f1, $f2
	# Second Comparable
	add.s $f5, $f2, $f3
	# Third Comparable
	add.s $f6, $f1, $f3

	c.le.s $f3, $f4
	bc1t firstCheck
	
	li $v0, 10
	syscall
	
		firstCheck:
			c.le.s $f2, $f5
			bc1t secondCheck
		
		secondCheck:
			c.le.s $f1, $f6
			bc1t exit
		
		exit:
			# Display message to user.
			li $v0, 4
			la $a0, triConfirmation
			syscall
			
			li $v0, 10
			syscall