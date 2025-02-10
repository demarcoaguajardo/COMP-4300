add wave -position insertpoint  \
sim:/alu/prop_delay \
sim:/alu/operand1 \
sim:/alu/operand2 \
sim:/alu/operation \
sim:/alu/result \
sim:/alu/error

# ----- Test for unsigned addition -----
# 	operand1 = 0x05
#	operand2 = 0x07
#	expectedResult = 0x0C
#	expectedError = 0x0000

force -freeze sim:/alu/operand1 32'h00000005 0
force -freeze sim:/alu/operand2 32'h00000007 0
run

# Show overflow
#	operand1 = 0xffffffff
#	operand2 = 0x1
#	expectedResult = 0x00000000
#	expectedError = 0x0001 (overflow)

force -freeze sim:/alu/operand1 32'hffffffff 0
force -freeze sim:/alu/operand2 32'h00000001 0
run


# ----- Test for unsigned subtraction -----
#	operand1 = 0x07
#	operand2 = 0x05 
#	expectedResult = 0x02
#	expectedError = 0x0000

force -freeze sim:/alu/operation 4'h0001 0
force -freeze sim:/alu/operand1 32'h00000007 0
force -freeze sim:/alu/operand2 32'h00000005 0
run

# Show overflow
#	operand1 = 0x05
#	operand2 = 0x07
#	expectedResult = 0xFFFFFFFE
#	expectedError = 0x0001 (overflow)

force -freeze sim:/alu/operand1 32'h00000005 0
force -freeze sim:/alu/operand2 32'h00000007 0
force -freeze sim:/alu/operation 4'h1 0
run


# ----- Test for signed addition -----
#	operand1 = 0x04
#	operand2 = 0x02
#	expectedResult = 0x06
#	expectedError = 0x0000

force -freeze sim:/alu/operation 4'h2 0
force -freeze sim:/alu/operand1 32'h00000004 0
force -freeze sim:/alu/operand2 32'h00000002 0
run

# Show overflow
#	operand1 = 0x7fffffff
#	operand2 = 0x1
#	expectedResult = 0x80000000
#	expectedError = 0x0001 (overflow)

force -freeze sim:/alu/operand1 32'h7fffffff 0
force -freeze sim:/alu/operand2 32'h00000001 0
run


# ----- Test for signed subtraction -----
#	operand1 = 0x0C
#	operand2 = 0x03
#	expectedResult = 0x09
#	expectedError = 0x0000

force -freeze sim:/alu/operation 4'h3 0
force -freeze sim:/alu/operand1 32'h0000000C 0
force -freeze sim:/alu/operand2 32'h00000003 0
run

# ----- Test for multiplication -----
#	operand1 = 0x05
#	operand2 = 0x03
#	expectedResult = 0x0F
#	expectedError = 0x0000

force -freeze sim:/alu/operation 4'h4 0
force -freeze sim:/alu/operand1 32'h00000005 0
force -freeze sim:/alu/operand2 32'h00000003 0
run

# ----- Test for signed division -----
#	operand1 = 0x09
#	operand2 = 0x03
#	expectedResult = 0x03
#	expectedError = 0x0000

force -freeze sim:/alu/operation 4'h5 0
force -freeze sim:/alu/operand1 32'h00000009 0
force -freeze sim:/alu/operand2 32'h00000003 0
run


# Show division by zero
#	operand1 = 0x09
#	operand2 = 0x00
# expectedResult = 0x00
#	expectedError = 0x0010 (division by zero)

force -freeze sim:/alu/operand2 32'h00000000 0
run


# ----- Test for Bitwise AND -----
# 	operand1 = 0x000ab538 
#	operand2 = 0x000ab472
#	expectedResult = 0x00000000000010101011010000110000 (binary)
#	expectedError = 0x0000

force -freeze sim:/alu/operation 4'h7 0
force -freeze sim:/alu/operand1 32'h000ab538 0
force -freeze sim:/alu/operand2 32'h000ab472 0


# ----- Test for Bitwise OR -----
# 	operand1 = 0x000ab538
#	operand2 = 0x000ab476
#	expectedResult = 0x00000000000010101011010101111110 (binary)
#	expectedError = 0x0000

force -freeze sim:/alu/operand1 32'h000ab538 0
force -freeze sim:/alu/operand2 32'h000ab476 0
force -freeze sim:/alu/operation 4'h9 0
run


# ----- Test for Bitwise NOT (Op1) -----
# 	operand1 = 0x000ab538
#	expectedResult = 0x11111111111101010100101011000111 (binary)
#	expectedError = 0x0000

force -freeze sim:/alu/operation 4'hb 0
force -freeze sim:/alu/operand1 32'h000ab538 0
run


# ----- Test for Operand1 Through Output -----
# 	operand1 = 0x00abcdef
#	expectedResult = 0x00000000101010111100110111101111 (binary)
#	expectedError = 0x0000

force -freeze sim:/alu/operation 4'hc 0
force -freeze sim:/alu/operand1 32'habcdef 0
run


# ----- Test for Operand2 Through Output -----
# 	operand2 = 0x00abcdef
#	expectedResult = 0x
#	expectedError = 0x0000

force -freeze sim:/alu/operation 4'hd 0
force -freeze sim:/alu/operand2 32'h00abcdef 0
run


# ----- Test for All Zeroes ----- 
# 	operand1 = 0x00004d32
#   operand2 = 0x11123421
#	expectedResult = 0x0
#	expectedError = 0x0000

force -freeze sim:/alu/operand2 32'h11123421 0
force -freeze sim:/alu/operand1 32'h0004d32 0
force -freeze sim:/alu/operation 4'he 0
run


# ----- Test for All Ones ----- 
# 	operand1 = 0x00000ded
#   operand2 = 0x00000fff
#	expectedResult = 0x11111111111111111111111111111111 (binary)
#	expectedError = 0x0000

force -freeze sim:/alu/operation 4'hf 0
force -freeze sim:/alu/operand1 32'h00000ded 0
force -freeze sim:/alu/operand2 32'h000fff 0
run


