`define vga_640_480
`define vga_1920_1080 
`define vga_1024_768 
`ifdef  vga_640_480  //执行操作B
    `define H_Right_Border    8   //行同步右沿信号
    `define H_Front_Porch     8   //行同步前沿信号周期长
    `define H_Sync_Time       96  //行同步信号周期长
    `define H_Back_Porch      40  //行同步后沿信号周期长
    `define H_Left_Border     4   //行同步左沿信号
    `define H_Data_Time       640 //行显示周期长
    `define H_Total_Time      800

    `define V_Bottom_Border   8   //场同步底沿信号 
    `define V_Front_Porch     2   //场同步前沿信号周期长
    `define V_Sync_Time       2   //场同步信号周期长
    `define V_Back_Porch      25  //场同步后沿信号周期长
    `define V_Top_Border      8   //场同步顶沿信号
    `define V_Data_Time       480 //场显示周期长
    `define V_Total_Time      525
     
      
`elsif vga_1920_1080 //执行操作B
    `define H_Right_Border    0
    `define H_Front_Porch     88
    `define H_Sync_Time       44
    `define H_Back_Porch      148
    `define H_Left_Border     0
    `define H_Data_Time       1920
    `define H_Total_Time      2200

    `define V_Bottom_Border   0
    `define V_Front_Porch     4
    `define V_Sync_Time       5
    `define V_Back_Porch      36
    `define V_Top_Border      0
    `define V_Data_Time       1080
    `define V_Total_Time      1125

`elsif vga_1024_768    
    `define H_Right_Border    0
    `define H_Front_Porch     24
    `define H_Sync_Time       136
    `define H_Back_Porch      160
    `define H_Left_Border     0
    `define H_Data_Time       1024
    `define H_Total_Time      1344
   
    `define V_Bottom_Borde    0 
    `define V_Front_Porch     3 
    `define V_Sync_Time       6 
    `define V_Back_Porch      29
    `define V_Top_Border      0 
    `define V_Data_Time       768 
    `define V_Total_Time      806
 
`else //可以没有

`endif
