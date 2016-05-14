#--------------------------------------
# Count Days (asm file)
#--------------------------------------

# set the address of the start of program
org 0x0000

# set the address of stack pointer
ori $29, $0, 0xFFFC

# set current date
ori $1, $0, 6      #day {1..31}
ori $2, $0, 1       #month {1..12}
ori $3, $0, 2016    #year (all four digits)

# Days = CurrentDay + (30 * (CurrentMonth - 1)) + 365 * (CurrentYear - 2000)

addi $3, $3, -2000
addi $2, $2, -1

ori $5, $0, 365
ori $6, $0, 30

Y_MULT: beq $5, $0, M_MULT
        add $7, $7, $3
        addi $5, $5, -1
        j Y_MULT

M_MULT: beq $6, $0, SUM
        add $8, $8, $2
        addi $6, $6, -1
        j M_MULT

SUM: add $1, $1, $7
     add $1, $1, $8

halt
