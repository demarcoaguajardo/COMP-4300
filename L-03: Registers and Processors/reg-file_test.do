add wave -position insertpoint  \
sim:/reg_file/registers \
sim:/reg_file/reg_number \
sim:/reg_file/readnotwrite \
sim:/reg_file/prop_delay \
sim:/reg_file/data_out \
sim:/reg_file/data_in \
sim:/reg_file/clock

run 45
force -freeze sim:/reg_file/reg_number 5'h0C 0
force -freeze sim:/reg_file/data_in 32'h88888888 0
run 45
force -freeze sim:/reg_file/clock 1 0
run 45
force -freeze sim:/reg_file/reg_number 5'h0C 0
force -freeze sim:/reg_file/data_in 32'h44444444 0
run 45
force -freeze sim:/reg_file/readnotwrite 1
run 45
force -freeze sim:/reg_file/reg_number 5'h0C 0
run 45
