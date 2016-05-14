#--------------------------------------
# Multiply Algorithm (asm file)
#--------------------------------------

# set the address of the start of program
org 0x0000

# set the address of stack pointer
ori  $29, $0, 0xFFFC

# set two values
ori  $1, $0, 6
ori  $2, $0, 8

# push $1 and $2 to stack
push $1
push $2

# pop $1 and $2 to new addr
pop $3 #$2
pop $4 #$1

# Multiply is added 'a' to itself 'b' times
ori $5, $0, 0

MULT: beq $3, $0, EXIT
      add $5, $5, $4
      addi $3, $3, -1
      j MULT

EXIT: halt



