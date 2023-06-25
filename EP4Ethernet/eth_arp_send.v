/***********************************************/

//Project Name : Eth_arp_send
//Email		   :
//Create Time	: 2021/05/13 16:33
//Editor       : Liu
//Version		: Rev1.0.0

/***********************************************/
module  eth_arp_send(
        input                   clk                             ,
        input                   rst_n                           ,
        //Eth
        input                   arp_ack_trig                    ,
        input                   arp_req_trig                    ,
        input         [31: 0]   arp_src_ip                      ,
        input         [31: 0]   arp_dst_ip                      ,
        input         [47: 0]   arp_src_mac                     ,
        input         [47: 0]   arp_dst_mac                     ,
		  output             	  add_cnt								 ,
        output  reg   [ 7: 0]   arp_data							    ,
		  input			 [31: 0]	  crc_data								 ,
		  output  reg             crc_en
);
//======================================================================\
//************** Define Parameter and Internal Signals *****************
//======================================================================/
//cnt
reg     [ 6: 0]                 cnt                             ;

wire                            end_cnt                         ;

reg     [15: 0]                 opcode                          ;
reg                             flag                            ;

//======================================================================\
//**************************** Main Code *******************************
//======================================================================/

//opcode
always  @(posedge clk or negedge rst_n)begin
    if(rst_n == 1'b0)begin
        opcode  <=  16'd0;
    end
    else if(arp_ack_trig)begin
        opcode  <=  16'd2;
    end
    else if(arp_req_trig)begin
        opcode  <=  16'd1;
    end
end

//cnt
always @(posedge clk or negedge rst_n)begin
    if(!rst_n)begin
        cnt <= 0;
    end
    else if(add_cnt)begin
        if(end_cnt)
            cnt <= 0;
        else
            cnt <= cnt + 1;
    end
end

assign  add_cnt     =       flag;       
assign  end_cnt     =       add_cnt && cnt == 72-1;   

//flag
always  @(posedge clk or negedge rst_n)begin
    if(rst_n == 1'b0)begin
        flag    <=  1'b0;
    end
    else if(arp_ack_trig || arp_req_trig)begin
        flag    <=  1'b1;
    end
    else if(end_cnt)begin
        flag    <=  1'b0;
    end
end

//arp_data
always  @(posedge clk or negedge rst_n)begin
    if(rst_n == 1'b0)begin
        arp_data   <=  8'h00;
    end
    else if(add_cnt)begin
        case(cnt)
				//前导码
				00:arp_data    <=  8'h55;
				01:arp_data    <=  8'h55;
            02:arp_data    <=  8'h55;
            03:arp_data    <=  8'h55;    
            04:arp_data    <=  8'h55;   
            05:arp_data    <=  8'h55;
				06:arp_data    <=  8'h55;
				07:arp_data    <=  8'hd5;
				08:begin
					arp_data    <=  8'hff;
					crc_en		<=  1'b1 ;
					end
				09:arp_data    <=  8'hff;
				10:arp_data    <=  8'hff;
				11:arp_data    <=  8'hff;
				12:arp_data    <=  8'hff;
				13:arp_data    <=  8'hff;
				14:arp_data    <=  arp_src_mac[47:40];
            15:arp_data    <=  arp_src_mac[39:32];
            16:arp_data    <=  arp_src_mac[31:24];
            17:arp_data    <=  arp_src_mac[23:16];
            18:arp_data    <=  arp_src_mac[15: 8];
            19:arp_data    <=  arp_src_mac[ 7: 0];
				//type
				20:arp_data    <=  8'h08;
				21:arp_data    <=  8'h06;
            //hdwr_type
            22:arp_data    <=  8'h00;
            23:arp_data    <=  8'h01;
            //protocol_type
            24:arp_data    <=  8'h08;
            25:arp_data    <=  8'h00;
            //hdwr_size
            26:arp_data    <=  8'h06;
            //protocol_size
            27:arp_data    <=  8'h04;
            //opcode
            28:arp_data    <=  opcode[15:8];
            29:arp_data    <=  opcode[ 7:0];
            //sender_mac
            30:arp_data    <=  arp_src_mac[47:40];
            31:arp_data    <=  arp_src_mac[39:32];
            32:arp_data    <=  arp_src_mac[31:24];
            33:arp_data    <=  arp_src_mac[23:16];
            34:arp_data    <=  arp_src_mac[15: 8];
            35:arp_data    <=  arp_src_mac[ 7: 0];
            //sender_ip
            36:arp_data    <=  arp_src_ip[31:24];
            37:arp_data    <=  arp_src_ip[23:16];
            38:arp_data    <=  arp_src_ip[15: 8];
            39:arp_data    <=  arp_src_ip[ 7: 0];
            //target_mac
            40:arp_data    <=  8'h00;
            41:arp_data    <=  8'h00;
            42:arp_data    <=  8'h00;
            43:arp_data    <=  8'h00;
            44:arp_data    <=  8'h00;
            45:arp_data    <=  8'h00;
            //target_ip
            46:arp_data    <=  arp_dst_ip[31:24];
            47:arp_data    <=  arp_dst_ip[23:16];
            48:arp_data    <=  arp_dst_ip[15: 8];
            49:arp_data    <=  arp_dst_ip[ 7: 0];
				//padding
				50:arp_data    <=  8'h00;
				51:arp_data    <=  8'h00;
				52:arp_data    <=  8'h00;
				53:arp_data    <=  8'h00;				    
            54:arp_data    <=  8'h00;
				55:arp_data    <=  8'h00;
				56:arp_data    <=  8'h00;
				57:arp_data    <=  8'h00;
				58:arp_data    <=  8'h00;
				59:arp_data    <=  8'h00;
				60:arp_data    <=  8'h00;
				61:arp_data    <=  8'h00;
				62:arp_data    <=  8'h00;
				63:arp_data    <=  8'h00;
				64:arp_data    <=  8'h00;
				65:arp_data    <=  8'h00;
				66:arp_data    <=  8'h00;
				67:arp_data    <=  8'h00;
				//arp校验
				68:begin
					arp_data    <=  {~crc_data[24],~crc_data[25],~crc_data[26],
                                   ~crc_data[27], ~crc_data[28],~crc_data[29],~crc_data[30],~crc_data[31]};
					crc_en 		<=  1'b0;
					end
            69:arp_data    <=  {~crc_data[16],~crc_data[17],~crc_data[18],
                                   ~crc_data[19],~crc_data[20],~crc_data[21],~crc_data[22], ~crc_data[23]};
            70:arp_data    <=  {~crc_data[8],~crc_data[9],~crc_data[10],
											  ~crc_data[11], ~crc_data[12],~crc_data[13],~crc_data[14], ~crc_data[15]};                   
            71:arp_data    <=  {~crc_data[0],~crc_data[1],~crc_data[2],
                                  ~crc_data[3], ~crc_data[4],~crc_data[5],~crc_data[6], ~crc_data[7]};
				default:begin
                arp_data   <=  8'h00;
            end
        endcase
    end
end

endmodule
