alll: workab compilee test_case1 test_case2
workab:
	vlib work
compilee:
	vlog APB_TOP.sv 
test_case1:	
	vsim work.apb_top -c +UVM_TESTNAME=apb_test1 -l run.log
test_case2:	
	vsim work.apb_top -c +UVM_TESTNAME=apb_test2 -l run.log
test_case3:
	vsim work.apb_top -c +UVM_TESTNAME=apb_test3 -l run.log
test_case4:
	vsim work.apb_top -c +UVM_TESTNAME=apb_test4 -l run.log
test_case5:
	vsim work.apb_top -c +UVM_TESTNAME=apb_test5 -l run.log
test_case6:
	vsim work.apb_top -c +UVM_TESTNAME=apb_test6 -l run.log
test_case7:
	vsim work.apb_top -c +UVM_TESTNAME=apb_test7 -l run.log
runalll:
	run -all
