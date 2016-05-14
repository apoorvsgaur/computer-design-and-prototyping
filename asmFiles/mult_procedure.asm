#--------------------------------------
# Multiply Procedure (asm file)
# Multiply is added 'a' to itself 'b' times
#--------------------------------------

# set the address of the start of program
org 0x0000

# set the address of stack pointer
ori  $29, $0, 0xFFFC

# set the end loop condition
ori $1, $0, 0xFFF8

# set num of variables
ori $2, $0, 2
ori $3, $0, 3
ori $4, $0, 2
#ori $10, $0, 2
#ori $11, $0, 5

# push variables to stack
push $2
push $3
push $4
#push $10
#push $11

ori $8, $0, 0

MAIN: beq $29, $1, STOP
      pop $5
      pop $6
      j MULT

MULT: beq $5, $0, EXIT
      add $8, $8, $6
      addi $5, $5, -1
      j MULT

EXIT: push $8
      ori $8, $0, 0
      j MAIN

STOP: pop $8
      halt



