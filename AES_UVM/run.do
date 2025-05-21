vlog +acc testbench.sv +incdir+C:/questasim64_10.7c/verilog_src/uvm-1.1d/src
vsim work.aes_tb -assertdebug -sv_lib C:/questasim64_10.7c/uvm-1.1d/win64/uvm_dpi -l run.log
add wave -position insertpoint sim:/aes_tb/*
add wave -position insertpoint sim:/aes_tb/aes_intf/*
run -all
