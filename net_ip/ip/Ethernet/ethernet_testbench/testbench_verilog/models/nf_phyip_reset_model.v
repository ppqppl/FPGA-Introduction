// (C) 2001-2018 Intel Corporation. All rights reserved.
// Your use of Intel Corporation's design tools, logic functions and other 
// software and tools, and its AMPP partner logic functions, and any output 
// files from any of the foregoing (including device programming or simulation 
// files), and any associated documentation or information are expressly subject 
// to the terms and conditions of the Intel Program License Subscription 
// Agreement, Intel FPGA IP License Agreement, or other applicable 
// license agreement, including, without limitation, that your use is for the 
// sole purpose of programming logic devices manufactured by Intel and sold by 
// Intel or its authorized distributors.  Please refer to the applicable 
// agreement for further details.


// -------------------------------------------------------------------------
// -------------------------------------------------------------------------
//
// Project     : Triple Speed Ethernet - 10/100/1000 MAC
//
// Description : Simulation model for NightFury PHYIP reset sequence
// 
// ALTERA Confidential and Proprietary
// Copyright 2006 (c) Altera Corporation
// All rights reserved
//
// -------------------------------------------------------------------------
// -------------------------------------------------------------------------

`timescale 1 ps / 1 ps

module nf_phyip_reset_model
(
   input clk, // 125 MHz clock
   input reset,

   output tx_serial_clk, // TX serial clock
   output reg tx_analogreset,
   output reg tx_digitalreset,
   output tx_ready,

   output reg rx_analogreset,
   output reg rx_digitalreset,
   output rx_ready,

   input tx_cal_busy,
   input rx_is_lockedtodata,
   input rx_cal_busy

);

reg clk_1250MHz;

reg [31:0] tx_digital_reset_count;
reg [31:0] rx_digital_reset_count;
reg [31:0] tx_ready_count;
reg [31:0] rx_ready_count;

// 1250 MHz TX serial clock
always 
begin
   clk_1250MHz <= 1'b 1;   
   #(400); 
   clk_1250MHz <= 1'b 0;   
   #(400); 
end

assign tx_serial_clk = clk_1250MHz;

// TX digital reset duration
always @(posedge clk or posedge tx_analogreset)
begin
   if (tx_analogreset)
   begin
      tx_digital_reset_count <= 625; // 5000ns
   end
   else
   begin
      if ((tx_digital_reset_count != 0) && (tx_cal_busy == 1'b0))
      begin
         tx_digital_reset_count <= tx_digital_reset_count - 32'b1;
      end
   end
end

// RX digital reset duration
always @(posedge clk or posedge rx_analogreset)
begin
   if (rx_analogreset)
   begin
      rx_digital_reset_count <= 500; // 4000ns
   end
   else
   begin
      if ((rx_digital_reset_count != 0) && (rx_cal_busy == 1'b0) && (rx_is_lockedtodata == 1'b1))
      begin
         rx_digital_reset_count <= rx_digital_reset_count - 32'b1;
      end
   end
end

// TX ready duration
always @(posedge clk or posedge reset)
begin
   if (reset)
   begin
      tx_ready_count <= 10; // 80ns
   end
   else
   begin
      if ((tx_digitalreset == 1'b0) && (tx_ready_count != 0))
      begin
         tx_ready_count <= tx_ready_count - 32'b1;
      end
   end
end

// RX ready duration
always @(posedge clk or posedge reset)
begin
   if (reset)
   begin
      rx_ready_count <= 10; // 80ns
   end
   else
   begin
      if ((rx_digitalreset == 1'b0) && (rx_ready_count != 0))
      begin
         rx_ready_count <= rx_ready_count - 32'b1;
      end
   end
end

always @(posedge clk or posedge reset)
begin
   if (reset)
   begin
      tx_analogreset <= 1'b1;
      rx_analogreset <= 1'b1;
   end
   else
   begin
      tx_analogreset <= 1'b0;
      rx_analogreset <= 1'b0;
   end
end

always @(posedge clk or posedge reset)
begin
   if (reset)
   begin
      tx_digitalreset <= 1'b1;
   end
   else
   begin
      if (tx_digital_reset_count == 0)
      begin
         tx_digitalreset <= 1'b0;
      end
   end
end

always @(posedge clk or posedge reset)
begin
   if (reset)
   begin
      rx_digitalreset <= 1'b1;
   end
   else
   begin
      if (rx_digital_reset_count == 0)
      begin
         rx_digitalreset <= 1'b0;
      end
   end
end

assign tx_ready = (tx_ready_count == 0) ? 1'b1: 1'b0;
assign rx_ready = (rx_ready_count == 0) ? 1'b1: 1'b0;

endmodule
