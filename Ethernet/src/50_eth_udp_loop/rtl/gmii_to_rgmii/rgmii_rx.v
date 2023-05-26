//****************************************Copyright (c)***********************************//
//原子哥在线教学平台：www.yuanzige.com
//技术支持：www.openedv.com
//淘宝店铺：http://openedv.taobao.com 
//关注微信公众平台微信号："正点原子"，免费获取ZYNQ & FPGA & STM32 & LINUX资料。
//版权所有，盗版必究。
//Copyright(C) 正点原子 2018-2028
//All rights reserved                                  
//----------------------------------------------------------------------------------------
// File name:           rgmii_rx
// Last modified Date:  2020/2/13 9:20:14
// Last Version:        V1.0
// Descriptions:        RGMII接收模块
//----------------------------------------------------------------------------------------
// Created by:          正点原子
// Created date:        2020/2/13 9:20:14
// Version:             V1.0
// Descriptions:        The original version
//
//----------------------------------------------------------------------------------------
//****************************************************************************************//

module rgmii_rx(
    //以太网RGMII接口
    input              rgmii_rxc   , //RGMII接收时钟
    input              rgmii_rx_ctl, //RGMII接收数据控制信号
    input       [3:0]  rgmii_rxd   , //RGMII接收数据    

    //以太网GMII接口
    output             gmii_rx_clk , //GMII接收时钟
    output             gmii_rx_dv  , //GMII接收数据有效信号
    output      [7:0]  gmii_rxd      //GMII接收数据   
    );   

//wire define    
wire  [1:0]  gmii_rxdv_t;        //两位GMII接收有效信号 

//*****************************************************
//**                    main code
//*****************************************************

assign gmii_rx_clk = rgmii_rxc;
assign gmii_rx_dv = gmii_rxdv_t[0] & gmii_rxdv_t[1];

ddi_x4 ddi_x4_inst(
    .datain     (rgmii_rxd    ),
    .inclock    (rgmii_rxc    ),
    .dataout_h  (gmii_rxd[7:4]),
    .dataout_l  (gmii_rxd[3:0])
);

ddi_x1 ddi_x1_inst(
    .datain     (rgmii_rx_ctl),
    .inclock    (rgmii_rxc  ),
    .dataout_h  (gmii_rxdv_t[1]),
    .dataout_l  (gmii_rxdv_t[0])
);

endmodule