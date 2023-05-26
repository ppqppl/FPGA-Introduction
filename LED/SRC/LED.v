module LED#(parameter TIME_1S = 50_000_000)(  //利于传参数 可改变
    input   wire         clk     ,   //  时钟 20ns
    input   wire         rst_n   ,  //低有效
    output  reg    [3:0] led    
);

    // parameter TIME_1S = 50_000_000  ;  //需要这么多时钟周期

    reg       [25:0]     cnt        ; //定义一个26位宽的计数器

    always @(posedge clk or negedge rst_n)begin
        if(!rst_n)begin  //复位之后 归0
            cnt <= 26'd0;
        end
        else if(cnt == TIME_1S - 1)begin //计数器计数到了最大值 归0
            cnt <= 26'd0;
        end 
        else begin  //其他情况下 计数器自加1
            cnt <= cnt + 1'b1;
        end
    end

    always @(posedge clk or negedge rst_n)begin
        if(!rst_n)begin
           led <= 4'b0001; //复位之后 点亮第0的灯
        end   
        else if (cnt == TIME_1S -1)begin
            led <= {led[2:0],~led[3]}; //1s计时完成  1110 0001 
        end
        else begin
            led <= led;  //其他情况下 保持本身
        end
    end


endmodule