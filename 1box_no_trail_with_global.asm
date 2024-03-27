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
sq1_x: .word 0
sq1_y: .word 0
x_offset: .word 0
y_offset: .word 0



.text
#...
main:
lw $a0, sq1_x # loading x with 0
lw $a1, sq1_y # laoding y with 0
lw $a2, red # laoding y with 0
jal make_sq_w_edges
lw $t0, ADDR_KBRD               # $t0 = base address for keyboard
lw $t8, 0($t0)                  # Load first word from keyboard
# put sq1x sq1y in offsets
# sw $a0, x_offset
# sw $a1, y_offset
beq $t8, 1, keyboard_input      # If first word 1, key is pressed
li $t1, 0
# lw $t9, x_offset
# sw $t9, sq1_x
# lw $t9, y_offset
# sw $t9, sq1_y
j main





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

keyboard_input:
li $t9, 0
lw $a0, 4($t0)                  
beq $a0, 0x71, respond_to_Q
beq $a0, 97, respond_to_A
beq $a0, 119, respond_to_W
beq $a0, 115, respond_to_S 
beq $a0, 100, respond_to_D
j main

respond_to_A:
jal make_black_background_init
lw $t9, x_offset
addi $t9, $t9, -10
sw $t9, x_offset
lw $t9, sq1_x
addi $t9, $t9, -10
sw $t9, sq1_x
j main
respond_to_W:
jal make_black_background_init
lw $t9, y_offset
addi $t9, $t9, -10
sw $t9, y_offset
lw $t9, sq1_y
addi $t9, $t9, -10
sw $t9, sq1_y
j main
respond_to_S:
jal make_black_background_init
lw $t9, y_offset
addi $t9, $t9, 10
sw $t9, y_offset
lw $t9, sq1_y
addi $t9, $t9, 10
sw $t9, sq1_y
j main
respond_to_D:
jal make_black_background_init
lw $t9, x_offset
addi $t9, $t9, 10
sw $t9, x_offset
lw $t9, sq1_x
addi $t9, $t9, 10
sw $t9, sq1_x
j main
respond_to_Q:
	li $v0, 10                      # Quit gracefully
	syscall

make_black_background_init:
lw $t0, displayaddress  # $t0 = base address for display

lw $a0, x_offset   # set x coordinate of line to 2
lw $a1, y_offset     # set x coordinate of line to 2
addi $a2, $zero, 10     # set length of line to 8
addi $a3, $zero, 10      # set length of line to 8
j draw_rectangle        # call the rectangle-drawing function

draw_rectangle:
sll $t2, $a1, 10         # convert vertical offset to pixels (by multiplying $a1 by 128)
sll $t6, $a3, 10         # convert height of rectangle from pixels to rows of bytes (by multiplying $a3 by 128)
add $t6, $t2, $t6       # calculate value of $t2 for the last line in the rectangle.
outer_top:
sll $t1, $a0, 2         # convert horizontal offset to pixels (by multiplying $a0 by 4)
sll $t5, $a2, 2         # convert length of line from pixels to bytes (by multiplying $a2 by 4)
add $t5, $t1, $t5       # calculate value of $t1 for end of the horizontal line.

inner_top:
add $t3, $t1, $t2           # store the total offset of the starting pixel (relative to $t0)
add $t3, $t0, $t3           # calculate the location of the starting pixel ($t0 + offset)
li $t4, 0x000000            # $t4 = green
sw $t4, 0($t3)              # paint the current unit on the first row yellow
addi $t1, $t1, 4            # move horizontal offset to the right by one pixel
beq $t1, $t5, inner_end     # break out of the line-drawing loop
j inner_top                 # jump to the start of the inner loop
inner_end:

addi $t2, $t2, 1024         # move vertical offset down by one line
beq $t2, $t6, outer_end     # on last line, break out of the outer loop
j outer_top                 # jump to the top of the outer loop
outer_end:
jr $ra


# 0x10021da4 -- 268574116 - 2684682
# 0x10024194 -- 268583316 - 268468224
# 0x100271ac -- 268595628 - 268468224
# 0xffe8990 --  268339600 - 