add wave -position insertpoint  \
sim:/mux/which \
sim:/mux/prop_delay \
sim:/mux/output \
sim:/mux/input_1 \
sim:/mux/input_0

run 20
force -freeze sim:/mux/input_0 32'h000000AD 0
force -freeze sim:/mux/which 0 0
run 20
force -freeze sim:/mux/input_1 32'h000000BE 0
force -freeze sim:/mux/which 1 0
run 20
force -freeze sim:/mux/input_0 32'h000000FF 0
force -freeze sim:/mux/which 0 0
run 20
force -freeze sim:/mux/input_1 32'h000000AA 0
force -freeze sim:/mux/which 1 0
run 20