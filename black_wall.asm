.data
displayaddress: .word 0x10008000
black: .word 0x000000
# . . .
.text
# . . .

lw $t0, displayaddress #$t0 = Display Address
# make background black, 256 x 256 grid
li $a0, 0 #i= 0
li $a1, 262144 # total number of addresses (256*256*4 = 262144)

make_black_background:
beq $a0, $a1, draw_checkers #if a0 has reached all address, end function
add $a3, $a0, $t0 # $a3 = address to hold where to draw, which is increased from t0
addi $a0, $a0, 4
lw $t1, black
sw $t1 0($a3)
j make_black_background
# WORKS^


draw_checkers:
# initialize x coord to 5
# initialize


