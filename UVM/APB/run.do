vlog +acc APB_TOP.sv +incdir+C:/questasim64_10.7c/verilog_src/uvm-1.1d/src
vsim work.apb_top -assertdebug -sv_lib C:/questasim64_10.7c/uvm-1.1d/win64/uvm_dpi -l run.log
#run -all
add wave -position insertpoint  \
sim:/apb_top/intf/pwrite \
sim:/apb_top/intf/pwdata \
sim:/apb_top/intf/psel \
sim:/apb_top/intf/prst \
sim:/apb_top/intf/pready \
sim:/apb_top/intf/prdata \
sim:/apb_top/intf/pen \
sim:/apb_top/intf/pclk \
sim:/apb_top/intf/paddr
add wave /apb_top/dut/uut/aa/rst_check /apb_top/dut/uut/aa/data_check1 /apb_top/dut/uut/aa/data_check2 /apb_top/dut/uut/aa/read_check /apb_top/dut/uut/aa/setup_check /apb_top/dut/uut/aa/access_check
run -all

