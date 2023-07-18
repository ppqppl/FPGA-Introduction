module beep_driver(
    input wire sys_clk,
    input wire sys_rst_n,
    input wire [18:0] dis,
    input wire [3:0] key_flag,

    output reg beep
 );

    localparam   t1 = 27408      ;

    reg [26:0] cnt;
    reg [2:0]  cnt_500ms;
    reg [17:0] freq_cnt;
    reg [17:0] freq_data;
    wire [16:0] duty_data;
    reg         flag_s;

    wire [22:0] flag_beep;
    reg [50:0] time_week;

	// 按键判断
	always @(posedge sys_clk or negedge sys_rst_n) begin
		if(!sys_rst_n) begin
			flag_s <= 0;
		end
		else if(key_flag[0] == 1) begin
			flag_s <= 1;
		end
		else if(key_flag[1] == 1) begin
			flag_s <= 0;
		end
		else begin
			flag_s <= flag_s;
		end
	end

    always @(posedge sys_clk or negedge sys_rst_n) begin
        if(!sys_rst_n) begin
            time_week <= 0;
        end
        else if(dis<=5000) begin
            time_week <= flag_beep;
        end
        else begin
            time_week <= dis*(750) + flag_beep;
        end
    end
 
//系统时钟计数器
    always@(posedge sys_clk or negedge sys_rst_n)
        if(sys_rst_n == 1'b0)
            cnt <= 25'd0;
        else if(cnt == time_week)
            cnt <= 25'd0;
        else 
            cnt <= cnt + 1'b1;

//声调频率计数器,声调的计数是变化的所以不能固定一个值
    always@(posedge sys_clk or negedge sys_rst_n) 
        if(sys_rst_n == 1'b0)
            freq_cnt <= 18'd0;
        else if((freq_cnt == freq_data) || (cnt == time_week))
            freq_cnt <= 18'd0;
        else
            freq_cnt <= freq_cnt + 1'b1;
            
    always@(posedge sys_clk or negedge sys_rst_n) 
        if(sys_rst_n == 1'b0)    
            freq_data <= t1;
        // else case(cnt_500ms)
        //     3'd0: freq_data <= t1;
        //     default: freq_data <= t1;
        // endcase
        else begin
            freq_data <= t1;
        end
//数据左移一位表示乘2，右移一位表示除以2
    assign duty_data = freq_data >> 1'b1 ;
//频率输出
    always@(posedge sys_clk or negedge sys_rst_n) 
        if(sys_rst_n == 1'b0)    
            beep <= 1'b0; 
        else if(freq_cnt == duty_data && cnt <= flag_beep && flag_s == 1)
            beep <= ~beep;
        else 
            beep <= beep;         

    assign flag_beep = 500_0000;
   
endmodule