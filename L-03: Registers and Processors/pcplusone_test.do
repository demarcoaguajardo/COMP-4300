add wave -position insertpoint  \
sim:/pcplusone/prop_delay \
sim:/pcplusone/output \
sim:/pcplusone/input \
sim:/pcplusone/clock

run 20
force -freeze sim:/pcplusone/input 32'h000000AD 0
force -freeze sim:/pcplusone/clock 1 0
run 20
force -freeze sim:/pcplusone/clock 0 0
run 20
force -freeze sim:/pcplusone/input 32'h000000BE 0
force -freeze sim:/pcplusone/clock 1 0
run 20
force -freeze sim:/pcplusone/clock 0 0
run 20