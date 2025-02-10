add wave -position insertpoint  \
sim:/dlx_register/prop_delay \
sim:/dlx_register/out_val \
sim:/dlx_register/in_val \
sim:/dlx_register/clock

run 25
force -freeze sim:/dlx_register/in_val 32'h000000AD 0
run 25
force -freeze sim:/dlx_register/in_val 32'h00000000 25
run 25
force -freeze sim:/dlx_register/clock 1 0
run 25
force -freeze sim:/dlx_register/in_val 32'h000000AD 0
run 25
force -freeze sim:/dlx_register/in_val 32'h00000000 25