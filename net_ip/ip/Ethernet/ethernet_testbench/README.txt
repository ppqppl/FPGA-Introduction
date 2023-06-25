The simulation testbench is available for both Verilog and VHDL.

To generate the Verilog simulation model, open the Quartus project "generate_sim.qpf" and
select Tools -> Tcl Scripts... -> generate_sim_verilog.tcl and click "Run".
Alternatively, you can run "quartus_sh -t generate_sim_verilog.tcl"
at a Windows or Linux command prompt.

The generated files will be found in the subdirectory "testbench_verilog/<DUT_NAME>_sim".

To generate the VHDL simulation model, open the Quartus project "generate_sim.qpf" and
select Tools -> Tcl Scripts... -> generate_sim_vhdl.tcl and click "Run".
Alternatively, you can run "quartus_sh -t generate_sim_vhdl.tcl"
at a Windows or Linux command prompt.

The generated files will be found in the subdirectory "testbench_vhdl/<DUT_NAME>_sim".

To simulate the testbench using Modelsim AE/SE:

1) Move into the directory ./testbench_verilog/<DUT_NAME> or ./testbench_vhdl/<DUT_NAME>
2) Start Modelsim and run the "run_<DUT_NAME>_tb.tcl" script: in Modelsim, enter "do run_<DUT_NAME>_tb.tcl".

