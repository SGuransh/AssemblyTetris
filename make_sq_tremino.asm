.data
bits_space: .space 262144
displayaddress: .word 0x10008000
wall_colour: .word 0xFF4321     # brick red
checkers_colour: .word 0x808080 # grey
black: .word 0x000000
red: .word 0xff0000
white: .word 0xffffff
cyan: .word 0x00FFFF
ADDR_KBRD: .word 0xffff0000

.text
display_square_tremino: # $a0 = x coord, $a1 = y coord, $a3 = color
# Check if the square spaces are available for drawing 

# Initialize draw variable
# Make the squares with those points




make_sq_w_edges:
lw $t0, displayaddress
sll $a0, $a0, 2
sll $a1, $a1, 10
add $t1, $zero, $t0                     # $t1 = current address
add $t1, $t1, $a0
add $t1, $t1, $a1

li $t2, 0
addi $t2, $t1, 9252                     # bottom right offset with curr add
li $t3, 0                               # initialize row counter
li $t4, 0                               # initialize column counter
# li $t5, 0                             # intialize col_white
# li $t6, 0                             # intialize row_white
# make a label for loop
make_sq_loop:
add $t8, $zero, $a2                     # Set initial value of the colour register to be a2
beq $t1, $t2, end_make_square_with_edges           # breaking cond.
li $t7, 0
# li $t6, 0                               # make the row_white equal to 0
bne $t3, $t7, skip_row_white_1          # if row counter != 0 skip
    lw $t8, white                       # row_white = 1
skip_row_white_1:
li $t7, 9
bne $t3, $t7, skip_row_white_2          # if row counter != 9 skip
    lw $t8, white                       # row_white = 1
skip_row_white_2:

# li $t5, 0                               # make the col_white equal to 0
li $t7, 0
bne $t4, $t7, skip_col_white_1          # if col counter != 0 skip
    lw $t8, white                       # col_white 1
skip_col_white_1:
li $t7, 9
bne $t4, $t7, skip_col_white_2          # if col counter != 9 skip
    lw $t8, white                       # col_white 1
skip_col_white_2:

sw $t8, 0($t1)                            # make the pixel on the screen
li $t7, 10
addi $t4, $t4, 1
addi $t1, $t1, 4
bne $t4, $t7, skip_update_make_sq_w_edges   # if column counter != 10 skip
    li $t4, 0           # col_counter == 0
    addi $t3, $t3, 1    # row_counter += 1
    addi $t1, $t1, 984  # curr_address += 984
skip_update_make_sq_w_edges:
j make_sq_loop

end_make_square_with_edges:
lw $t9, white
sw $t9, 0($t2)
jr $ra

make_sq_w_edges_end:

# We have the upper left point to the square to which we are trying to draw
# We return the value of 0 to the register $v0 if there are no collisions
# The x coordinate is in a0 
# The y coordinate is in a1

collision_checking:
# lw $v0, 1
# intializing the registers t9 and t8 for the arguments
# This way we could use the stack and save the space
lw $t8, 0($sp)
lw $t0, displayaddress
lw $t1, checkers_colour
sll $a0, $a0, 2
add $t0, $t0, $a0
sll $a1, $a1, 10
add $t0, $t0, $a1 # t0 is our current address to check which is the upper left
lw $t3, 0
addi $t3, $t3, 40 # we go 10 pixels right

lw $t0, 0($t0) # storing pixel value of top left
lw $t3, 0($t3) # storing pixel value of top right

beq $t0, $zero, collision_checking_jump #checking black for top left
beq $t0, $t1, collision_checking_jump # checking gray for top right
lw $v0, 0
collision_checking_jump:
beq $t3, $zero, collision_checking_jump_2 # checking black for top right
beq $t3, $t1, collision_checking_jump_2 # checking gray for top right
lw $v0, 0
collision_checking_jump_2:
