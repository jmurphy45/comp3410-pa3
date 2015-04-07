#‎Babylonian method: The babylonian method is one of the many method to approximate Roots.
#The method uses the following C code:
#	float x = n;
#  	float y = 1;
#  	float e = 0.000001; /* e decides the accuracy level*/
#  	while(x - y > e)
#  	{
#  	  x = (x + y)/2;
#  	  y = n/x;
#  	}

.data
StartingStatment:	.asciiz	   "Please enter a number that you would like to find the square root of: \n"
Answer:		.asciiz	   "Your answer is: \n"
NumberofIterations: .asciiz "Please enter the number of Iteration. Example: 100\n"
ErrorQ: .asciiz "Pleae enter a number which is greater than zero!"
Ended: .asciiz "\n--Ended--"
Y: .float 1.0
SmallValue: .float 0.000001
Two:		.float 2.0


.text
.globl	main
main:

#printing message for StartingStatment
li	$v0, 4
la	$a0, StartingStatment		
syscall	

li	$v0, 6			
syscall			
mov.s $f5, $f0		#$f5 have value
mov.s $f9, $f5		##### convert float to int
cvt.w.s $f9, $f9
mfc1 $t1, $f9		#converted int stored in t1

blt $t1,0,ErrorG

l.s $f3, Y
l.s $f1, SmallValue
l.s $f9, Two

j FindSqaureRoot

FindSqaureRoot:

#$f5 	#x
#f3		 #y 
#f1		#SmallValue
mov.s $f11,$f5 #n

#while(x - y > e)
#  {
#    x = (x + y)/2;
#    y = n/x;
#  }
#  return x;

SubtractionChecking:
sub.s $f2,$f5,$f3				#x-y

c.lt.s  $f2,$f1         		# is (x-y) < e?
bc1t    Print           		#yes:  print(Move towards answer)

c.lt.s  $f1,$f2         	 	# is (x-y) > e?
bc1t    Loop          		 	# yes: Continue with the #loop!


Loop:
add.s $f7,$f5,$f3				#x+y
div.s $f5,$f7,$f9				#divding it by 2
div.s $f3,$f11,$f5				#n/x
j SubtractionChecking

#Printing the answer!
Print:
mov.s $f12,$f5
li $v0,2
syscall

j EndProgram

#Error that is generated when a number is less than 0!
ErrorG:
li	$v0, 4
la	$a0, ErrorQ		
syscall
	
j EndProgram

EndProgram:
	li	$v0, 4			# printing message for xvalue
	la	$a0, Ended		
	syscall		
	
	li $v0,10
	syscall