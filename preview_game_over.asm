.data
bits_space: .space 262144
displayaddress: .word 0x10008000
wall_colour: .word 0xFF4321     # brick red
checkers_colour: .word 0x808080 # grey
black: .word 0x000000
red: .word 0xff0000
white: .word 0xffffff
cyan: .word 0x00FFFF
yellow: .word 0xFFFF00
aqua: .word 0x008080
silver: .word 0xC0C0C0
purple: .word 0x800080
green: .word 0x00FF00
ADDR_KBRD: .word 0xffff0000
which_wall: .word 0
color_in_use: .word 0x00FF00

sq1_x: .word 25 sq1_y: .word 51
sq2_x: .word 15 sq2_y: .word 51
sq3_x: .word 5 sq3_y: .word 61
sq4_x: .word 15 sq4_y: .word 61

x_offset: .word 5
y_offset: .word 51

pr_sq1_x: .word 0 pr_sq1_y: .word 0
pr_sq2_x: .word 0 pr_sq2_y: .word 0
pr_sq3_x: .word 0 pr_sq3_y: .word 0
pr_sq4_x: .word 0 pr_sq4_y: .word 0


sq1_x_next: .word 155 sq1_y_next: .word 51
sq2_x_next: .word 145 sq2_y_next: .word 51
sq3_x_next: .word 155 sq3_y_next: .word 51
sq4_x_next: .word 155 sq4_y_next: .word 51
next_trimino: .word 0


.text
#...
main:
la $a0, sq1_x
    li $v0, 1                       # ask system to print $a0
    syscall


jal make_black_background
jal make_walls
jal draw_checkers       # call the draw checkers function

game_loop:
jal make_black_background_init_next
lw $a0, next_trimino
    beq $a0, 0, Making_T_Trimino_next
    beq $a0, 1, Making_L_Trimino_next
    beq $a0, 2, Making_J_Trimino_next
    beq $a0, 3, Making_S_Trimino_next
    beq $a0, 4, Making_Z_Trimino_next
    
    # Making_T_Trimino_next:
        # li $t2, 145
        # li $t3, 51
        # sw $t2, sq1_x_next
        # sw $t3, sq1_y_next
        
        # li $t2, 145
        # li $t3, 61
        # sw $t2, sq2_x_next
        # sw $t3, sq2_y_next
        
        # li $t2, 155
        # li $t3, 61
        # sw $t2, sq3_x_next
        # sw $t3, sq3_y_next
        
        # li $t2, 165
        # li $t3, 61
        # sw $t2, sq4_x_next
        # sw $t3, sq4_y_next
        
        Making_T_Trimino_next:
        # Hard codding to initialize a T everytime
        li $t2, 155
        li $t3, 51
        sw $t2, sq1_x_next
        sw $t3, sq1_y_next
        
        li $t2, 145
        li $t3, 61
        sw $t2, sq2_x_next
        sw $t3, sq2_y_next
        
        li $t2, 155
        li $t3, 61
        sw $t2, sq3_x_next
        sw $t3, sq3_y_next
        
        li $t2, 165
        li $t3, 61
        sw $t2, sq4_x_next
        sw $t3, sq4_y_next
        
        j after_making_next_trimino
    Making_L_Trimino_next:
        li $t2, 165
        li $t3, 51
        sw $t2, sq1_x_next
        sw $t3, sq1_y_next
        
        li $t2, 145
        li $t3, 61
        sw $t2, sq2_x_next
        sw $t3, sq2_y_next
        
        li $t2, 155
        li $t3, 61
        sw $t2, sq3_x_next
        sw $t3, sq3_y_next
        
        li $t2, 165
        li $t3, 61
        sw $t2, sq4_x_next
        sw $t3, sq4_y_next
        
        j after_making_next_trimino
    Making_J_Trimino_next:
        li $t2, 145
        li $t3, 51
        sw $t2, sq1_x_next
        sw $t3, sq1_y_next
        
        li $t2, 145
        li $t3, 61
        sw $t2, sq2_x_next
        sw $t3, sq2_y_next
        
        li $t2, 155
        li $t3, 61
        sw $t2, sq3_x_next
        sw $t3, sq3_y_next
        
        li $t2, 165
        li $t3, 61
        sw $t2, sq4_x_next
        sw $t3, sq4_y_next
        
        j after_making_next_trimino
    Making_S_Trimino_next:
        li $t2, 155
        li $t3, 51
        sw $t2, sq1_x_next
        sw $t3, sq1_y_next
        
        li $t2, 165
        li $t3, 51
        sw $t2, sq2_x_next
        sw $t3, sq2_y_next
        
        li $t2, 145
        li $t3, 61
        sw $t2, sq3_x_next
        sw $t3, sq3_y_next
        
        li $t2, 155
        li $t3, 61
        sw $t2, sq4_x_next
        sw $t3, sq4_y_next
        
        j after_making_next_trimino
        
    Making_Z_Trimino_next:
        li $t2, 145
        li $t3, 51
        sw $t2, sq1_x_next
        sw $t3, sq1_y_next
        
        li $t2, 155
        li $t3, 51
        sw $t2, sq2_x_next
        sw $t3, sq2_y_next
        
        li $t2, 155
        li $t3, 61
        sw $t2, sq3_x_next
        sw $t3, sq3_y_next
        
        li $t2, 165
        li $t3, 61
        sw $t2, sq4_x_next
        sw $t3, sq4_y_next
        
        j after_making_next_trimino
    

# jal check_for_ending

after_making_next_trimino:
lw $a0, sq1_x 
lw $a1, sq1_y 
lw $a2, color_in_use
jal make_sq_w_edges

lw $a0, sq2_x
lw $a1, sq2_y 
lw $a2, color_in_use
jal make_sq_w_edges


lw $a0, sq3_x
lw $a1, sq3_y
lw $a2, color_in_use
jal make_sq_w_edges


lw $a0, sq4_x 
lw $a1, sq4_y 
lw $a2, color_in_use
jal make_sq_w_edges


lw $a0, sq1_x_next
lw $a1, sq1_y_next
lw $a2, color_in_use
jal make_sq_w_edges

lw $a0, sq2_x_next
lw $a1, sq2_y_next
lw $a2, color_in_use
jal make_sq_w_edges


lw $a0, sq3_x_next
lw $a1, sq3_y_next
lw $a2, color_in_use
jal make_sq_w_edges


lw $a0, sq4_x_next
lw $a1, sq4_y_next
lw $a2, color_in_use
jal make_sq_w_edges





lw $t0, ADDR_KBRD               # $t0 = base address for keyboard
lw $t8, 0($t0)                  # Load first word from keyboard
# put sq1x sq1y in offsets
# sw $a0, x_offset
# sw $a1, y_offset
beq $t8, 1, keyboard_input      # If first word 1, key is pressed
# bne $v0, 1, skipping_end_update
jal end_update
    # jal make_new_trimino
skipping_end_update:
j game_loop

make_black_background:
lw $t0, displayaddress #$t0 = Display Address
li $t1, 0
li $t2, 262144
lw $t3, black
make_black_loop_background_main:
beq, $t1, $t2, end_black_loop_background_main
add $t4, $t1, $t0
addi $t1, $t1, 4
sw $t3, 0($t4)
j make_black_loop_background_main
end_black_loop_background_main:
jr $ra

make_walls:
    # The dispay is 256x256 with units 1x1
    lw $t1, wall_colour
    sw $t1, which_wall
    lw $t0, displayaddress  # $t0 = base address for display
    # li $t0, 0x10008000
    
    addi $a0, $zero, 0      # set x coordinate of line to 2
    addi $a1, $zero, 51      # set x coordinate of line to 2
    addi $a2, $zero, 5      # set length of line to 8
    addi $a3, $zero, 205      # set length of line to 8
    # store the ra 
    addi $sp, $sp, -4
    sw $ra, 0($sp)
    jal draw_rectangle        # call the rectangle-drawing function
    # get ra back
    lw $ra, 0($sp)
    addi $sp, $sp, 4
    
    addi $a0, $zero, 0      # set x coordinate of line to 2
    addi $a1, $zero, 251     # set x coordinate of line to 2
    addi $a2, $zero, 130      # set length of line to 8
    addi $a3, $zero, 5      # set length of line to 8
    # store the ra 
    addi $sp, $sp, -4
    sw $ra, 0($sp)
    jal draw_rectangle        # call the rectangle-drawing function
    # get ra back
    lw $ra, 0($sp)
    addi $sp, $sp, 4
    
    addi $a0, $zero, 125      # set x coordinate of line to 2
    addi $a1, $zero, 51      # set x coordinate of line to 2
    addi $a2, $zero, 5      # set length of line to 8
    addi $a3, $zero, 205      # set length of line to 8
    # store the ra
    addi $sp, $sp, -4
    sw $ra, 0($sp)
    jal draw_rectangle        # call the rectangle-drawing function
    # get ra back
    lw $ra, 0($sp)
    addi $sp, $sp, 4
jr $ra

draw_checkers:
    lw $t0, displayaddress
    addi $t0, $t0, 256500   # Get the address of the last register at (125, 250)
    lw $t1, displayaddress
    addi $t1, $t1, 52244    # intialize address register to 5, 51
    li $t2, 0               # intialize the row counter to 0
    li $t3, 0               # intialize colour counter
    li $t4, 0               # intialize draw to 0
    li $t5, 0               # intialize switch which would tell us to swith the draw bool again
    li $t6, 0               # Skip cause there is a value here, skip on 1
    checkers_loop:          # Start the loop
    li $t6, 0               # Skip cause there is a value here, skip on 1
    # loading the current value at the address we are trying to draw on
    # $t9 is the checkers colour so we see if the value is 0 or that is it is we do not make the skip bool 1
    lw $t8, 0($t1)
    beq $t8, $zero, value_of_skip_bool_didnt_change
    lw $t9, checkers_colour
    beq $t8, $t9, value_of_skip_bool_didnt_change
        li $t6, 1
    value_of_skip_bool_didnt_change:
    # Check the breaking condition for the while loop
    beq $t1, $t0, checkers_end
    # li $t6, 120
    bne $t2, 120, checkers_skip_row_counter # check if we have to change the row (row counter = 120)
    addi $t1, $t1, 544                  # if so jump to increment y checkers
    li $t2, 0                           # Set row counter to 0
    addi $t5, $t5, 1                    # Increase switch by 1
    checkers_skip_row_counter:
    # li $t6, 10
    bne $t5, 10, checkers_skip_switch  # if switch is 10 ~draw 
    li $t5, 0                           # Switch to 0
    not $t4, $t4
    checkers_skip_switch:
    bne $t3, 10, checkers_skip_colour_counter      # if draw_counter is 10 ~draw
    li $t3, 0                                       # Draw_counter to 0
    not $t4, $t4
    checkers_skip_colour_counter:
    # Add the checking conditions
    # If the value of the skip boolean is 1 then we skip the drawing part
    beq $t6, 1, value_exits_so_skipping
    bne $t4, $zero, checkers_skip_draw          # Draw the pixel if value is 1 draw grey
    lw $t7, checkers_colour
    sw $t7, 0($t1)
    value_exits_so_skipping:
    checkers_skip_draw:
    addi $t1, $t1, 4        # Increment start
    addi $t2, $t2, 1        # Increment row_counter
    addi $t3, $t3, 1        # Increment colour_counter
    
    j checkers_loop         # Jump back to the start
checkers_end:
jr $ra

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
# li $t1, 0
lw $t0, ADDR_KBRD               # $t0 = base address for keyboard
li $t1, 0
li $t9, 0
lw $a0, 4($t0)                  
beq $a0, 0x71, respond_to_Q
beq $a0, 97, respond_to_A
beq $a0, 119, respond_to_W
beq $a0, 115, respond_to_S 
beq $a0, 100, respond_to_D
j game_loop

respond_to_A:
    jal make_black_background_init
    li $v0, 1
    # Check here if the value of the check_collision_4_sq is 1
    # Draw only is the value is 1, other wise do not draw and do not update values
    li $a2, -10
    li $a3, 0
    jal collision_checking_for_4_squares
    bne $v0, 1, no_change_in_the_coordinates_of_the_squares
    # jal make_black_background_init
    jal draw_checkers
    lw $t9, x_offset # changing all the global values by needed amount
    addi $t9, $t9, -10
    sw $t9, x_offset
    lw $t9, sq1_x
    addi $t9, $t9, -10
    sw $t9, sq1_x
    lw $t9, sq2_x
    addi $t9, $t9, -10
    sw $t9, sq2_x
    lw $t9, sq3_x
    addi $t9, $t9, -10
    sw $t9, sq3_x
    lw $t9, sq4_x
    addi $t9, $t9, -10
    sw $t9, sq4_x
j game_loop

respond_to_W:
    jal make_black_background_init
    # Here we would call a function that changes the mapping of trimino and rotates it
    jal check_if_rotation_is_possible
    # bne $v0, -500, Failed
    jal draw_checkers
j game_loop
        
respond_to_S:
    jal make_black_background_init
    li $v0, 1
    # Check here if the value of the check_collision_4_sq is 1
    # Draw only is the value is 1, other wise do not draw and do not update values
    li $a2, 0
    li $a3, 10
    jal collision_checking_for_4_squares
    bne $v0, 1, no_change_in_the_coordinates_of_the_squares
    # jal make_black_background_init
    jal draw_checkers
    lw $t9, y_offset # changing all the global values by needed amount
    addi $t9, $t9, 10
    sw $t9, y_offset
    lw $t9, sq1_y
    addi $t9, $t9, 10
    sw $t9, sq1_y
    lw $t9, sq2_y
    addi $t9, $t9, 10
    sw $t9, sq2_y
    lw $t9, sq3_y
    addi $t9, $t9, 10
    sw $t9, sq3_y
    lw $t9, sq4_y
    addi $t9, $t9, 10
    sw $t9, sq4_y
j game_loop

respond_to_D:
    jal make_black_background_init
    li $v0, 1
    # Check here if the value of the check_collision_4_sq is 1
    # Draw only is the value is 1, other wise do not draw and do not update values
    li $a2, 10
    li $a3, 0
    jal collision_checking_for_4_squares
    bne $v0, 1, no_change_in_the_coordinates_of_the_squares
    # jal make_black_background_init
    jal draw_checkers
    lw $t9, x_offset # changing all the global values by needed amount
    addi $t9, $t9, 10
    sw $t9, x_offset
    lw $t9, sq1_x
    addi $t9, $t9, 10
    sw $t9, sq1_x
    lw $t9, sq2_x
    addi $t9, $t9, 10
    sw $t9, sq2_x
    lw $t9, sq3_x
    addi $t9, $t9, 10
    sw $t9, sq3_x
    lw $t9, sq4_x
    addi $t9, $t9, 10
    sw $t9, sq4_x
j game_loop

respond_to_Q:
	li $v0, 10                      # Quit gracefully
	syscall
	
no_change_in_the_coordinates_of_the_squares:
    j game_loop

make_black_background_init:
    lw $t0, displayaddress  # $t0 = base address for display
    lw $t1, black
    sw $t1, which_wall
    
    addi $a2, $zero, 10     # set length of line to 8
    addi $a3, $zero, 10      # set length of line to 8
    addi $sp, $sp, -4 # saving current stack pointer 
    sw $ra, 0($sp)
    lw $a0, sq1_x   
    lw $a1, sq1_y 
    jal draw_rectangle  # drawing 10x10 black at the above coord
    lw $a0, sq2_x  
    lw $a1, sq2_y 
    jal draw_rectangle # drawing 10x10 black at the above coord
    lw $a0, sq3_x   
    lw $a1, sq3_y   
    jal draw_rectangle # drawing 10x10 black at the above coord       
    lw $a0, sq3_x  
    lw $a1, sq3_y     
    jal draw_rectangle # drawing 10x10 black at the above coord
    lw $a0, sq4_x  
    lw $a1, sq4_y   
    lw $ra, 0($sp) # below is the final jump, it will need to return to where the function make_background_init was called
    addi $sp, $sp, 4
j draw_rectangle
make_black_background_init_next:
    lw $t0, displayaddress  # $t0 = base address for display
    lw $t1, black
    sw $t1, which_wall
    
    addi $a2, $zero, 10     # set length of line to 8
    addi $a3, $zero, 10      # set length of line to 8
    addi $sp, $sp, -4 # saving current stack pointer 
    sw $ra, 0($sp)
    lw $a0, sq1_x_next
    lw $a1, sq1_y_next
    jal draw_rectangle  # drawing 10x10 black at the above coord
    lw $a0, sq2_x_next 
    lw $a1, sq2_y_next
    jal draw_rectangle # drawing 10x10 black at the above coord
    lw $a0, sq3_x_next   
    lw $a1, sq3_y_next   
    jal draw_rectangle # drawing 10x10 black at the above coord       
    lw $a0, sq4_x_next  
    lw $a1, sq4_y_next   
    lw $ra, 0($sp) # below is the final jump, it will need to return to where the function make_background_init was called
    addi $sp, $sp, 4
j draw_rectangle



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
    lw $t4, which_wall            # $t4 = green
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

collision_checking:
    li $v0, 1
    lw $t0, displayaddress
    lw $t1, checkers_colour
    sll $a0, $a0, 2
    add $t0, $t0, $a0
    sll $a1, $a1, 10
    add $t0, $t0, $a1 # t0 is our current address to check which is the upper left
    
    li $t3, 0
    add $t3, $t3, $t0
    addi $t3, $t3, 40 # we go 10 pixels right
    
    # TESTING SOMETHING
    addi $t0, $t0, 4
    addi $t3, $t3, -4
    
    lw $t0, 0($t0) # storing pixel value of top left
    lw $t3, 0($t3) # storing pixel value of top right
    
    beq $t0, $zero, collision_checking_jump #checking black for top left
    beq $t0, $t1, collision_checking_jump # checking gray for top right
    li $v0, 0
    collision_checking_jump:
    beq $t3, $zero, collision_checking_jump_2 # checking black for top right
    beq $t3, $t1, collision_checking_jump_2 # checking gray for top right
    li $v0, 0
    collision_checking_jump_2:
jr $ra

collision_checking_for_4_squares:       # if 0 then do not draw
    # We make the collision checking call for sq1 and see if the value returned is 1
    # If the value is 1 then we know that the return value for this function should be 1
    # Otherwise we make the call to the next sq and check for collisions
    lw $a0, sq1_x
    lw $a1, sq1_y
    add $a0, $a0, $a2
    add $a1, $a1, $a3
    addi $sp, $sp, -4 # saving current stack pointer 
    sw $ra, 0($sp)
    jal collision_checking
    lw $ra, 0($sp) 
    addi $sp, $sp, 4
    beq $v0, 0, return_there_are_collisions
    
    lw $a0, sq2_x
    lw $a1, sq2_y
    add $a0, $a0, $a2
    add $a1, $a1, $a3
    addi $sp, $sp, -4 # saving current stack pointer 
    sw $ra, 0($sp)
    jal collision_checking
    lw $ra, 0($sp) 
    addi $sp, $sp, 4
    beq $v0, 0, return_there_are_collisions
    
    lw $a0, sq3_x
    lw $a1, sq3_y
    add $a0, $a0, $a2
    add $a1, $a1, $a3
    addi $sp, $sp, -4 # saving current stack pointer 
    sw $ra, 0($sp)
    jal collision_checking
    lw $ra, 0($sp) 
    addi $sp, $sp, 4
    beq $v0, 0, return_there_are_collisions
    
    lw $a0, sq4_x
    lw $a1, sq4_y
    add $a0, $a0, $a2
    add $a1, $a1, $a3
    addi $sp, $sp, -4 # saving current stack pointer 
    sw $ra, 0($sp)
    jal collision_checking
    lw $ra, 0($sp) 
    addi $sp, $sp, 4
    beq $v0, 0, return_there_are_collisions
    
    # if the value is 0 return 0
    li $v0, 1
    jr $ra
    return_there_are_collisions:
    # li $v0, 1                       # ask system to print $a0
    # syscall
    
    li $v0, 0
jr $ra

# Returns the mapping if valid, otherwise returns -500, -500 in $v0 and $v1
mapping_rotation:
    # Subtracting the coordinates with the offsets to get the relative values
    lw $t0, x_offset
    sub $a0, $a0, $t0
    
    lw $t1, y_offset
    sub $a1, $a1, $t1

    # It takes in the point and spits out the corresponding mapping that is possible
    # Here $a0 is the x coordinate and $a1 is the y coordinate
    Checking_A:
    # Check for (0, 0)
    bne $a0, 0, Checking_B
    bne $a1, 0, Checking_B
    
    # Map to (0, 20)
    # Here we would extract the value check for collisions
    lw $a0, x_offset
    lw $a1, y_offset
    addi $a0, $a0, 0
    addi $a1, $a1, 20
    
    addi $sp, $sp, -4 
    sw $a0, 0($sp)
    addi $sp, $sp, -4 
    sw $a1, 0($sp)
    addi $sp, $sp, -4 # saving current stack pointer 
    sw $ra, 0($sp)
    jal collision_checking
    lw $ra, 0($sp) 
    addi $sp, $sp, 4
    lw $a1, 0($sp) 
    addi $sp, $sp, 4
    lw $a0, 0($sp) 
    addi $sp, $sp, 4
    
    beq $v0, 0, There_are_collisions_rotation_map
    add $v0, $zero, $a0
    add $v1, $zero, $a1
    jr $ra
    
    Checking_B:
    # Check for (10, 0)
    bne $a0, 10, Checking_C
    bne $a1, 0, Checking_C
    
    # Map to (0, 10)
    lw $a0, x_offset
    lw $a1, y_offset
    addi $a0, $a0, 0
    addi $a1, $a1, 10
    
    addi $sp, $sp, -4 
    sw $a0, 0($sp)
    addi $sp, $sp, -4 
    sw $a1, 0($sp)
    addi $sp, $sp, -4 # saving current stack pointer 
    sw $ra, 0($sp)
    jal collision_checking
    lw $ra, 0($sp) 
    addi $sp, $sp, 4
    lw $a1, 0($sp) 
    addi $sp, $sp, 4
    lw $a0, 0($sp) 
    addi $sp, $sp, 4
    
    beq $v0, 0, There_are_collisions_rotation_map
    add $v0, $zero, $a0
    add $v1, $zero, $a1
    jr $ra
    
    Checking_C:
    # Check for (20, 0)
    bne $a0, 20, Checking_D
    bne $a1, 0, Checking_D
    
    # Map to (0, 0)
    lw $a0, x_offset
    lw $a1, y_offset
    addi $a0, $a0, 0
    addi $a1, $a1, 0
    
    addi $sp, $sp, -4 
    sw $a0, 0($sp)
    addi $sp, $sp, -4 
    sw $a1, 0($sp)
    addi $sp, $sp, -4 # saving current stack pointer 
    sw $ra, 0($sp)
    jal collision_checking
    lw $ra, 0($sp) 
    addi $sp, $sp, 4
    lw $a1, 0($sp) 
    addi $sp, $sp, 4
    lw $a0, 0($sp) 
    addi $sp, $sp, 4
    
    beq $v0, 0, There_are_collisions_rotation_map
    add $v0, $zero, $a0
    add $v1, $zero, $a1
    jr $ra
    
    Checking_D:
    # Check for (0, 10)
    bne $a0, 0, Checking_E
    bne $a1, 10, Checking_E
    
    # Map to (10, 20)
    lw $a0, x_offset
    lw $a1, y_offset
    addi $a0, $a0, 10
    addi $a1, $a1, 20
    
    addi $sp, $sp, -4 
    sw $a0, 0($sp)
    addi $sp, $sp, -4 
    sw $a1, 0($sp)
    addi $sp, $sp, -4 # saving current stack pointer 
    sw $ra, 0($sp)
    jal collision_checking
    lw $ra, 0($sp) 
    addi $sp, $sp, 4
    lw $a1, 0($sp) 
    addi $sp, $sp, 4
    lw $a0, 0($sp) 
    addi $sp, $sp, 4
    
    beq $v0, 0, There_are_collisions_rotation_map
    add $v0, $zero, $a0
    add $v1, $zero, $a1
    jr $ra
    
    Checking_E:
    # Check for (10, 10)
    bne $a0, 10, Checking_F
    bne $a1, 10, Checking_F
    
    # Map to (10, 10)
    # In this case we just return the same address
    lw $a0, x_offset
    lw $a1, y_offset
    addi $a0, $a0, 10
    addi $a1, $a1, 10
    add $v0, $zero, $a0
    add $v1, $zero, $a1
    jr $ra
    
    Checking_F:
    # Check for (20, 10)
    bne $a0, 20, Checking_G
    bne $a1, 10, Checking_G
    
    # Map to (10, 0)
    lw $a0, x_offset
    lw $a1, y_offset
    addi $a0, $a0, 10
    addi $a1, $a1, 0
    
    
    addi $sp, $sp, -4 
    sw $a0, 0($sp)
    addi $sp, $sp, -4 
    sw $a1, 0($sp)
    addi $sp, $sp, -4 # saving current stack pointer 
    sw $ra, 0($sp)
    jal collision_checking
    lw $ra, 0($sp) 
    addi $sp, $sp, 4
    lw $a1, 0($sp) 
    addi $sp, $sp, 4
    lw $a0, 0($sp) 
    addi $sp, $sp, 4
    
    beq $v0, 0, There_are_collisions_rotation_map
    add $v0, $zero, $a0
    add $v1, $zero, $a1
    jr $ra
    
    Checking_G:
    # Check for (0, 20)
    bne $a0, 0, Checking_H
    bne $a1, 20, Checking_H
    
    # Map to (20, 20)
    lw $a0, x_offset
    lw $a1, y_offset
    addi $a0, $a0, 20
    addi $a1, $a1, 20
    
    addi $sp, $sp, -4 
    sw $a0, 0($sp)
    addi $sp, $sp, -4 
    sw $a1, 0($sp)
    addi $sp, $sp, -4 # saving current stack pointer 
    sw $ra, 0($sp)
    jal collision_checking
    lw $ra, 0($sp) 
    addi $sp, $sp, 4
    lw $a1, 0($sp) 
    addi $sp, $sp, 4
    lw $a0, 0($sp) 
    addi $sp, $sp, 4
    
    beq $v0, 0, There_are_collisions_rotation_map
    add $v0, $zero, $a0
    add $v1, $zero, $a1
    jr $ra
    
    Checking_H:
    # Check for (10, 20)
    bne $a0, 10, Checking_I
    bne $a1, 20, Checking_I
    
    # Map to (20, 10)
    lw $a0, x_offset
    lw $a1, y_offset
    addi $a0, $a0, 20
    addi $a1, $a1, 10
    
    addi $sp, $sp, -4 
    sw $a0, 0($sp)
    addi $sp, $sp, -4 
    sw $a1, 0($sp)
    addi $sp, $sp, -4 # saving current stack pointer 
    sw $ra, 0($sp)
    jal collision_checking
    lw $ra, 0($sp) 
    addi $sp, $sp, 4
    lw $a1, 0($sp) 
    addi $sp, $sp, 4
    lw $a0, 0($sp) 
    addi $sp, $sp, 4
    
    beq $v0, 0, There_are_collisions_rotation_map
    add $v0, $zero, $a0
    add $v1, $zero, $a1
    jr $ra
    
    Checking_I:
    # Check for (20, 20)
    bne $a0, 20, Checking_finshed
    bne $a1, 20, Checking_finshed
    
    # Map to (20, 0)
    lw $a0, x_offset
    lw $a1, y_offset
    addi $a0, $a0, 20
    addi $a1, $a1, 0
    
    addi $sp, $sp, -4 
    sw $a0, 0($sp)
    addi $sp, $sp, -4 
    sw $a1, 0($sp)
    addi $sp, $sp, -4 # saving current stack pointer 
    sw $ra, 0($sp)
    jal collision_checking
    lw $ra, 0($sp) 
    addi $sp, $sp, 4
    lw $a1, 0($sp) 
    addi $sp, $sp, 4
    lw $a0, 0($sp) 
    addi $sp, $sp, 4
    
    beq $v0, 0, There_are_collisions_rotation_map
    add $v0, $zero, $a0
    add $v1, $zero, $a1
    jr $ra
    
    Checking_finshed:
    # Nothing satisfied
    li $v0, -100
    li $v1, -100
jr $ra
    
    There_are_collisions_rotation_map:
    li $v0, -500
    li $v1, -500
jr $ra

check_if_rotation_is_possible:
    # Check the rotation for sq_1, if the value is not -500 or 0, there is not collision and we store the value of v0 and v1 in the corresponding pr_sq variables
    lw $a0, sq1_x
    lw $a1, sq1_y
    
    addi $sp, $sp, -4 # saving current stack pointer 
    sw $ra, 0($sp)
    jal mapping_rotation
    lw $ra, 0($sp) 
    addi $sp, $sp, 4
    
    bne $v0, -500, Skip_rotation_early_return_1
    # bne $v0, -100, Skip_rotation_early_return_1
    jr $ra      # early return
    Skip_rotation_early_return_1:
    sw $v0, pr_sq1_x
    sw $v1, pr_sq1_y
    
    # Check the rotation for sq_2, if the value is not -500 or 0, there is not collision and we store the value of v0 and v1 in the corresponding pr_sq variables
    lw $a0, sq2_x
    lw $a1, sq2_y

    addi $sp, $sp, -4 # saving current stack pointer 
    sw $ra, 0($sp)
    jal mapping_rotation
    lw $ra, 0($sp) 
    addi $sp, $sp, 4
    
    bne $v0, -500, Skip_rotation_early_return_2
    # bne $v0, -100, Skip_rotation_early_return_2
    jr $ra      # early return
    Skip_rotation_early_return_2:
    # lw $t0, pr_sq2_x
    # lw $t1, pr_sq2_y
    sw $v0, pr_sq2_x
    sw $v1, pr_sq2_y
    
    # Check the rotation for sq_3, if the value is not -500 or 0, there is not collision and we store the value of v0 and v1 in the corresponding pr_sq variables
    lw $a0, sq3_x
    lw $a1, sq3_y
    
    addi $sp, $sp, -4 # saving current stack pointer 
    sw $ra, 0($sp)
    jal mapping_rotation
    lw $ra, 0($sp) 
    addi $sp, $sp, 4
    
    bne $v0, -500, Skip_rotation_early_return_3
    # bne $v0, -100, Skip_rotation_early_return_3
    jr $ra      # early return
    Skip_rotation_early_return_3:
    sw $v0, pr_sq3_x
    sw $v1, pr_sq3_y
    
    # Check the rotation for sq_4, if the value is not -500 or 0, there is not collision and we store the value of v0 and v1 in the corresponding pr_sq variables
    lw $a0, sq4_x
    lw $a1, sq4_y
    
    addi $sp, $sp, -4 # saving current stack pointer 
    sw $ra, 0($sp)
    jal mapping_rotation
    lw $ra, 0($sp) 
    addi $sp, $sp, 4
    
    bne $v0, -500, Skip_rotation_early_return_4
    # bne $v0, -100, Skip_rotation_early_return_4
    jr $ra      # early return
    Skip_rotation_early_return_4:
    sw $v0, pr_sq4_x
    sw $v1, pr_sq4_y
    
    Successful_rotation_has_occured:
    # store all the pr values in the actual variables
    lw $t2, pr_sq1_x
    lw $t3, pr_sq1_y
    sw $t2, sq1_x
    sw $t3, sq1_y
    
    lw $t2, pr_sq2_x
    lw $t3, pr_sq2_y
    sw $t2, sq2_x
    sw $t3, sq2_y
    
    lw $t2, pr_sq3_x
    lw $t3, pr_sq3_y
    sw $t2, sq3_x
    sw $t3, sq3_y
    
    lw $t2, pr_sq4_x
    lw $t3, pr_sq4_y
    sw $t2, sq4_x
    sw $t3, sq4_y
jr $ra

end_update:
    # The call to sleep for a second
    li $v0 , 32
    li $a0 , 400
    syscall
    
    li $v0, 0
    addi $sp, $sp, -4
    sw $ra, 0($sp)
        li $a2, 0
        li $a3, 10
        jal check_for_bottom_collision      # Check for bottom collision
    lw $ra, 0($sp)                      # This would make the return value $v0 to 1 if it is true and spawn a new trimino
    addi $sp, $sp, 4                    # If the return value is 1 then do not drop down
    # If the return value is 1 then make a new trimino
    bne $v0, 1, skip_making_new_trimino
    #Shahbaz edit
    addi $sp, $sp, -4
    sw $ra, 0($sp)
    jal check_if_game_over
    lw $ra, 0($sp)
    addi $sp, $sp, 4
    
    
    
    
    
    
    addi $sp, $sp, -4
    sw $ra, 0($sp)
        jal make_new_trimino
    lw $ra, 0($sp)
    addi $sp, $sp, 4
    
    addi $sp, $sp, -4
    sw $ra, 0($sp)
        jal check_if_any_row_is_completed
    lw $ra, 0($sp)
    addi $sp, $sp, 4
    
    jr $ra
skip_making_new_trimino:
    # increase the y pixels by 10
    addi $sp, $sp, -4
    sw $ra, 0($sp)
    jal drop_down
    lw $ra, 0($sp)
    addi $sp, $sp, 4

jr $ra


checking_bottom_collison_sub_function:
# Returns 1 if there is 
# The basic logic is that if both the points give me collision it is for sure a bottom collision and we would handle that case
    li $v0, 0
    lw $t0, displayaddress
    lw $t1, checkers_colour
    sll $a0, $a0, 2
    add $t0, $t0, $a0
    sll $a1, $a1, 10
    add $t0, $t0, $a1 # t0 is our current address to check which is the upper left
    li $t4, 0       # turns 1 if the first is collision
    li $t5, 0       # turns 1 if the second is a collision
    
    li $t3, 0
    add $t3, $t3, $t0
    addi $t3, $t3, 40 # we go 10 pixels right
    
    # TESTING SOMETHING
    addi $t0, $t0, 4
    addi $t3, $t3, -4
    
    lw $t0, 0($t0) # storing pixel value of top left
    lw $t3, 0($t3) # storing pixel value of top right
    
    beq $t0, $zero, checking_bottom_collison_sub_function_jump #checking black for top left
    beq $t0, $t1, checking_bottom_collison_sub_function_jump # checking gray for top right
    li $t4, 1
    checking_bottom_collison_sub_function_jump:
    beq $t3, $zero, checking_bottom_collison_sub_function_jump_2 # checking black for top right
    beq $t3, $t1, checking_bottom_collison_sub_function_jump_2 # checking gray for top right
    li $t5, 1
    checking_bottom_collison_sub_function_jump_2:
    
    # if both t4 and t5 are 1 return 1
    bne $t4, 1, There_was_no_double_bottom_collision
    bne $t5, 1, There_was_no_double_bottom_collision
        li $v0, 1       # There was a double bottom collision
    There_was_no_double_bottom_collision:
jr $ra


check_for_bottom_collision:
    # Takes in the input in a2 and a3 so that the sub function can freely change the values passed in
    # Make the current trimmino black so that we do not observe any collisions with it
    addi $sp, $sp, -4 # saving current stack pointer 
    sw $ra, 0($sp)
    addi $sp, $sp, -4 # saving current stack pointer 
    sw $a2, 0($sp)
    addi $sp, $sp, -4 # saving current stack pointer 
    sw $a3, 0($sp)
    jal make_black_background_init
    lw $a3, 0($sp) 
    addi $sp, $sp, 4
    lw $a2, 0($sp) 
    addi $sp, $sp, 4
    lw $ra, 0($sp) 
    addi $sp, $sp, 4
    
    lw $a0, sq1_x
    lw $a1, sq1_y
    add $a0, $a0, $a2
    add $a1, $a1, $a3
    addi $sp, $sp, -4 # saving current stack pointer 
    sw $ra, 0($sp)
    jal checking_bottom_collison_sub_function
    lw $ra, 0($sp) 
    addi $sp, $sp, 4
    beq $v0, 1, return_there_are_collisions_at_the_bottom
    
    lw $a0, sq2_x
    lw $a1, sq2_y
    add $a0, $a0, $a2
    add $a1, $a1, $a3
    addi $sp, $sp, -4 # saving current stack pointer 
    sw $ra, 0($sp)
    jal checking_bottom_collison_sub_function
    lw $ra, 0($sp) 
    addi $sp, $sp, 4
    beq $v0, 1, return_there_are_collisions_at_the_bottom
    
    lw $a0, sq3_x
    lw $a1, sq3_y
    add $a0, $a0, $a2
    add $a1, $a1, $a3
    addi $sp, $sp, -4 # saving current stack pointer 
    sw $ra, 0($sp)
    jal checking_bottom_collison_sub_function
    lw $ra, 0($sp) 
    addi $sp, $sp, 4
    beq $v0, 1, return_there_are_collisions_at_the_bottom
    
    lw $a0, sq4_x
    lw $a1, sq4_y
    add $a0, $a0, $a2
    add $a1, $a1, $a3
    addi $sp, $sp, -4 # saving current stack pointer 
    sw $ra, 0($sp)
    jal checking_bottom_collison_sub_function
    lw $ra, 0($sp) 
    addi $sp, $sp, 4
    beq $v0, 1, return_there_are_collisions_at_the_bottom
    
    # if the value is 0 return 0
    li $v0, 0
    jr $ra
    return_there_are_collisions_at_the_bottom:
    li $v0, 1                       # ask system to print $a0
    syscall
    
    li $v0, 1
jr $ra


initialize_new_trimino:
    # Get a random block 
    lw $a0, next_trimino
    # $a0 is the random value between 0 and 7 inclusive
    beq $a0, 0, Making_T_Trimino
    beq $a0, 1, Making_L_Trimino
    beq $a0, 2, Making_J_Trimino
    beq $a0, 3, Making_S_Trimino
    beq $a0, 4, Making_Z_Trimino
    Making_T_Trimino:
        # Hard codding to initialize a T everytime
            li $v0, 42
            li $a0, 0
            li $a1, 4
            syscall
            sw $a0, next_trimino
            
        li $t2, 55
        li $t3, 51
        sw $t2, sq1_x
        sw $t3, sq1_y
        
        li $t2, 45
        li $t3, 61
        sw $t2, sq2_x
        sw $t3, sq2_y
        
        li $t2, 55
        li $t3, 61
        sw $t2, sq3_x
        sw $t3, sq3_y
        
        li $t2, 65
        li $t3, 61
        sw $t2, sq4_x
        sw $t3, sq4_y
        
        j Setting_the_offset_and_pr_values_back_to_zero
    Making_L_Trimino:
     li $v0, 42
            li $a0, 0
            li $a1, 4
            syscall
            sw $a0, next_trimino
        li $t2, 65
        li $t3, 51
        sw $t2, sq1_x
        sw $t3, sq1_y
        
        li $t2, 45
        li $t3, 61
        sw $t2, sq2_x
        sw $t3, sq2_y
        
        li $t2, 55
        li $t3, 61
        sw $t2, sq3_x
        sw $t3, sq3_y
        
        li $t2, 65
        li $t3, 61
        sw $t2, sq4_x
        sw $t3, sq4_y
        
        j Setting_the_offset_and_pr_values_back_to_zero
    Making_J_Trimino:
     li $v0, 42
            li $a0, 0
            li $a1, 4
            syscall
            sw $a0, next_trimino
        li $t2, 45
        li $t3, 51
        sw $t2, sq1_x
        sw $t3, sq1_y
        
        li $t2, 45
        li $t3, 61
        sw $t2, sq2_x
        sw $t3, sq2_y
        
        li $t2, 55
        li $t3, 61
        sw $t2, sq3_x
        sw $t3, sq3_y
        
        li $t2, 65
        li $t3, 61
        sw $t2, sq4_x
        sw $t3, sq4_y
        
        j Setting_the_offset_and_pr_values_back_to_zero
    Making_S_Trimino:
     li $v0, 42
            li $a0, 0
            li $a1, 4
            syscall
            sw $a0, next_trimino
        li $t2, 55
        li $t3, 51
        sw $t2, sq1_x
        sw $t3, sq1_y
        
        li $t2, 65
        li $t3, 51
        sw $t2, sq2_x
        sw $t3, sq2_y
        
        li $t2, 45
        li $t3, 61
        sw $t2, sq3_x
        sw $t3, sq3_y
        
        li $t2, 55
        li $t3, 61
        sw $t2, sq4_x
        sw $t3, sq4_y
        
        j Setting_the_offset_and_pr_values_back_to_zero
    Making_Z_Trimino:
                li $v0, 42
            li $a0, 0
            li $a1, 4
            syscall
            sw $a0, next_trimino
     li $v0, 42
            li $a0, 0
            li $a1, 4
            syscall
            lw $a0, next_trimino
        li $t2, 45
        li $t3, 51
        sw $t2, sq1_x
        sw $t3, sq1_y
        
        li $t2, 55
        li $t3, 51
        sw $t2, sq2_x
        sw $t3, sq2_y
        
        li $t2, 55
        li $t3, 61
        sw $t2, sq3_x
        sw $t3, sq3_y
        
        li $t2, 65
        li $t3, 61
        sw $t2, sq4_x
        sw $t3, sq4_y
        
        j Setting_the_offset_and_pr_values_back_to_zero
    
    
    Setting_the_offset_and_pr_values_back_to_zero:
    # initializing the values of pr to be 0
    li $t2, 0
    li $t3, 0
    sw $t2, pr_sq1_x
    sw $t3, pr_sq1_y
    
    li $t2, 0
    li $t3, 0
    sw $t2, pr_sq2_x
    sw $t3, pr_sq2_y
    
    li $t2, 0
    li $t3, 0
    sw $t2, pr_sq3_x
    sw $t3, pr_sq3_y
    
    li $t2, 0
    li $t3, 0
    sw $t2, pr_sq4_x
    sw $t3, pr_sq4_y
    
    li $t2, 45
    li $t3, 51
    sw $t2, x_offset
    sw $t3, y_offset
jr $ra
    
    
make_new_trimino:
    # First we make the trimino at the bottom collision and then update the starting values
    lw $a0, sq1_x 
    lw $a1, sq1_y 
    lw $a2, color_in_use
    addi $sp, $sp, -4 # saving current stack pointer 
    sw $ra, 0($sp)
    jal make_sq_w_edges
    lw $ra, 0($sp) 
    addi $sp, $sp, 4
    
    lw $a0, sq2_x
    lw $a1, sq2_y 
    lw $a2, color_in_use
    addi $sp, $sp, -4 # saving current stack pointer 
    sw $ra, 0($sp)
    jal make_sq_w_edges
    lw $ra, 0($sp) 
    addi $sp, $sp, 4
    
    
    lw $a0, sq3_x
    lw $a1, sq3_y
    lw $a2, color_in_use
    addi $sp, $sp, -4 # saving current stack pointer 
    sw $ra, 0($sp)
    jal make_sq_w_edges
    lw $ra, 0($sp) 
    addi $sp, $sp, 4
    
    
    lw $a0, sq4_x 
    lw $a1, sq4_y 
    lw $a2, color_in_use
    addi $sp, $sp, -4 # saving current stack pointer 
    sw $ra, 0($sp)
    jal make_sq_w_edges
    lw $ra, 0($sp) 
    addi $sp, $sp, 4
    
    addi $sp, $sp, -4
    sw $ra, 0($sp)
        jal Change_colour_in_use
    lw $ra, 0($sp)
    addi $sp, $sp, 4
    
    addi $sp, $sp, -4 # saving current stack pointer 
    sw $ra, 0($sp)
    jal initialize_new_trimino
    lw $ra, 0($sp) 
    addi $sp, $sp, 4
    
jr $ra

drop_down:
    addi $sp, $sp, -4
    sw $ra, 0($sp)
    jal make_black_background_init
    lw $ra, 0($sp) 
    addi $sp, $sp, 4
    
    li $v0, 1
    # Check here if the value of the check_collision_4_sq is 1
    # Draw only is the value is 1, other wise do not draw and do not update values
    li $a2, 0
    li $a3, 10
    
    addi $sp, $sp, -4
    sw $ra, 0($sp)
    jal collision_checking_for_4_squares
    lw $ra, 0($sp) 
    addi $sp, $sp, 4
    
    bne $v0, 1, no_change_in_the_coordinates_of_the_squares
    # jal make_black_background_init
    
    addi $sp, $sp, -4 
    sw $ra, 0($sp)
    jal draw_checkers
    lw $ra, 0($sp) 
    addi $sp, $sp, 4
    
    lw $t9, y_offset # changing all the global values by needed amount
    addi $t9, $t9, 10
    sw $t9, y_offset
    lw $t9, sq1_y
    addi $t9, $t9, 10
    sw $t9, sq1_y
    lw $t9, sq2_y
    addi $t9, $t9, 10
    sw $t9, sq2_y
    lw $t9, sq3_y
    addi $t9, $t9, 10
    sw $t9, sq3_y
    lw $t9, sq4_y
    addi $t9, $t9, 10
    sw $t9, sq4_y
jr $ra

Change_colour_in_use:
    li $v0, 42
    li $a0, 0
    li $a1, 7
    syscall
    beq $a0, 0, TO_AQUA
    beq $a0, 1, TO_YELLOW
    beq $a0, 2, TO_SILVER
    beq $a0, 3, TO_PURPLE
    beq $a0, 4, TO_GREEN
    beq $a0, 5, TO_CYAN
    beq $a0, 6, TO_RED
    TO_AQUA:
    lw $t0, aqua
    j SET_COLOUR
    TO_YELLOW:
    lw $t0, yellow
    j SET_COLOUR
    TO_SILVER:
    lw $t0, silver
    j SET_COLOUR
    TO_PURPLE:
    lw $t0, purple
    j SET_COLOUR
    TO_GREEN:
    lw $t0, green
    j SET_COLOUR
    TO_CYAN:
    lw $t0, cyan
    j SET_COLOUR
    TO_RED:
    lw $t0, red
    j SET_COLOUR
    SET_COLOUR:
    sw $t0, color_in_use
jr $ra
    
check_if_any_row_is_completed:
    # for this we would have 2 variables to iterate over which are x and y
    # We would have the address of the pixel that we are currently trying to access
    # for(int x=5; x<=115; x+=10) # the values it iterates over is 5, 15, 25, 35, 45, 55, 65, 75, 85, 95, 105, 115
    # for(int y=51; y <=241; y+=10) 
    # We check if all the values in the row are whites if they are we return 1 otherwise we iterate on the next row (reset x)
    li $t0, 5           # Holds the x coordinate
    li $t1, 51          # Holds the y coordinate
    lw $t2, displayaddress
    Loop_for_y_start:
        beq $t1, 251, Loop_for_y_end
        li $t0, 5
        li $t3, 1   # True if all values are white (is_white)
        Loop_for_x_start:
            beq $t0, 125, Loop_for_x_end
            lw $t4, displayaddress # t4 will store the current left corner we are inspecting
            sll $t5,$t0, 2 # mutilplying x coord by 4
            add $t4, $t4, $t5 # add x offsetting to t5
            sll $t5, $t1, 10 # shifting y
            add $t4, $t4, $t5
            lw $t4, 0($t4) # storing color at t4 in t4
            beq $t4, 0xffffff, white_found
             # assuming white is not found below
             # we need to go to next row
                li $t3, 0
                addi $t1, $t1, 10 # go to next row
                j Loop_for_y_start
            white_found: 
            addi $t0, $t0, 10
            j Loop_for_x_start
        Loop_for_x_end:
        add $a0, $zero, $t1
        addi $a0, $a0, -1
        
        addi $sp, $sp, -4 
        sw $ra, 0($sp)
        addi $sp, $sp, -4 
        sw $t0, 0($sp)
        addi $sp, $sp, -4 
        sw $t1, 0($sp)
        addi $sp, $sp, -4 
        sw $t2, 0($sp)
        addi $sp, $sp, -4 
        sw $t3, 0($sp)
        addi $sp, $sp, -4 
        sw $t4, 0($sp)
        addi $sp, $sp, -4 
        sw $t5, 0($sp)
        jal bring_things_down
        lw $t5, 0($sp) 
        addi $sp, $sp, 4
        lw $t4, 0($sp) 
        addi $sp, $sp, 4
        lw $t3, 0($sp) 
        addi $sp, $sp, 4
        lw $t2, 0($sp) 
        addi $sp, $sp, 4
        lw $t1, 0($sp) 
        addi $sp, $sp, 4
        lw $t0, 0($sp) 
        addi $sp, $sp, 4
        lw $ra, 0($sp) 
        addi $sp, $sp, 4
        
        addi $t1, $t1, 10
        j Loop_for_y_start
Loop_for_y_end:
jr $ra

bring_things_down:
# 124 is last x value; first pixel to move is (124, $a0)
#for(int y = a0,; y<=41; y--), for(int x = 124, x<=5, x--)
    add $t1, $zero, $a0
    Loop_for_Y_BTD_start:
        li $t0, 124
        beq $t1, 40, Loop_for_Y_BTD_end
        Loop_for_X_BTD_start:
            beq $t0, 4, Loop_for_X_BTD_end
            lw $t3, displayaddress
            sll $t5, $t0, 2
            add $t3, $t3, $t5
            li $t5, 0
            sll $t5, $t1, 10
            add $t3, $t3, $t5
            lw $t4, 0($t3) # current color at $t3
            # moving t3 10 down
            addi $t3, $t3, 10240 # going 10 rows down from current position
            bne $t4, 0x808080, its_grey_skip_black
                lw $t4, black
            its_grey_skip_black:
            sw $t4, 0($t3)
            addi $t0, $t0, -1 # x--
            j Loop_for_X_BTD_start
        Loop_for_X_BTD_end: 
        addi $t1, $t1, -1 # y--
        j Loop_for_Y_BTD_start
    Loop_for_Y_BTD_end: 
jr $ra




check_if_game_over:
lw $t0, sq1_y
beq $t0, 51, GAME_OVER
lw $t0, sq2_y
beq $t0, 51, GAME_OVER
lw $t0, sq3_y
beq $t0, 51, GAME_OVER
lw $t0, sq3_y
beq $t0, 51, GAME_OVER

jr $ra

GAME_OVER:
lw $t0, displayaddress #$t0 = Display Address
li $t1, 0
li $t2, 262144
lw $t3, black
make_black_loop:
beq, $t1, $t2, end_black_loop
add $t4, $t1, $t0
addi $t1, $t1, 4
sw $t3, 0($t4)
j make_black_loop
end_black_loop:



# G
lw $a2, red
li $a0, 50
li $a1, 20
jal make_sq_w_edges
li $a0, 40
li $a1, 20
jal make_sq_w_edges
li $a0, 30
li $a1, 20
jal make_sq_w_edges
li $a0, 30
li $a1, 30
jal make_sq_w_edges
li $a0, 30
li $a1, 40
jal make_sq_w_edges
li $a0, 30
li $a1, 50
jal make_sq_w_edges
li $a0, 40
li $a1, 50
jal make_sq_w_edges
li $a0, 40
li $a1, 50
jal make_sq_w_edges
li $a0, 50
li $a1, 50
jal make_sq_w_edges
li $a0, 50
li $a1, 40
jal make_sq_w_edges



#A
li $a0, 80
li $a1, 20
jal make_sq_w_edges
li $a0, 70
li $a1, 30
jal make_sq_w_edges
li $a0, 70
li $a1, 40
jal make_sq_w_edges
li $a0, 70
li $a1, 50
jal make_sq_w_edges
li $a0, 90
li $a1, 30
jal make_sq_w_edges
li $a0, 90
li $a1, 40
jal make_sq_w_edges
li $a0, 90
li $a1, 50
jal make_sq_w_edges
li $a0, 80
li $a1, 40
jal make_sq_w_edges


#M
li $a0, 110
li $a1, 40
jal make_sq_w_edges
li $a0, 110
li $a1, 20
jal make_sq_w_edges
li $a0, 110
li $a1, 30
jal make_sq_w_edges
li $a0, 130
li $a1, 20
jal make_sq_w_edges
li $a0, 150
li $a1, 20
jal make_sq_w_edges
li $a0, 110
li $a1, 50
jal make_sq_w_edges
li $a0, 120
li $a1, 20
jal make_sq_w_edges
li $a0, 130
li $a1, 40
jal make_sq_w_edges
li $a0, 130
li $a1, 50
jal make_sq_w_edges
li $a0, 140
li $a1, 20
jal make_sq_w_edges
li $a0, 130
li $a1, 30
jal make_sq_w_edges
li $a0, 150
li $a1, 40
jal make_sq_w_edges
li $a0, 150
li $a1, 30
jal make_sq_w_edges
li $a0, 150
li $a1, 50
jal make_sq_w_edges

#E

li $a0, 170
li $a1, 50
jal make_sq_w_edges
li $a0, 170
li $a1, 40
jal make_sq_w_edges
li $a0, 170
li $a1, 30
jal make_sq_w_edges
li $a0, 170
li $a1, 20
jal make_sq_w_edges
li $a0, 180
li $a1, 50
jal make_sq_w_edges
li $a0, 190
li $a1, 50
jal make_sq_w_edges
li $a0, 180
li $a1, 30
jal make_sq_w_edges
li $a0, 190
li $a1, 30
jal make_sq_w_edges
li $a0, 170
li $a1, 10
jal make_sq_w_edges
li $a0, 180
li $a1, 10
jal make_sq_w_edges
li $a0, 190
li $a1, 10
jal make_sq_w_edges


#O
li $a0, 30
li $a1, 80
jal make_sq_w_edges
li $a0, 40
li $a1, 80
jal make_sq_w_edges
li $a0, 50
li $a1, 80
jal make_sq_w_edges
li $a0, 30
li $a1, 90
jal make_sq_w_edges
li $a0, 30
li $a1, 100
jal make_sq_w_edges
li $a0, 30
li $a1, 110
jal make_sq_w_edges
li $a0, 40
li $a1, 110
jal make_sq_w_edges
li $a0, 50
li $a1, 110
jal make_sq_w_edges
li $a0, 50
li $a1, 100
jal make_sq_w_edges
li $a0, 50
li $a1, 90
jal make_sq_w_edges


#V
li $a0, 70
li $a1, 80
jal make_sq_w_edges
li $a0, 70
li $a1, 90
jal make_sq_w_edges
li $a0, 70
li $a1, 100
jal make_sq_w_edges
li $a0, 80
li $a1, 110
jal make_sq_w_edges
li $a0, 90
li $a1, 90
jal make_sq_w_edges
li $a0, 90
li $a1, 100
jal make_sq_w_edges
li $a0, 90
li $a1, 80
jal make_sq_w_edges



#E
li $a0, 110
li $a1, 70
jal make_sq_w_edges
li $a0, 110
li $a1, 80
jal make_sq_w_edges
li $a0, 110
li $a1, 90
jal make_sq_w_edges
li $a0, 110
li $a1, 100
jal make_sq_w_edges
li $a0, 110
li $a1, 110
jal make_sq_w_edges
li $a0, 120
li $a1, 70
jal make_sq_w_edges
li $a0, 130
li $a1, 70
jal make_sq_w_edges
li $a0, 120
li $a1, 90
jal make_sq_w_edges
li $a0, 130
li $a1, 90
jal make_sq_w_edges
li $a0, 130
li $a1, 90
jal make_sq_w_edges
li $a0, 120
li $a1, 110
jal make_sq_w_edges
li $a0, 130
li $a1, 110
jal make_sq_w_edges



#R
li $a0, 150
li $a1, 70
jal make_sq_w_edges
li $a0, 150
li $a1, 80
jal make_sq_w_edges
li $a0, 150
li $a1, 90
jal make_sq_w_edges
li $a0, 150
li $a1, 100
jal make_sq_w_edges
li $a0, 150
li $a1, 110
jal make_sq_w_edges
li $a0, 160
li $a1, 70
jal make_sq_w_edges
li $a0, 170
li $a1, 70
jal make_sq_w_edges
li $a0, 170
li $a1, 80
jal make_sq_w_edges
li $a0, 170
li $a1, 90
jal make_sq_w_edges
li $a0, 160
li $a1, 90
jal make_sq_w_edges
li $a0, 165
li $a1, 100
jal make_sq_w_edges
li $a0, 175
li $a1, 110
jal make_sq_w_edges


waiting_for_R_LOOP:
lw $t0, ADDR_KBRD             # $t0 = base address for keyboard
li $t1, 0
li $t9, 0
lw $a0, 4($t0)                  
beq $a0, 0x72, restart
beq $a0, 0x71, respond_to_Q
j waiting_for_R_LOOP

restart:
lw $t0, displayaddress #$t0 = Display Address
li $t1, 0
li $t2, 262144
lw $t3, black
make_black_loop_r:
beq, $t1, $t2, end_black_loop_r
add $t4, $t1, $t0
addi $t1, $t1, 4
sw $t3, 0($t4)
j make_black_loop_r
end_black_loop_r:
j main
