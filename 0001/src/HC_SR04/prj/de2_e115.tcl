#	Cyclone IV E EP4CE115F29C7N  参数导入脚本;
#	“#”号表示注释  
#	50MHz主频
# 	-to 后面的为信号名，要和程序中保持一致

#RS-232	
#set_location_assignment PIN_G12  -to uart_rx
#set_location_assignment PIN_G9   -to uart_tx
#set_location_assignment PIN_G14  -to uart_cts
#set_location_assignment PIN_J13  -to uart_rts


 #LEDG
#set_location_assignment PIN_E21 -to led_g[0]
#set_location_assignment PIN_E22 -to led_g[1]
#set_location_assignment PIN_E25 -to led_g[2]
#set_location_assignment PIN_E24 -to led_g[3]
#set_location_assignment PIN_H21 -to led_g[4]
#set_location_assignment PIN_G20 -to led_g[5]
#set_location_assignment PIN_G22 -to led_g[6]
#set_location_assignment PIN_G21 -to led_g[7]
#set_location_assignment PIN_F17 -to led_g[8]
 
 #LEDR
#set_location_assignment PIN_G19 -to led_r[0 ]
#set_location_assignment PIN_F19 -to led_r[1 ]
#set_location_assignment PIN_E19 -to led_r[2 ]
#set_location_assignment PIN_F21 -to led_r[3 ]
#set_location_assignment PIN_F18 -to led_r[4 ]
#set_location_assignment PIN_E18 -to led_r[5 ]
#set_location_assignment PIN_J19 -to led_r[6 ]
#set_location_assignment PIN_H19 -to led_r[7 ]
#set_location_assignment PIN_J17 -to led_r[8 ]
#set_location_assignment PIN_G17 -to led_r[9 ]
#set_location_assignment PIN_J15 -to led_r[10]
#set_location_assignment PIN_H16 -to led_r[11]
#set_location_assignment PIN_J16 -to led_r[12]
#set_location_assignment PIN_H17 -to led_r[13]
#set_location_assignment PIN_F15 -to led_r[14]
#set_location_assignment PIN_G15 -to led_r[15]
#set_location_assignment PIN_G16 -to led_r[16]
#set_location_assignment PIN_H15 -to led_r[17]

 #轻触按键

#set_location_assignment PIN_M23 -to key1
#set_location_assignment PIN_M21 -to key2
#set_location_assignment PIN_N21 -to key3
#set_location_assignment PIN_R24 -to key4

 #拨码开关
#set_location_assignment PIN_AB28 -to sw[0 ]
#set_location_assignment PIN_AC28 -to sw[1 ]
#set_location_assignment PIN_AC27 -to sw[2 ]
#set_location_assignment PIN_AD27 -to sw[3 ]
#set_location_assignment PIN_AB27 -to sw[4 ]
#set_location_assignment PIN_AC26 -to sw[5 ]
#set_location_assignment PIN_AD26 -to sw[6 ]
#set_location_assignment PIN_AB26 -to sw[7 ]
#set_location_assignment PIN_AC25 -to sw[8 ]
#set_location_assignment PIN_AB25 -to sw[9 ]
#set_location_assignment PIN_AC24 -to sw[10]
#set_location_assignment PIN_AB24 -to sw[11]
#set_location_assignment PIN_AB23 -to sw[12]
#set_location_assignment PIN_AA24 -to sw[13]
#set_location_assignment PIN_AA23 -to sw[14]
#set_location_assignment PIN_AA22 -to sw[15]
#set_location_assignment PIN_Y24  -to sw[16]
#set_location_assignment PIN_Y23  -to sw[17]


set_location_assignment PIN_Y2  -to Clk
set_location_assignment PIN_M23 -to Rst_n
set_location_assignment PIN_G18 -to hex1[0]
set_location_assignment PIN_F22 -to hex1[1]
set_location_assignment PIN_E17 -to hex1[2]
set_location_assignment PIN_L26 -to hex1[3]
set_location_assignment PIN_L25 -to hex1[4]
set_location_assignment PIN_J22 -to hex1[5]
set_location_assignment PIN_H22 -to hex1[6]
set_location_assignment PIN_M24 -to hex2[0]
set_location_assignment PIN_Y22 -to hex2[1]
set_location_assignment PIN_W21 -to hex2[2]
set_location_assignment PIN_W22 -to hex2[3]
set_location_assignment PIN_W25 -to hex2[4]
set_location_assignment PIN_U23 -to hex2[5]
set_location_assignment PIN_U24 -to hex2[6]
set_location_assignment PIN_AA25 -to hex3[0]
set_location_assignment PIN_AA26 -to hex3[1]
set_location_assignment PIN_Y25 -to hex3[2]
set_location_assignment PIN_W26 -to hex3[3]
set_location_assignment PIN_Y26 -to hex3[4]
set_location_assignment PIN_W27 -to hex3[5]
set_location_assignment PIN_W28 -to hex3[6]
set_location_assignment PIN_V21 -to hex4[0]
set_location_assignment PIN_U21 -to hex4[1]
set_location_assignment PIN_AB20 -to hex4[2]
set_location_assignment PIN_AA21 -to hex4[3]
set_location_assignment PIN_AD24 -to hex4[4]
set_location_assignment PIN_AF23 -to hex4[5]
set_location_assignment PIN_Y19 -to hex4[6]
set_location_assignment PIN_AB19 -to hex5[0]
set_location_assignment PIN_AA19 -to hex5[1]
set_location_assignment PIN_AG21 -to hex5[2]
set_location_assignment PIN_AH21 -to hex5[3]
set_location_assignment PIN_AE19 -to hex5[4]
set_location_assignment PIN_AF19 -to hex5[5]
set_location_assignment PIN_AE18 -to hex5[6]
set_location_assignment PIN_AD18 -to hex6[0]
set_location_assignment PIN_AC18 -to hex6[1]
set_location_assignment PIN_AB18 -to hex6[2]
set_location_assignment PIN_AH19 -to hex6[3]
set_location_assignment PIN_AG19 -to hex6[4]
set_location_assignment PIN_AF18 -to hex6[5]
set_location_assignment PIN_AH18 -to hex6[6]
set_location_assignment PIN_AA17 -to hex7[0]
set_location_assignment PIN_AB16 -to hex7[1]
set_location_assignment PIN_AA16 -to hex7[2]
set_location_assignment PIN_AB17 -to hex7[3]
set_location_assignment PIN_AB15 -to hex7[4]
set_location_assignment PIN_AA15 -to hex7[5]
set_location_assignment PIN_AC17 -to hex7[6]
set_location_assignment PIN_AD17 -to hex8[0]
set_location_assignment PIN_AE17 -to hex8[1]
set_location_assignment PIN_AG17 -to hex8[2]
set_location_assignment PIN_AH17 -to hex8[3]
set_location_assignment PIN_AF17 -to hex8[4]
set_location_assignment PIN_AG18 -to hex8[5]
set_location_assignment PIN_AA14 -to hex8[6]

#GPIO
set_location_assignment PIN_AB22  -to trig
set_location_assignment PIN_AC15  -to echo
#set_location_assignment PIN_AB21  -to GPIO[2 ]
#set_location_assignment PIN_Y17   -to GPIO[3 ]
#set_location_assignment PIN_AC21  -to GPIO[4 ]
#set_location_assignment PIN_Y16   -to GPIO[5 ]
#set_location_assignment PIN_AD21  -to GPIO[6 ]
#set_location_assignment PIN_AE16  -to GPIO[7 ]
#set_location_assignment PIN_AD15  -to GPIO[8 ]
#set_location_assignment PIN_AE15  -to GPIO[9 ]
#set_location_assignment PIN_AC19  -to GPIO[10]
#set_location_assignment PIN_AF16  -to GPIO[11]
#set_location_assignment PIN_AD19  -to GPIO[12]
#set_location_assignment PIN_AF15  -to GPIO[13]
#set_location_assignment PIN_AF24  -to GPIO[14]
#set_location_assignment PIN_AE21  -to GPIO[15]
#set_location_assignment PIN_AF25  -to GPIO[16]
#set_location_assignment PIN_AC22  -to GPIO[17]

#set_location_assignment PIN_AE22  -to GPIO[18]
#set_location_assignment PIN_AF21  -to GPIO[19]
#set_location_assignment PIN_AF22  -to GPIO[20]
#set_location_assignment PIN_AD22  -to GPIO[21]
#set_location_assignment PIN_AG25  -to GPIO[22]
#set_location_assignment PIN_AD25  -to GPIO[23]
#set_location_assignment PIN_AH25  -to GPIO[24]
#set_location_assignment PIN_AE25  -to GPIO[25]
#set_location_assignment PIN_AG22  -to GPIO[26]
#set_location_assignment PIN_AE24  -to GPIO[27]
#set_location_assignment PIN_AH22  -to GPIO[28]
#set_location_assignment PIN_AF26  -to GPIO[29]
#set_location_assignment PIN_AE20  -to GPIO[30]
#set_location_assignment PIN_AG23  -to GPIO[31]
#set_location_assignment PIN_AF20  -to GPIO[32]
#set_location_assignment PIN_AH26  -to GPIO[33]
#set_location_assignment PIN_AH23  -to GPIO[34]
#set_location_assignment PIN_AG26  -to GPIO[35]