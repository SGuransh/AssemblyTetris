.data
bits_space: .space 262144
displayaddress: .word 0x10008000
wall_colour: .word 0xFF1A44     # brick red
checkers_colour: .word 0x808080 # grey
black: .word 0x000000
red: .word 0xff0000
white: .word 0xffffff
cyan: .word 0x00FFFF
# . . .
.text
# . . .

lw $t0, displayaddress #$t0 = Display Address
# make background black, 256 x 256 grid
li $t2, 0 #i= 0
li $t3, 262144 # total number of addresses (256*256*4 = 262144)

make_black_background:
beq $t2, $t3, make_walls #if a0 has reached all address, end function
add $t4, $t2, $t0 # $t4 = address to hold where to draw, which is increased from t0
addi $t2, $t2, 4
lw $t1, black
sw $t1 0($t4)
j make_black_background


make_walls:
# The dispay is 256x256 with units 1x1
lw $t0, displayaddress  # $t0 = base address for display
# li $t0, 0x10008000

addi $a0, $zero, 0      # set x coordinate of line to 2
addi $a1, $zero, 51      # set x coordinate of line to 2
addi $a2, $zero, 5      # set length of line to 8
addi $a3, $zero, 205      # set length of line to 8
jal draw_rectangle        # call the rectangle-drawing function

addi $a0, $zero, 0      # set x coordinate of line to 2
addi $a1, $zero, 251     # set x coordinate of line to 2
addi $a2, $zero, 130      # set length of line to 8
addi $a3, $zero, 5      # set length of line to 8
jal draw_rectangle        # call the rectangle-drawing function


addi $a0, $zero, 125      # set x coordinate of line to 2
addi $a1, $zero, 51      # set x coordinate of line to 2
addi $a2, $zero, 5      # set length of line to 8
addi $a3, $zero, 205      # set length of line to 8
jal draw_rectangle        # call the rectangle-drawing function
j draw_checkers

# The code for drawing a horizontal line
# - $a0: the x coordinate of the starting point for this line.
# - $a1: the y coordinate of the starting point for this line.
# - $a2: the length of this line, measured in pixels
# - $a3: the height of this line, measured in pixels
# - $t0: the address of the first pixel (top left) in the bitmap
# - $t1: the horizontal offset of the first pixel in the line.
# - $t2: the vertical offset of the first pixel in the line.
# - #t3: the location in bitmap memory of the current pixel to draw 
# - $t4: the colour value to draw on the bitmap
# - $t5: the bitmap location for the end of the horizontal line.
draw_rectangle:
sll $t2, $a1, 10         # convert vertical offset to pixels (by multiplying $a1 by 256 * 4)
sll $t6, $a3, 10         # convert height of rectangle from pixels to rows of bytes (by multiplying $a3 by 256 * 4)
add $t6, $t2, $t6       # calculate value of $t2 for the last line in the rectangle.
outer_top:
sll $t1, $a0, 2         # convert horizontal offset to pixels (by multiplying $a0 by 4)
sll $t5, $a2, 2         # convert length of line from pixels to bytes (by multiplying $a2 by 4)
add $t5, $t1, $t5       # calculate value of $t1 for end of the horizontal line.

inner_top:
add $t3, $t1, $t2           # store the total offset of the starting pixel (relative to $t0)
add $t3, $t0, $t3           # calculate the location of the starting pixel ($t0 + offset)
# li $t4, 0x00ff00            # $t4 = green
lw $t4, wall_colour
sw $t4, 0($t3)              # paint the current unit on the first row yellow
addi $t1, $t1, 4            # move horizontal offset to the right by one pixel
beq $t1, $t5, inner_end     # break out of the line-drawing loop
j inner_top                 # jump to the start of the inner loop
inner_end:

addi $t2, $t2, 1024          # move vertical offset down by one line
beq $t2, $t6, outer_end     # on last line, break out of the outer loop
j outer_top                 # jump to the top of the outer loop
outer_end:

jr $ra                      # return to calling program


# The code for making the grid structure in the game area
# - $t0: the displayaddress of the playing area
# - $t1: the 
draw_checkers:
lw $t0, displayaddress
addi $t0, $t0, 256500   # Get the address of the last register at (125, 250)
lw $t1, displayaddress
addi $t1, $t1, 52244    # intialize address register to 5, 51
li $t2, 0               # intialize the row counter to 0
li $t3, 0               # intialize colour counter
li $t4, 0               # intialize draw to 0
li $t5, 0               # intialize switch which would tell us to swith the draw bool again
checkers_loop:          # Start the loop
# Check the breaking condition for the while loop
beq $t1, $t0, checkers_end
li $t6, 120
bne $t2, $t6, checkers_skip_row_counter # check if we have to change the row (row counter = 120)
addi $t1, $t1, 544                  # if so jump to increment y checkers
li $t2, 0                           # Set row counter to 0
addi $t5, $t5, 1                    # Increase switch by 1
checkers_skip_row_counter:
li $t6, 10
bne $t5, $t6, checkers_skip_switch  # if switch is 10 ~draw 
li $t5, 0                           # Switch to 0
not $t4, $t4
checkers_skip_switch:
bne $t3, $t6, checkers_skip_colour_counter      # if draw_counter is 10 ~draw
li $t3, 0                                       # Draw_counter to 0
not $t4, $t4
checkers_skip_colour_counter:
bne $t4, $zero, checkers_skip_draw          # Draw the pixel if value is 1 draw grey
lw $t7, checkers_colour
sw $t7, 0($t1)
checkers_skip_draw:
addi $t1, $t1, 4        # Increment start
addi $t2, $t2, 1        # Increment row_counter
addi $t3, $t3, 1        # Increment colour_counter

j checkers_loop         # Jump back to the start
checkers_end:

lw $a2, red
li $a0, 15
li $a1, 51
jal make_sq_w_edges
lw $a2, red
li $a0, 5
li $a1, 51
jal make_sq_w_edges
lw $a2, red
li $a0, 5
li $a1, 61
jal make_sq_w_edges
lw $a2, red
li $a0, 15
li $a1, 61
jal make_sq_w_edges

lw $a2, red
li $a0, 115
li $a1, 241
jal make_sq_w_edges
j end_drawing_square



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

make_sq_loop:
add $t8, $zero, $a2                     # Set initial value of the colour register to be a2
beq $t1, $t2, end_make_square_with_edges           # breaking cond.
li $t7, 0
bne $t3, $t7, skip_row_white_1          # if row counter != 0 skip
    lw $t8, white                       # row_white = 1
skip_row_white_1:
li $t7, 9
bne $t3, $t7, skip_row_white_2          # if row counter != 9 skip
    lw $t8, white                       # row_white = 1
skip_row_white_2:
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

end_drawing_square: