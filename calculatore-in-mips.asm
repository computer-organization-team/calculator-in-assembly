.data
array: .space 400
ask: .asciiz "please enter the size of list !? (no more than 10 numbers!): "
intask: .asciiz "Enter an Integer: "
min: .asciiz "The minimum number in the list is: "
max: .asciiz "The maximum number in the list is: "
display: .asciiz "List  is : "
space: .asciiz " "
nextline: .asciiz "\n"
prompt: 		.asciiz "Please enter four numbers for rectangle: \n"
rectConfirmation: .asciiz "It's a rectangle\n"
prompt2: 		.asciiz "Please enter four numbers for square: \n"
message: 	.asciiz "They are equal\n"
sqConfirmation: .asciiz "It's a square\n"
zero: 		.double 0.0
prompt3:       .asciiz "Please enter three numbers for trinangle: \n"
triConfirmation:	.asciiz "It's a triangle \n"
errorMessage: 	.asciiz "Not a triangle \n"

startMessage:          .asciiz "Enter the value of x (in degrees) \n"
	endMessage:	       .asciiz "Sum of the sine series : \n"
	
	pi:                           .float 3.14
	degree :               	      .float 180
	term  :                	      .float 1
	denominator :          	      .float 1

        sinx :                 	      .float 1
	radian :             	      .float 1
	
	InputMessage : .asciiz "Enter angle in degree\n" 

PI:            .float 3.14
tempNum:       .float 180   # help when converting angle from degree to radian 
res:           .float 1     # contain the result    
sign:          .float 1     # contain the sign of taylor series 
fact:          .float 1     # contain factorial in taylor series
pow:           .float 1     # contain power in taylor series
negative:      .float -1    # help when converting the sign 

resultMessage : .asciiz "\nresult is: "	

	
	
.text

   .globl main

	main:
	li $v0, 4
	la $a0, intask
	syscall
	li $v0 ,5
	syscall
	move $t6,$v0
	beq $t6,0,division
	beq $t6,1,subtract
	beq $t6,2,power
	beq $t6,3,MinAndMaxNumber
        beq $t6,4,cosX
	beq $t6,5,sinX
        beq $t6,6,factorization
        beq $t6,7,rectangle
        beq $t6,8,square
        beq $t6,9,triangle
      

	li $v0,10                # End Of Program
   	 syscall  
 #------------------------------------end main --------------------------------------- 
 #------------------------------------division------------------------------------------
 division:
 	li $v0, 4
	la $a0, intask
	syscall
	li $v0 ,5
	syscall
	move $t0,$v0
	li $v0, 4
	la $a0, intask
	syscall
	li $v0 ,5
	syscall
	move $t1,$v0
	div $s0,$t0,$t1
	
	li $v0,1
	move $a0,$s0
	syscall
	
 jr $ra 

  #------------------------------------------subtract---------------------------
 subtract:
	 li $v0, 4
	la $a0, intask
	syscall
	li $v0 ,5
	syscall
	move $t0,$v0
	li $v0, 4
	la $a0, intask
	syscall
	li $v0 ,5
	syscall
	move $t1,$v0
	sub $s0,$t0,$t1
	li $v0,1
	move $a0,$s0
	syscall
	
	
 jr $ra 
 #----------------------------------------------------power-----------------------
 
 power:
        li $v0, 4
 	la $a0, intask
	syscall
	li $v0 ,5
	syscall
	move $t0,$v0
	li $v0, 4
	la $a0, intask
	syscall
	li $v0 ,5
	syscall
	move $t1,$v0
	add $t2,$t0,$t2
	subi $t1,$t1,2
 	Loop0:
		
		bgt $t4,$t1, exitLoop0
		mul $t0,$t2,$t0
		addi $t4,$t4,1
		
		
		j Loop0		#loop
	exitLoop0:
	li $v0 ,1
	move $a0,$t0
	syscall
 jr $ra	
  #---------------------------------------------min and max--------------------------   
MinAndMaxNumber:

    la $a0, ask             #ask for the size of list 
    li $v0, 4
    syscall

    li $v0, 5               #store that number
    syscall
    move $t1,$v0            #size of my list stored in registor $t1

    la $t0, array           #load address of our list
    li $t2, 0               #i = 0
    lw $t3,($t0)            #pointer to load the first element in list(initialize min = array[0])
    lw $t4,($t0)            #pointer to load the first element in list(initialize max = array[0])

    #making while loop to take the numbers from the users  
    
   while:
    la $a0, intask          #Asking user for integer
    li $v0, 4
    syscall

    li $v0, 5               #storeing this integer
    syscall
    sw $v0, ($t0)           #store that int in the my list


   end:    
    #ending of the loop
    add $t0, $t0, 4         #increment the array to the next index
    add $t2, $t2, 1         #increment the i by 1
    blt $t2, $t1,while      #branch to while loop if i < size of array

  endw:
    la $a0,display          # Display "list is: "
    li $v0,4            
    syscall

    li $t0, 0               # initilize list index value back to 0
    li $t2, 0                # initial size i back to zero
    la $t0, array            # load address of list back into $t0

 sprint:
    lw $t6,($t0)            #load word into temp $t2
    move $a0, $t6           #store it to a safer place
    li $v0, 1               #print it out
    syscall

    la $a0,space            # Display " "
    li $v0,4            
    syscall

    add $t0, $t0, 4         #increment the list to the next index
    add $t2, $t2, 1         #increment the i by 1 (i++)

    blt $t2, $t1,sprint     #branch to while if i < size of array

    li $t2, 0                # initial size i back to zero
    la $t0, array            # load address of list back into $t0
    add $t0, $t0, 4         #increment the list to the next index
    add $t2, $t2, 1         #increment the i by 1 (i++)


 loop:  lw $t8,($t0)             # t8 = next element in list
    bge $t8, $t3, notMin     #if list element is >= min goto notMin
    move $t3,$t8             #min = array[i]
    j notMax

 notMin: ble $t8,$t4, notMax         #if list element is <= max goto notMax
    move $t4,$t8             #max = array[i]

  notMax:    add $t2,$t2,1            #incr counter
    add $t0,$t0, 4           #go up in index
    blt $t2, $t1,loop        #if counter < size, go to loop

  eprint:
    la $a0,nextline          # Display "\n"
    li $v0,4            
    syscall

    la $a0,min               # Display "min number is "
    li $v0,4            
    syscall

    move $a0, $t3            #displays min number in array
    li $v0,1
    syscall

    la $a0,nextline          # Display "\n"
    li $v0,4            
    syscall

    la $a0,max               # Display "max number is "
    li $v0,4            
    syscall

    move $a0, $t4            #displays max number in array
    li $v0,1
    syscall
    jr $ra
    
    
    
    #---------------------------------cos(x)---------------------------------
cosX:
lwc1 $f2,PI
   lwc1 $f3,tempNum
   lwc1 $f4,res
   lwc1 $f5,sign
   lwc1 $f6,fact
   lwc1 $f7,pow
   lwc1 $f8,negative 
# Display Input Message
   li $v0,4
   la $a0,InputMessage
   syscall
 
   li $v0,6  # read float from user  
   syscall
   mul.s $f12,$f0,$f2    # store angle_degree*PI in $f12 
   div.s $f9,$f12,$f3    # divide value from $f12 /180 to convert angle from degree to radian 
   addi $t1,$0,1         # intialize counter i = 1 and store it in temporery register $t1
   loop1: 
      bgt $t1,5,exit     # condition of the loop (while(i<=5))
      mul.s $f5,$f5,$f8  # sign =sign*-1; 
      mul $t2,$t1,2      # (2 * i)   
      addi $t3,$t2,-1    # (2 * i - 1)
      mul $t2,$t2,$t3    # (2 * i - 1) * (2 * i);
      #####################
      mtc1 $t2, $f13     # convert $t2 from int to float and store in $f13
      cvt.s.w $f13, $f13    
      ####################
      mul.s $f6,$f6,$f13 # fact = fact * (2 * i - 1) * (2 * i);
      mul.s $f7,$f7,$f9  # pow = pow * angle_radian 
      mul.s $f7,$f7,$f9  # pow = pow * angle_radian  
      mul.s $f20,$f5,$f7 # set (sign * pow) in $f20 
      div.s $f21,$f20,$f6# divide value in $f20 to fact and store result in $f21 
      add.s $f4,$f4,$f21 # add value of $f21 to res (res = res +  (sign * pow)  / fact);  
      addi $t1,$t1,1     # incerement counter i in $t1 by 1 (i++) 
      j loop1  
   exit:   #label caled when ending the while looop
# Display result Message   
   li $v0,4
   la $a0,resultMessage
   syscall
# Display result value   
   li $v0,2
   mov.s $f12,$f4
   syscall 
# terminite program
   li $v0,10
   syscall 
    jr $ra
    
    # -----------------------------------sin(x)------------------------------------
 sinX:
     # Display start Message
	li $v0, 4
	la $a0, startMessage
	syscall
	
	# load float variables from coprocessor 1 
	
	lwc1 $f3,pi
	lwc1 $f4,degree
	lwc1 $f5,term
	lwc1 $f6,denominator	
	lwc1 $f7,negative
	lwc1 $f8,sinx
	lwc1 $f9,radian
	
	
	# read float from user 
	li $v0, 6	
	syscall
	
	#Convert From Degree To Radian
	mul.s $f10,$f0,$f3 # degree*PI
	div.s $f9,$f10,$f4 #radian
	
	#initialization
	mov.s $f5,$f9
	mov.s $f8,$f9
	
	mul.s $f9,$f9,$f9  #x^2	
	
	addi $t1,$0,1 #n=1
	while2:
		bgt $t1,5,exit1     # (while(n<=5))
		
		#denominator 2 * n * (2 * n + 1)
	        mul $t2,$t1,2
		addi $t3,$t2,1
		mul $t2,$t2,$t3
		
		#convert t2 to flaot
		mtc1 $t2, $f13
		cvt.s.w $f13, $f13 
		
		mov.s $f6,$f13	
		
		#term = (-)*(term) * (x^2) / denominator
		mul.s $f5,$f5,$f7  #-term 
		mul.s $f20,$f5,$f9  #term * x^2			
		div.s $f21,$f20,$f6  #
		
		mov.s $f5,$f21
	
		#sinx = sinx + term
		add.s $f8,$f8,$f5		
		
		addi $t1,$t1,1 	   #n++	
		j while2
	exit1:
	# Display result Message   
   	li $v0,4
   	la $a0,endMessage
  	syscall
	# Display result value   
   	li $v0,2
   	mov.s $f12,$f8
   	syscall 
	# terminite program
	li $v0,10
   	syscall
   jr $ra 
   
   	
   		
   #-----------------------------------------factorization fun	------------------------------			
factorization:

    addi $s0, $zero, 2
	addi $s1, $zero, 5


	twoFactorsLoop:
		# (if the number is not dividable by 2)
		div  $s1, $s0
		mfhi $t0
		bnez $t0, exit2FactorsLoop
		
		# Print 2
		li $v0, 1
		add $a0, $zero, $s0
		syscall
		li $v0, 4
		la $a0, nextline
		syscall
		
		div $s1, $s1, $s0 	# divide the number by 2
		j twoFactorsLoop		#loop
	exit2FactorsLoop:
	
	
	
	
	
	add $t0, $zero, $s1		# x = n
	addi $t3, $zero, 0		# i=0
	
	rootLoop:
		# x = (x + n / x) / 2;
		div $t1, $s1, $t0
		add $t2, $t0,$t1
		div $t0, $t2, $s0
		
		addi $t3, $t3, 1	# i++
		
		# if (i < (n/2))
		div $t4, $s1, $s0
		blt $t3, $t4, rootLoop
		
		# else
		add $s2, $zero, $t0
		
		



	add $t0, $zero, $s1		# x = n
	addi $t3, $zero, 3		# i=3

	forLoop:
		# if (i > sqrt(n))
		bgt $t3, $s2, exitForLoop
		
		whileLoop:
			# if (x%i != 0)
			div $t0, $t3
			mfhi $t1
			bnez $t1, exitWhileLoop
			
			# Print i
			li $v0, 1
			add $a0, $zero, $t3
			syscall
			li $v0, 4
			la $a0, nextline
			syscall
		
			# x = x/i
			div $t0, $t0, $t3
			
			j whileLoop
		
		exitWhileLoop:
	
	addi $t3, $t3, 2		# i+=2
	j forLoop
	
	exitForLoop:
	
	
	# if (n <= 2) 
	ble $t0, $s0, exit2
	
	li $v0, 1
	add $a0, $zero, $t0
	syscall
	
	exit2:
	   jr $ra 
	#-----------------------------------rectangle detection ------------------------ 
	rectangle:
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
       jr $ra 
       #---------------------square fun+-------------------------------------
square:
# Display message to user.
	li $v0, 4
	la $a0, prompt2
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
	bc1t checkOthers2
	
	li $v0, 10
	syscall
	
	checkOthers2:
		c.eq.s $f3, $f4
		bc1t printConfiramtion2
	
	printConfiramtion2:
		li $v0, 4
		la $a0, sqConfirmation
		syscall
		jr $ra
		
		
		
	#-------------------------triangle fun-----------------------
	triangle:
	# Display message to user.
	li $v0, 4
	la $a0, prompt3
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
			bc1t exit3
		
		exit3:
			# Display message to user.
			li $v0, 4
			la $a0, triConfirmation
			syscall
			
			li $v0, 10
			syscall 
	jr $ra
