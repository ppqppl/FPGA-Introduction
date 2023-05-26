//****************************************Copyright (c)***********************************//
//原子哥在线教学平台：www.yuanzige.com
//技术支持：www.openedv.com
//淘宝店铺：http://openedv.taobao.com 
//关注微信公众平台微信号："正点原子"，免费获取ZYNQ & FPGA & STM32 & LINUX资料。
//版权所有，盗版必究。
//Copyright(C) 正点原子 2018-2028
//All rights reserved                                  
//----------------------------------------------------------------------------------------
// File name:           rgmii_tx
// Last modified Date:  2020/2/13 9:20:14
// Last Version:        V1.0
// Descriptions:        RGMII发送模块
//----------------------------------------------------------------------------------------
// Created by:          正点原子
// Created date:        2020/2/13 9:20:14
// Version:             V1.0
// Descriptions:        The original version
//
//----------------------------------------------------------------------------------------
//****************************************************************************************//

module rgmii_tx(
    //GMII发送端口
    input              gmii_tx_clk ,   //GMII发送时钟 
    input              gmii_tx_en  ,   //GMII输出数据有效信号
    input       [7:0]  gmii_txd    ,   //GMII输出数据        
    
    //RGMII发送端口
    output             rgmii_txc   ,   //RGMII发送数据时钟    
    output             rgmii_tx_ctl,   //RGMII输出数据有效信号
    output      [3:0]  rgmii_txd       //RGMII输出数据     
    );

//*****************************************************
//**                    main code
//*****************************************************

ddo_x4 ddo_x4_inst(
    .datain_h(gmii_txd[3:0]),
    .datain_l(gmii_txd[7:4]),
    .outclock(gmii_tx_clk),
    .dataout(rgmii_txd)
);

ddo_x1 ddo_x1_inst(
    .datain_h(gmii_tx_en),
    .datain_l(gmii_tx_en ), 
    .outclock(gmii_tx_clk),
    .dataout(rgmii_tx_ctl)
);

ddo_x1 ddo_x1_clk(
    .datain_h(1'b1),
    .datain_l(1'b0),
    .outclock(gmii_tx_clk), 
    .dataout(rgmii_txc)
);

endmodule