// ==============================================================
// File generated on Sat May 13 12:45:57 +0800 2023
// Vivado(TM) HLS - High-Level Synthesis from C, C++ and SystemC v2018.3 (64-bit)
// SW Build 2405991 on Thu Dec  6 23:38:27 MST 2018
// IP Build 2404404 on Fri Dec  7 01:43:56 MST 2018
// Copyright 1986-2018 Xilinx, Inc. All Rights Reserved.
// ==============================================================

#define AP_INT_MAX_W 32678

#include <systemc>
#include <iostream>
#include <cstdlib>
#include <cstddef>
#include <stdint.h>
#include "SysCFileHandler.h"
#include "ap_int.h"
#include "ap_fixed.h"
#include <complex>
#include <stdbool.h>
#include "autopilot_cbe.h"
#include "hls_stream.h"
#include "hls_half.h"
#include "hls_signal_handler.h"

using namespace std;
using namespace sc_core;
using namespace sc_dt;


// [dump_struct_tree [build_nameSpaceTree] dumpedStructList] ---------->


// [dump_enumeration [get_enumeration_list]] ---------->


// wrapc file define: "led_o_V"
#define AUTOTB_TVOUT_led_o_V  "../tv/cdatafile/c.flash_led.autotvout_led_o_V.dat"
// wrapc file define: "led_i_V"
#define AUTOTB_TVIN_led_i_V  "../tv/cdatafile/c.flash_led.autotvin_led_i_V.dat"

#define INTER_TCL  "../tv/cdatafile/ref.tcl"

// tvout file define: "led_o_V"
#define AUTOTB_TVOUT_PC_led_o_V  "../tv/rtldatafile/rtl.flash_led.autotvout_led_o_V.dat"

class INTER_TCL_FILE {
	public:
		INTER_TCL_FILE(const char* name) {
			mName = name;
			led_o_V_depth = 0;
			led_i_V_depth = 0;
			trans_num =0;
		}

		~INTER_TCL_FILE() {
			mFile.open(mName);
			if (!mFile.good()) {
				cout << "Failed to open file ref.tcl" << endl;
				exit (1);
			}
			string total_list = get_depth_list();
			mFile << "set depth_list {\n";
			mFile << total_list;
			mFile << "}\n";
			mFile << "set trans_num "<<trans_num<<endl;
			mFile.close();
		}

		string get_depth_list () {
			stringstream total_list;
			total_list << "{led_o_V " << led_o_V_depth << "}\n";
			total_list << "{led_i_V " << led_i_V_depth << "}\n";
			return total_list.str();
		}

		void set_num (int num , int* class_num) {
			(*class_num) = (*class_num) > num ? (*class_num) : num;
		}
	public:
		int led_o_V_depth;
		int led_i_V_depth;
		int trans_num;

	private:
		ofstream mFile;
		const char* mName;
};

extern void flash_led (
ap_int<1>* led_o,
ap_int<1> led_i);

void AESL_WRAP_flash_led (
ap_int<1>* led_o,
ap_int<1> led_i)
{
	refine_signal_handler();
	fstream wrapc_switch_file_token;
	wrapc_switch_file_token.open(".hls_cosim_wrapc_switch.log");
	int AESL_i;
	if (wrapc_switch_file_token.good())
	{
		CodeState = ENTER_WRAPC_PC;
		static unsigned AESL_transaction_pc = 0;
		string AESL_token;
		string AESL_num;
		static AESL_FILE_HANDLER aesl_fh;


		// output port post check: "led_o_V"
		aesl_fh.read(AUTOTB_TVOUT_PC_led_o_V, AESL_token); // [[transaction]]
		if (AESL_token != "[[transaction]]")
		{
			exit(1);
		}
		aesl_fh.read(AUTOTB_TVOUT_PC_led_o_V, AESL_num); // transaction number

		if (atoi(AESL_num.c_str()) == AESL_transaction_pc)
		{
			aesl_fh.read(AUTOTB_TVOUT_PC_led_o_V, AESL_token); // data

			sc_bv<1> *led_o_V_pc_buffer = new sc_bv<1>[1];
			int i = 0;

			while (AESL_token != "[[/transaction]]")
			{
				bool no_x = false;
				bool err = false;

				// search and replace 'X' with "0" from the 1st char of token
				while (!no_x)
				{
					size_t x_found = AESL_token.find('X');
					if (x_found != string::npos)
					{
						if (!err)
						{
							cerr << "WARNING: [SIM 212-201] RTL produces unknown value 'X' on port 'led_o_V', possible cause: There are uninitialized variables in the C design." << endl;
							err = true;
						}
						AESL_token.replace(x_found, 1, "0");
					}
					else
					{
						no_x = true;
					}
				}

				no_x = false;

				// search and replace 'x' with "0" from the 3rd char of token
				while (!no_x)
				{
					size_t x_found = AESL_token.find('x', 2);

					if (x_found != string::npos)
					{
						if (!err)
						{
							cerr << "WARNING: [SIM 212-201] RTL produces unknown value 'X' on port 'led_o_V', possible cause: There are uninitialized variables in the C design." << endl;
							err = true;
						}
						AESL_token.replace(x_found, 1, "0");
					}
					else
					{
						no_x = true;
					}
				}

				// push token into output port buffer
				if (AESL_token != "")
				{
					led_o_V_pc_buffer[i] = AESL_token.c_str();
					i++;
				}

				aesl_fh.read(AUTOTB_TVOUT_PC_led_o_V, AESL_token); // data or [[/transaction]]

				if (AESL_token == "[[[/runtime]]]" || aesl_fh.eof(AUTOTB_TVOUT_PC_led_o_V))
				{
					exit(1);
				}
			}

			// ***********************************
			if (i > 0)
			{
				// RTL Name: led_o_V
				{
					// bitslice(0, 0)
					// {
						// celement: led_o.V(0, 0)
						// {
							sc_lv<1>* led_o_V_lv0_0_0_1 = new sc_lv<1>[1];
						// }
					// }

					// bitslice(0, 0)
					{
						int hls_map_index = 0;
						// celement: led_o.V(0, 0)
						{
							// carray: (0) => (0) @ (1)
							for (int i_0 = 0; i_0 <= 0; i_0 += 1)
							{
								if (&(led_o[0]) != NULL) // check the null address if the c port is array or others
								{
									led_o_V_lv0_0_0_1[hls_map_index].range(0, 0) = sc_bv<1>(led_o_V_pc_buffer[hls_map_index].range(0, 0));
									hls_map_index++;
								}
							}
						}
					}

					// bitslice(0, 0)
					{
						int hls_map_index = 0;
						// celement: led_o.V(0, 0)
						{
							// carray: (0) => (0) @ (1)
							for (int i_0 = 0; i_0 <= 0; i_0 += 1)
							{
								// sub                    : i_0
								// ori_name               : led_o[i_0]
								// sub_1st_elem           : 0
								// ori_name_1st_elem      : led_o[0]
								// output_left_conversion : led_o[i_0]
								// output_type_conversion : (led_o_V_lv0_0_0_1[hls_map_index]).to_string(SC_BIN).c_str()
								if (&(led_o[0]) != NULL) // check the null address if the c port is array or others
								{
									led_o[i_0] = (led_o_V_lv0_0_0_1[hls_map_index]).to_string(SC_BIN).c_str();
									hls_map_index++;
								}
							}
						}
					}
				}
			}

			// release memory allocation
			delete [] led_o_V_pc_buffer;
		}

		AESL_transaction_pc++;
	}
	else
	{
		CodeState = ENTER_WRAPC;
		static unsigned AESL_transaction;

		static AESL_FILE_HANDLER aesl_fh;

		// "led_o_V"
		char* tvout_led_o_V = new char[50];
		aesl_fh.touch(AUTOTB_TVOUT_led_o_V);

		// "led_i_V"
		char* tvin_led_i_V = new char[50];
		aesl_fh.touch(AUTOTB_TVIN_led_i_V);

		CodeState = DUMP_INPUTS;
		static INTER_TCL_FILE tcl_file(INTER_TCL);
		int leading_zero;

		// [[transaction]]
		sprintf(tvin_led_i_V, "[[transaction]] %d\n", AESL_transaction);
		aesl_fh.write(AUTOTB_TVIN_led_i_V, tvin_led_i_V);

		sc_bv<1> led_i_V_tvin_wrapc_buffer;

		// RTL Name: led_i_V
		{
			// bitslice(0, 0)
			{
				// celement: led_i.V(0, 0)
				{
					// carray: (0) => (0) @ (0)
					{
						// sub                   : 
						// ori_name              : led_i
						// sub_1st_elem          : 
						// ori_name_1st_elem     : led_i
						// regulate_c_name       : led_i_V
						// input_type_conversion : (led_i).to_string(2).c_str()
						if (&(led_i) != NULL) // check the null address if the c port is array or others
						{
							sc_lv<1> led_i_V_tmp_mem;
							led_i_V_tmp_mem = (led_i).to_string(2).c_str();
							led_i_V_tvin_wrapc_buffer.range(0, 0) = led_i_V_tmp_mem.range(0, 0);
						}
					}
				}
			}
		}

		// dump tv to file
		for (int i = 0; i < 1; i++)
		{
			sprintf(tvin_led_i_V, "%s\n", (led_i_V_tvin_wrapc_buffer).to_string(SC_HEX).c_str());
			aesl_fh.write(AUTOTB_TVIN_led_i_V, tvin_led_i_V);
		}

		tcl_file.set_num(1, &tcl_file.led_i_V_depth);
		sprintf(tvin_led_i_V, "[[/transaction]] \n");
		aesl_fh.write(AUTOTB_TVIN_led_i_V, tvin_led_i_V);

// [call_c_dut] ---------->

		CodeState = CALL_C_DUT;
		flash_led(led_o, led_i);

		CodeState = DUMP_OUTPUTS;

		// [[transaction]]
		sprintf(tvout_led_o_V, "[[transaction]] %d\n", AESL_transaction);
		aesl_fh.write(AUTOTB_TVOUT_led_o_V, tvout_led_o_V);

		sc_bv<1>* led_o_V_tvout_wrapc_buffer = new sc_bv<1>[1];

		// RTL Name: led_o_V
		{
			// bitslice(0, 0)
			{
				int hls_map_index = 0;
				// celement: led_o.V(0, 0)
				{
					// carray: (0) => (0) @ (1)
					for (int i_0 = 0; i_0 <= 0; i_0 += 1)
					{
						// sub                   : i_0
						// ori_name              : led_o[i_0]
						// sub_1st_elem          : 0
						// ori_name_1st_elem     : led_o[0]
						// regulate_c_name       : led_o_V
						// input_type_conversion : (led_o[i_0]).to_string(2).c_str()
						if (&(led_o[0]) != NULL) // check the null address if the c port is array or others
						{
							sc_lv<1> led_o_V_tmp_mem;
							led_o_V_tmp_mem = (led_o[i_0]).to_string(2).c_str();
							led_o_V_tvout_wrapc_buffer[hls_map_index].range(0, 0) = led_o_V_tmp_mem.range(0, 0);
                                 	       hls_map_index++;
						}
					}
				}
			}
		}

		// dump tv to file
		for (int i = 0; i < 1; i++)
		{
			sprintf(tvout_led_o_V, "%s\n", (led_o_V_tvout_wrapc_buffer[i]).to_string(SC_HEX).c_str());
			aesl_fh.write(AUTOTB_TVOUT_led_o_V, tvout_led_o_V);
		}

		tcl_file.set_num(1, &tcl_file.led_o_V_depth);
		sprintf(tvout_led_o_V, "[[/transaction]] \n");
		aesl_fh.write(AUTOTB_TVOUT_led_o_V, tvout_led_o_V);

		// release memory allocation
		delete [] led_o_V_tvout_wrapc_buffer;

		CodeState = DELETE_CHAR_BUFFERS;
		// release memory allocation: "led_o_V"
		delete [] tvout_led_o_V;
		// release memory allocation: "led_i_V"
		delete [] tvin_led_i_V;

		AESL_transaction++;

		tcl_file.set_num(AESL_transaction , &tcl_file.trans_num);
	}
}

