#----------------------------------------------------------
# LL-SC Parallel Program
#
# PC0 produces a set number of random numbers and pushes
# them to the stack.
#
# PC1 consumes the same numbers from the stack, and finds
# the max, min, and average of the random numbers
#----------------------------------------------------------

#----------------------------------------------------------
# First Processor (PC0)
#----------------------------------------------------------
  org   0x0000              # first processor p0
  ori   $sp, $zero, 0x3ffc  # stack
  ori   $s0, $zero, 0       # start count to 0
  ori   $s1, $zero, 256     # final count to 256 (or smaller number for testing purposes)
  ori   $a0, $zero, 4       # the starting seed value ($a0) to your favorite number
rnloop:
  #ori   $24, $zero, 0xDEAD
  jal   crc32               # call crc and generate the randome number
  ori   $a0, $zero, lk1     # move lock to arguement register
  andi  $s2, $v0, 0xFFFF    # mask off the upper 16 bits of the RN
  jal   lock                # try to aquire the lock
  # critical code segment
  ori   $t0, $zero, ptr     # move addr of ptr into $t0
  lw    $a0, 0($t0)         # loads ptr value into a0 (ie a0 = 1ffc, 1ff8, etc.)
  addi  $a0, $a0, -4        # manual push to a buffer stack pointer (push $v0)
  sw    $s2, 0($a0)         # store the masked random number into buffer stack
  sw    $a0, 0($t0)         # store the buffer stack pointer to the pointer addr
  # critical code segment
  ori   $a0, $zero, lk1     # move lock to arguement register
  jal   unlock              # release the lock
  addi  $s0, $s0, 1         # add one to the count of RN
  or    $a0, $zero, $v0     # move the masked RN back into $a0 for next crc gen
  bne   $s0, $s1, rnloop    # loop back if count does NOT equal 256
  halt

#------------------------------------------------------------
# Lock and Unlock
#------------------------------------------------------------
# pass in an address to lock function in argument register 0
# returns when lock is available
lock:
aquire:
  ll    $t0, 0($a0)         # load lock location
  bne   $t0, $0, aquire     # wait on lock to be open
  addiu $t0, $t0, 1
  sc    $t0, 0($a0)
  beq   $t0, $0, lock       # if sc failed retry
  jr    $ra
# pass in an address to unlock function in argument register 0
# returns when lock is free
unlock:
  sw    $0, 0($a0)
  jr    $ra

#------------------------------------------------------------
# Second Processor
#------------------------------------------------------------
  org   0x0200              # second processor p1
  ori   $sp, $zero, 0x7ffc  # stack
  ori   $s0, $zero, 0       # start count to 0
  ori   $s1, $zero, 256     # final count to 256 (or smaller number for testing purposes)
  ori   $s2, $zero, 0       # set sum to 0
prelock1:
  ori   $a0, $zero, lk1     # move lock to arguement register
  jal   lock                # try to aquire the lock
  # START critical code segment 1
  ori   $t0, $zero, ptr     # move addr of ptr into $t0
  lw    $a0, 0($t0)         # loads ptr value into a0 (ie a0 = 1ffc, 1ff8, etc.)
  slti  $t1, $a0, 0x1ff8    # check to see if the ptr is less than 0x1FF8
  bne   $t1, $zero, good1   # if the ptr is less than 0x1FF8, continue as normal
  ori   $a0, $zero, lk1     # move lock to arguement register
  jal   unlock              # release the lock
  j     prelock1            # try for the lock again
good1:
  lw    $s3, 0($a0)         # loads the RN stored in the buffer
  addi  $a0, $a0, 4         # add 4 to the buffer pointer
  lw    $s4, 0($a0)         # loads the RN stored in the buffer
  addi  $a0, $a0, 4         # add 4 to the buffer pointer
  sw    $a0, 0($t0)         # store the buffer stack pointer to the pointer addr
  # END critical code segment 1
  ori   $a0, $zero, lk1     # move lock to arguement register
  jal   unlock              # release the lock
  or    $a0, $zero, $s3     # move first pulled RN to $a0
  or    $a1, $zero, $s4     # move second pulled RN to $a1
  jal   min                 # jump to min subroutine
  or    $s3, $zero, $v0     # save the current min into $t2
  add   $s2, $s2, $v0       # add first RN to sum
  jal   max                 # jump to max subroutine
  or    $s4, $zero, $v0     # save the current max into $t3
  add   $s2, $s2, $v0       # add second RN to sum
  addi  $s0, $s0, 2         # count the 2 pulled values
  beq   $s0, $s1, avg       # jump to avg if finished count
loop:
prelock2:
  ori   $a0, $zero, lk1     # move lock to argument register
  jal   lock                # try to aquire the lock
  # START critical code segment 2
  ori   $t0, $zero, ptr     # move addr of ptr into $t0
  lw    $a0, 0($t0)         # loads ptr value into a0 (ie a0 = 1ffc, 1ff8, etc.)
  slti  $t1, $a0, 0x1ffc    # check to see if the ptr is less than 0x1FF8
  bne   $t1, $zero, good2   # if the ptr is less than 0x1FF8, continue as normal
  ori   $a0, $zero, lk1     # move lock to arguement register
  jal   unlock              # release the lock
  j     prelock2            # try for the lock again
good2:
  lw    $s5, 0($a0)         # loads the RN stored in the buffer
  addi  $a0, $a0, 4         # add 4 to the buffer pointer
  sw    $a0, 0($t0)         # store the buffer stack pointer to the pointer addr
  # END critical code segment 2
  ori   $a0, $zero, lk1     # move lock to arguement register
  jal   unlock              # release the lock
  or    $a0, $zero, $s3     # move current min to $a0
  or    $a1, $zero, $s5     # move newly pulled RN to $a1
  jal   min                 # jump to min subroutine
  or    $s3, $zero, $v0     # save the current min to $t2
  or    $a0, $zero, $s4     # move current max to $a0
  or    $a1, $zero, $s5     # move newly pulled RN to $a1
  jal   max                 # jump to max subroutine
  or    $s4, $zero, $v0     # save the current max to $t3
  add   $s2, $s2, $s5       # add the RN to the running sum
  addi  $s0, $s0, 1         # add 1 to the RN counter
  bne   $s0, $s1, loop      # loop back if count does NOT equal 256
avg:
  #or    $a0, $zero, $s2     # move running sum into $a0
  #or    $a1, $zero, $s1     # move final count into $a1
  #jal   divide              # jump to divide subroutine
  srl   $v0, $s2, 8
  halt

#------------------------------------------------------------
# Buffer Pointer and Lock Addr
#------------------------------------------------------------
  org 0x0500
ptr:
  cfw 0x00001ffc            # the location of the shared buffer
lk1:
  cfw 0x0                   # the lock addr value (0 or 1)

#--------------------------------------------------
# Subroutine Min Max
#--------------------------------------------------
# This will find the minimum/maximum value of the two provided values (a, b),
# and store it into the return register (v0).
# registers a0-1,v0,t0
# a0 = a
# a1 = b
# v0 = result
#-max (a0=a,a1=b) returns v0=max(a,b)--------------
max:
  push  $ra
  push  $a0
  push  $a1
  or    $v0, $0, $a0
  slt   $t0, $a0, $a1
  beq   $t0, $0, maxrtn
  or    $v0, $0, $a1
maxrtn:
  pop   $a1
  pop   $a0
  pop   $ra
  jr    $ra
#--------------------------------------------------
#-min (a0=a,a1=b) returns v0=min(a,b)--------------
min:
  push  $ra
  push  $a0
  push  $a1
  or    $v0, $0, $a0
  slt   $t0, $a1, $a0
  beq   $t0, $0, minrtn
  or    $v0, $0, $a1
minrtn:
  pop   $a1
  pop   $a0
  pop   $ra
  jr    $ra

#--------------------------------------------------
# Subroutine Divide
#--------------------------------------------------
# registers a0-1,v0-1,t0
# a0 = Numerator
# a1 = Denominator
# v0 = Quotient
# v1 = Remainder
#-divide(N=$a0,D=$a1) returns (Q=$v0,R=$v1)--------
divide:               # setup frame
  push  $ra           # saved return address
  push  $a0           # saved register
  push  $a1           # saved register
  or    $v0, $0, $0   # Quotient v0=0
  or    $v1, $0, $a0  # Remainder t2=N=a0
  beq   $0, $a1, divrtn # test zero D
  slt   $t0, $a1, $0  # test neg D
  bne   $t0, $0, divdneg
  slt   $t0, $a0, $0  # test neg N
  bne   $t0, $0, divnneg
divloop:
  slt   $t0, $v1, $a1 # while R >= D
  bne   $t0, $0, divrtn
  addiu $v0, $v0, 1   # Q = Q + 1
  subu  $v1, $v1, $a1 # R = R - D
  j     divloop
divnneg:
  subu  $a0, $0, $a0  # negate N
  jal   divide        # call divide
  subu  $v0, $0, $v0  # negate Q
  beq   $v1, $0, divrtn
  addiu $v0, $v0, -1  # return -Q-1
  j     divrtn
divdneg:
  subu  $a0, $0, $a1  # negate D
  jal   divide        # call divide
  subu  $v0, $0, $v0  # negate Q
divrtn:
  pop $a1
  pop $a0
  pop $ra
  jr  $ra

#------------------------------------------------------------
# Subroutine CRC
#------------------------------------------------------------
#REGISTERS
#at $1 at
#v $2-3 function returns
#a $4-7 function args
#t $8-15 temps
#s $16-23 saved temps (callee preserved)
#t $24-25 temps
#k $26-27 kernel
#gp $28 gp (callee preserved)
#sp $29 sp (callee preserved)
#fp $30 fp (callee preserved)
#ra $31 return address

# USAGE random0 = crc(seed),
#       random1 = crc(random0)
#       randomN = crc(randomN-1)
#------------------------------------------------------
# $v0 = crc32($a0)
crc32:
  lui $t1, 0x04C1
  ori $t1, $t1, 0x1DB7
  or $t2, $0, $0
  ori $t3, $0, 32

l1:
  slt $t4, $t2, $t3
  beq $t4, $zero, l2

  srl $t4, $a0, 31
  sll $a0, $a0, 1
  beq $t4, $0, l3
  xor $a0, $a0, $t1
l3:
  addiu $t2, $t2, 1
  j l1
l2:
  or $v0, $a0, $0
  jr $ra
#------------------------------------------------------
