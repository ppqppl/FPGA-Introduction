`timescale 1 ns / 1 ps
 
module tri_speed_ip_top
(
    input clk,
    input rst_n,
 
    //user control interface
    input ff_tx_start,
    output reg ff_tx_done
);
 
//control interface, config register, the ip core is Avalon MM slave interface
    reg reg_wr;
    reg reg_rd;
    reg [7:0] reg_addr;
    reg [31:0] reg_data_in;
    wire [31:0] reg_data_out;
    wire reg_busy;
 
    reg reg_busy_reg;
    always@(posedge clk, negedge rst_n)
    begin
        if (!rst_n) begin         
            reg_busy_reg <= 1'b0 ;        
        end
        else        
            reg_busy_reg <= reg_busy ;                
    end
 
    reg[7:0] config_cnt;
    parameter CONFIG_CNT_MAX = 18; // the number of register will be configured
    always@(posedge clk, negedge rst_n)
    begin
        if (!rst_n) begin         
            config_cnt <= 8'd1 ; 
        end
        else if(reg_busy == 1'b0  && reg_busy_reg == 1'b1) begin 
            if(config_cnt == CONFIG_CNT_MAX)
                config_cnt <= 8'd0;                
            else 
                config_cnt <= config_cnt + 1'b1;
        end
        else begin
            config_cnt <= config_cnt;
        end
    end 
 
always @(posedge clk, negedge rst_n)
   begin : config_register
   if (!rst_n) begin
      reg_wr <= #(2)1'b 0;  
      reg_rd <= #(2)1'b 0;  
      reg_addr <= #(2) {8{1'b 0}};  
      reg_data_in <= #(2)  {32{1'b 0}}; 
    end
    else begin
        case(config_cnt)
            1: begin // read ip core version info to test, the 8'd0 register is read only
                reg_wr <= #(2)1'b 0;  
                reg_rd <= #(2)1'b 1;  
                reg_addr <= #(2) {8{1'b 0}};  
                reg_data_in <= #(2)  {32{1'b 0}};                 
            end
 
            2: begin // write scratch register
                    reg_wr <= #(2)1'b 1;   
                    reg_rd <= #(2) 1'b 0;  
                    reg_addr <= #(2) 1;    
                    reg_data_in <= #(2)  32'h AAAAAAAA;                   
            end
 
            3: begin // commond config register, include many control signal
                    reg_wr <= #(2)1'b 1;   
                    reg_rd <= #(2) 1'b 0;  
                    reg_addr <= #(2) 2;   // 8'h02 register
                    reg_data_in <= #(2)  32'h 0400003b;  
 
                    //reg_data_in[0] <= #(2) 1'b 1;       // Enable tx
                    //reg_data_in[1] <= #(2) 1'b 1;       // Enable rx 
               //reg_data_in[3] <= #(2) 1'b 1;       // speed:1000M           
            end
 
            4: begin // read commond config register, adder is 8'd2;
                reg_wr <= #(2)1'b 0;  
                reg_rd <= #(2)1'b 1;  
                reg_addr <= #(2) 2;  
                reg_data_in <= #(2)  {32{1'b 0}};                
            end
                 
                5 : begin
                    reg_wr <= #(2)1'b 1;   
                    reg_rd <= #(2) 1'b 0;  
                    reg_addr <= #(2) 3;   // 8'h03 register, des mac address, most 4 bytes, source mac address is 48'h h00_2b_67_b5_2e_46;
                    reg_data_in <= #(2)  32'h b5672b00;                      
                end
             
            6 : begin
                    reg_wr <= #(2)1'b 1;   
                    reg_rd <= #(2) 1'b 0;  
                    reg_addr <= #(2) 4;   // 8'h04 register, mac address, low 2 bytes, reverse order
                    reg_data_in <= #(2)  32'h 0000462e;                 
            end
 
            7 : begin
                    reg_wr <= #(2)1'b 1;   
                    reg_rd <= #(2) 1'b 0;  
                    reg_addr <= #(2) 8'h17;   // tx_ipg_length
                    reg_data_in <= #(2)  32'h 0000000c;   // 12                   
            end
 
            8 : begin
                    reg_wr <= #(2)1'b 1;   
                    reg_rd <= #(2) 1'b 0;  
                    reg_addr <= #(2) 8'h05;   // frm_length
                    reg_data_in <= #(2)  32'h 000005ee;   // 1518                  
            end
 
            9 : begin
                    reg_wr <= #(2)1'b 1;   
                    reg_rd <= #(2) 1'b 0;  
                    reg_addr <= #(2) 8'h06;   // pause quanta
                    reg_data_in <= #(2)  32'h 0000000f;                
            end
 
            10: begin
                    reg_wr <= #(2)1'b 1;   
                    reg_rd <= #(2) 1'b 0;  
                    reg_addr <= #(2) 8'h07;   // rx_section_empty
                    reg_data_in <= #(2)  32'h 00000000;                
            end
 
            11: begin
                    reg_wr <= #(2)1'b 1;   
                    reg_rd <= #(2) 1'b 0;  
                    reg_addr <= #(2) 8'h08;   // rx_section_full
                    reg_data_in <= #(2)  32'h 00000010;                
            end
 
            12: begin
                    reg_wr <= #(2)1'b 1;   
                    reg_rd <= #(2) 1'b 0;  
                    reg_addr <= #(2) 8'h09;   // tx_section_empty
                    reg_data_in <= #(2)  32'h 00000010;                
            end
 
            13: begin
                    reg_wr <= #(2)1'b 1;   
                    reg_rd <= #(2) 1'b 0;  
                    reg_addr <= #(2) 8'h0a;   // tx_section_full
                    reg_data_in <= #(2)  32'h 00000010;                
            end
 
            14: begin
                    reg_wr <= #(2)1'b 1;   
                    reg_rd <= #(2) 1'b 0;  
                    reg_addr <= #(2) 8'h0b;   // rx_almost_empty
                    reg_data_in <= #(2)  32'h 00000008;                
            end
 
            15: begin
                    reg_wr <= #(2)1'b 1;   
                    reg_rd <= #(2) 1'b 0;  
                    reg_addr <= #(2) 8'h0c;   // rx_almost_full
                    reg_data_in <= #(2)  32'h 00000008;                
            end
 
            16: begin
                    reg_wr <= #(2)1'b 1;   
                    reg_rd <= #(2) 1'b 0;  
                    reg_addr <= #(2) 8'h0d;   // tx_almost_empty
                    reg_data_in <= #(2)  32'h 00000008;                
            end
 
            17: begin
                    reg_wr <= #(2)1'b 1;   
                    reg_rd <= #(2) 1'b 0;  
                    reg_addr <= #(2) 8'h0e;   // tx_almost_full
                    reg_data_in <= #(2)  32'h 0000000a;                
            end
 
            18: begin
                    reg_wr <= #(2)1'b 1;   
                    reg_rd <= #(2) 1'b 0;  
                    reg_addr <= #(2) 8'h7a;   //no this register 
                    reg_data_in <= #(2)  32'h 00000001;                
            end
 
            default : begin
                reg_wr <= #(2)1'b 0;  
                reg_rd <= #(2)1'b 0;  
                reg_addr <= #(2) {8{1'b 0}};  
                reg_data_in <= #(2)  {32{1'b 0}};              
            end
        endcase
    end
end
 
// end control interface config register, the ip core is Avalon MM slave interface
 
//write data to tx fifo
    wire ff_tx_clk; //125MHz
 
    reg[31:0] ff_tx_data;
    reg ff_tx_sop;
    reg ff_tx_eop;
    wire ff_tx_rdy;
    reg ff_tx_wren;
    reg[1:0] ff_tx_mod;
    reg ff_tx_err;
 
    reg ff_tx_start_reg_1;
    reg ff_tx_start_reg_2;
    always@(posedge clk, negedge rst_n) begin
        if(!rst_n) begin
            ff_tx_start_reg_1 <= 1'b0;
            ff_tx_start_reg_2 <= 1'b0;   
        end
        else begin
            ff_tx_start_reg_1 <= ff_tx_start;
            ff_tx_start_reg_2 <= ff_tx_start_reg_1;
        end
    end
 
    reg ff_tx_en;
    always@(posedge clk, negedge rst_n) begin
        if(!rst_n) begin
            ff_tx_en <= 1'b0;  
        end
        else if(ff_tx_start_reg_1 && (~ ff_tx_start_reg_2)) begin
            ff_tx_en <= 1'b1;
        end
        else if(ff_tx_done) begin
            ff_tx_en <= 1'b0;
        end
        else begin
            ff_tx_en <= ff_tx_en;
        end
    end
 
    reg[9:0] ff_tx_cnt;
 
    assign ff_tx_clk = clk;
 
    always@(posedge ff_tx_clk, negedge rst_n) begin
        if(!rst_n) begin
            ff_tx_data <= 32'd0; 
            ff_tx_sop <= 1'b0;
            ff_tx_eop <= 1'b0;
            ff_tx_wren <= 1'b0;
            ff_tx_mod <= 1'b0;
            ff_tx_err <= 1'b0;
            ff_tx_cnt <= 10'd0;
            ff_tx_done <= 1'b0;
        end
        else if(ff_tx_en) begin
            ff_tx_cnt <= ff_tx_cnt + 1'b1;
            case(ff_tx_cnt) 
                0: begin
                    ff_tx_data <= 32'd0; 
                    ff_tx_sop <= 1'b0;
                    ff_tx_eop <= 1'b0;
                    ff_tx_wren <= 1'b0;
                    ff_tx_mod <= 1'b0;
                    ff_tx_err <= 1'b0; 
                    ff_tx_done <= 1'b0;                  
                end
                      
                     1: begin
                        ff_tx_data <= 32'h00_00_46_2e;  //des_mac address
                        ff_tx_sop <= 1'b1;                    
                        ff_tx_wren <= 1'b1;
                     end
 
                    2: begin
                        ff_tx_data <= 32'hb5_67_2b_00;  //des_mac_address
                        ff_tx_sop <= 1'b0;                    
                        ff_tx_wren <= 1'b1;
                     end
                      
                    3: begin
                        ff_tx_data <= 32'h22_33_44_55;  //src_mac_address              
                        ff_tx_wren <= 1'b1;
                     end
 
                    4 : begin
                        ff_tx_data <= 32'h66_aa_00_64;  //src_mac_address + data length               
                        ff_tx_wren <= 1'b1;
                    end
                      
                5 : begin
                    ff_tx_data <= 32'h6c_6c_65_68; //hell            
                    ff_tx_wren <= 1'b1;                    
                end
                                          
 
                6 : begin
                    ff_tx_data <= 32'h70_66_5f_6f; //o_fp              
                    ff_tx_wren <= 1'b1;                    
                end
 
                7 : begin
                    ff_tx_data <= 32'h21_21_61_67;  //ga!!               
                    ff_tx_wren <= 1'b1;
                 
                end
 
                8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28:  begin
                    ff_tx_data <= 32'h70_66_5f_6f; //o_fp              
                    ff_tx_wren <= 1'b1;    
                end
 
                29: begin
                    ff_tx_data <= 32'h21_21_61_67;  //ga!!   
                    ff_tx_eop <= 1'b1;                    
                    ff_tx_wren <= 1'b1;
                    ff_tx_done <= 1'b1;   
                    ff_tx_cnt <= 10'd0;                        
                end
 
                default : begin
                    ff_tx_data <= 32'd0; 
                    ff_tx_sop <= 1'b0;
                    ff_tx_eop <= 1'b0;
                    ff_tx_wren <= 1'b0;
                    ff_tx_mod <= 1'b0;
                    ff_tx_err <= 1'b0;
                    ff_tx_cnt <= 10'd0;
                    ff_tx_done <= 1'b0;
                end
            endcase
        end
 
        else begin
            ff_tx_data <= 32'd0; 
            ff_tx_sop <= 1'b0;
            ff_tx_eop <= 1'b0;
            ff_tx_wren <= 1'b0;
            ff_tx_mod <= 1'b0;
            ff_tx_err <= 1'b0;
            ff_tx_cnt <= 10'd0;
            ff_tx_done <= 1'b0;
        end
    end
 
 
 
 
//instance for tri_speed_ip core
    wire eth_mode;
 
tri_speed_ip  u_tri_speed_ip (
    .clk                     ( clk             ),
    .reset                   ( ~rst_n           ),  //this ip core's reset is high active
 
    //config register interface
    .reg_addr                ( reg_addr        ),
    .reg_rd                  ( reg_rd          ),
    .reg_data_in             ( reg_data_in     ),
    .reg_wr                  ( reg_wr          ),
    // end config register interface
 
    .tx_clk                  (  clk         ),
    .rx_clk                  (           ),
 
    //set speed
    .set_10                  (           ),
    .set_1000                (         ),
    //end speed
 
    //GMII rx interface
    .gm_rx_d                 (          ),
    .gm_rx_dv                (         ),
    .gm_rx_err               (        ),
    //end GMII rx interface
 
    //MII rx interface
    .m_rx_d                  (           ),
    .m_rx_en                 (          ),
    .m_rx_err                (         ),
    .m_rx_crs                (         ),
    .m_rx_col                (         ),
    //end MII rx interface
 
    //rx and tx fifo interface
    .ff_rx_clk               (        ),
    .ff_tx_clk               ( ff_tx_clk       ),
    .ff_rx_rdy               (        ),
    .ff_tx_data              ( ff_tx_data      ),
    .ff_tx_eop               ( ff_tx_eop       ),
    .ff_tx_err               ( ff_tx_err       ),
    .ff_tx_mod               ( ff_tx_mod       ),
    .ff_tx_sop               ( ff_tx_sop       ),
    .ff_tx_wren              ( ff_tx_wren      ),
    .mdio_in                 (          ),
    .ff_tx_crc_fwd           ( 1'b0   ), //compute CRC check, if no set value, will no compute CRC checksum, and tx_en will hold high
 
    .reg_data_out            (  reg_data_out   ),
    .reg_busy                (   reg_busy      ),    //this signal wait request
    .eth_mode                (   eth_mode      ),    //
    .ena_10                  (           ),
     
    // GMII tx interface
    .gm_tx_d                 (          ),
    .gm_tx_en                (         ),
    .gm_tx_err               (        ),
    // end GMII tx interface 
 
    //MII tx interface
    .m_tx_d                  (           ),
    .m_tx_en                 (          ),
    .m_tx_err                (         ),
    //end MII tx interface
 
    .ff_rx_data              (       ),
    .ff_rx_eop               (        ),
    .rx_err                  (           ),
    .ff_rx_mod               (        ),
    .ff_rx_sop               (        ),
    .ff_rx_dval              (       ),
    .ff_tx_rdy               (  ff_tx_rdy      ),
    .mdc                     (              ),
    .mdio_out                (         ),
    .mdio_oen                (         ),
    .ff_tx_septy             (      ),
    .tx_ff_uflow             (      ),
    .ff_tx_a_full            (     ),
    .ff_tx_a_empty           (    ),
    .rx_err_stat             (      ),
    .rx_frm_type             (      ),
    .ff_rx_dsav              (       ),
    .ff_rx_a_full            (     ),
    .ff_rx_a_empty           (    )
);
 
endmodule
