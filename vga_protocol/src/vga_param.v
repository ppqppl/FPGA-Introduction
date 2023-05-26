//`define vga_480_272
`define vga_640_480
//`define vga_800_480
//`define vga_800_600
//`define vga_1024_600
//`define vga_1024_768
//`define vga_1280_720
//`define vga_1920_1080

`ifdef vga_480_272
      `define H_Right_Border  0
	`define H_Front_Porch   2
	`define H_Sync_Time     41
	`define H_Back_Porch    2
	`define H_Left_Border   0
	`define H_Data_Time     480 
	`define H_Total_Time    525
	
	`define V_Bottom_Border 0
	`define V_Front_Porch   2
	`define V_Sync_Time     10
	`define V_Back_Porch    2 
	`define V_Top_Border    0
	`define V_Data_Time     272
	`define V_Total_Time    286
		
`elsif vga_640_480
      `define H_Right_Border  8
	`define H_Front_Porch   8
	`define H_Sync_Time     96
	`define H_Back_Porch    40
	`define H_Left_Border   8
	`define H_Data_Time     640
      `define H_Total_Time    800
	           
      `define V_Bottom_Border  8
      `define V_Front_Porch   2
      `define V_Sync_Time     2
	`define V_Back_Porch    25
	`define V_Top_Border    8
      `define V_Data_Time     480
      `define V_Total_Time    525
		
`elsif vga_800_480
      `define H_Right_Border  0
      `define H_Front_Porch   40
      `define H_Sync_Time     128
      `define H_Back_Porch    88
      `define H_Left_Border   0
      `define H_Data_Time     800
      `define H_Total_Time    1056
              
	`define V_Bottom_Border 8 
	`define V_Front_Porch   2
	`define V_Sync_Time     2
	`define V_Back_Porch    25
	`define V_Top_Border    8
	`define V_Data_Time     480
	`define V_Total_Time    525
		
`elsif vga_800_600
      `define H_Right_Border  0 
      `define H_Front_Porch   40 
      `define H_Sync_Time     128
      `define H_Back_Porch    88
      `define H_Left_Border   0
      `define H_Data_Time     800
      `define H_Total_Time    1056 
              
      `define V_Bottom_Border 0
      `define V_Front_Porch   1
      `define V_Sync_Time     4
      `define V_Back_Porch    23
      `define V_Top_Border    0
      `define V_Data_Time     600
      `define V_Total_Time    628


`elsif vga_1024_600
      `define H_Right_Border   0
      `define H_Front_Porch    24
      `define H_Sync_Time      136
      `define H_Back_Porch     160
      `define H_Left_Border    0
      `define H_Data_Time      1024
      `define H_Total_Time     1344
              
      `define V_Bottom_Border  0
      `define V_Front_Porch    1
      `define V_Sync_Time      4
      `define V_Back_Porch     23
      `define V_Top_Border     0
      `define V_Data_Time      600
      `define V_Total_Time     628

`elsif vga_1024_768
      `define H_Right_Border   0
      `define H_Front_Porch    24
      `define H_Sync_Time      136
      `define H_Back_Porch     160
      `define H_Left_Border    0
      `define H_Data_Time      1024
      `define H_Total_Time     1344
              
      `define V_Bottom_Border  0
      `define V_Front_Porch    3
      `define V_Sync_Time      6
      `define V_Back_Porch     29
      `define V_Top_Border     0
      `define V_Data_Time      768
      `define V_Total_Time     806

`elsif vga_1280_720
      `define H_Right_Border   0
      `define H_Front_Porch    110
      `define H_Sync_Time      40
      `define H_Back_Porch     220
      `define H_Left_Border    0
      `define H_Data_Time      1280
      `define H_Total_Time     1650
              
      `define V_Bottom_Border  0
      `define V_Front_Porch    5
      `define V_Sync_Time      5
      `define V_Back_Porch     20
      `define V_Top_Border     0
      `define V_Data_Time      720
      `define V_Total_Time     750
		
`elsif vga_1920_1080 
     `define H_Right_Border  0 
     `define H_Front_Porch   88
     `define H_Sync_Time     44
     `define H_Back_Porch    148
     `define H_Left_Border   0
     `define H_Data_Time     1920
     `define H_Total_Time    2200
             
     `define V_Bottom_Border 0
     `define V_Front_Porch   4
     `define V_Sync_Time     5
     `define V_Back_Porch    36
     `define V_Top_Border    0
     `define V_Data_Time     1080
     `define V_Total_Time    1125
	 
`endif