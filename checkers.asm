.data
displayaddress: .word 0x10008000
checkers_colour: .word 0x00ff00

.text
#...


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
addi $t1, $t1, 548                  # if so jump to increment y checkers
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
