-- (C) 2001-2018 Intel Corporation. All rights reserved.
-- Your use of Intel Corporation's design tools, logic functions and other 
-- software and tools, and its AMPP partner logic functions, and any output 
-- files from any of the foregoing (including device programming or simulation 
-- files), and any associated documentation or information are expressly subject 
-- to the terms and conditions of the Intel Program License Subscription 
-- Agreement, Intel FPGA IP License Agreement, or other applicable 
-- license agreement, including, without limitation, that your use is for the 
-- sole purpose of programming logic devices manufactured by Intel and sold by 
-- Intel or its authorized distributors.  Please refer to the applicable 
-- agreement for further details.


-- -------------------------------------------------------------------------
-- -------------------------------------------------------------------------
--
-- Revision Control Information
--
-- $RCSfile: altera_ethmodels_pack.vhd,v $
-- $Source: /ipbu/cvs/sio/projects/TriSpeedEthernet/src/testbench/models/vhdl/ethernet_model/package/altera_ethmodels_pack.vhd,v $
--
-- $Revision: #1 $
-- $Date: 2018/07/18 $
-- Check in by : $Author: psgswbuild $
-- Author      : SKNg/TTChong
--
-- Project     : Triple Speed Ethernet - 10/100/1000 MAC
--
-- Description : (Simulation only)
--
-- Package defining components and features of Ethernet Models
--
-- 
-- ALTERA Confidential and Proprietary
-- Copyright 2006 (c) Altera Corporation
-- All rights reserved
--
-- -------------------------------------------------------------------------
-- -------------------------------------------------------------------------





library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all ;
use std.textio.all ;

package altera_ethmodels_pack is


    constant GENCNTMODULO  : integer := 256;    -- modulo used for the start counter
                                                -- (informative, not for change)
    


    -- --------------------------------------
    -- Procedures to help generation Messages
    -- --------------------------------------

    -- convert vector to HEX digits (assumes multiples of nibbles (4-bit) )
    --
    procedure WRITE_HEX(L : inout LINE; val : in std_logic_vector );
    
    -- write timestamp and message
    --
    procedure WRITETM(L: inout LINE; theMessage : in string );


    -- write to logfile and to stdout
    --
    procedure WRITELINE_LOG( file theLog: TEXT; L: inout LINE );
    

    function get_reconfig_from_width(dev_family : STRING) return integer;
    function get_reconfig_to_width(dev_family : STRING) return integer;
    function isPhyIp(dev_family : STRING) return boolean;

    
end altera_ethmodels_pack;


package body altera_ethmodels_pack is

    --
    -- Convert vector to hex digit (assumes 4-bit nibbles)
    --

    procedure WRITE_HEX(L: inout LINE; val: in std_logic_vector ) is
    
        variable i, ix : integer;
        variable nib   : integer;
        
        begin
        
            for i in ((val'left)+1)/4 downto 1 loop  -- start with MSNibble
            
                ix := i*4;
                
                nib := conv_integer( '0' & val( ix-1 downto ix-4 ) ); -- convert to unsigned always
                
                if( nib < 10 ) then
                
                    write( L, character'val(character'pos('0') + nib));
                    
                else
                
                    write( L, character'val(character'pos('a') + nib-10 ));
                
                end if;
                
            end loop;
        
        end;
            
            
    --
    -- Write line in logfile and stdout with time stamp
    --

    procedure WRITETM( L: inout LINE; theMessage: in string  ) is
    
        variable ln: line;
    
        begin
    
            write(L, string'("Time: "));
            write(L, NOW, RIGHT, 10 );
            write(L, string'(" - "));
            write(L, theMessage );
            
        end;
               
    -- write line in logfile and to output
    --
    procedure WRITELINE_LOG( file theLog: TEXT; L: inout LINE ) is
    
        variable ln1 : line;
        variable ln2 : line;
        variable tmp : string(1 to L'length);
        
        begin
                -- copy the string in two destinations as writeline deallocates them
                
               read(L, tmp);
               write( ln1, tmp);
               write( ln2, tmp);
               
               writeline( theLog, ln1);
               writeline( OUTPUT, ln2);
    
        end;

    function isPhyIp(dev_family : STRING)
    return boolean is
    begin
        if (dev_family = "STRATIXV" or
            dev_family = "ARRIAVGZ" or
            dev_family = "ARRIAV" or
            dev_family = "CYCLONEV") then
            return true;
        else 
            return false;
        end if;
    end function isPhyIp;

    function get_reconfig_to_width (dev_family : STRING) 
    return integer is
    begin
        if (isPhyIp(dev_family)) then
            return 140;
        else
            if (dev_family = "ARRIAGX") then
               return 3;
            elsif (dev_family = "STRATIXIIGX") then
               return 3;
            else 
               return 4;
            end if;
        end if;
    end function get_reconfig_to_width;   

    function get_reconfig_from_width (dev_family : STRING) 
    return integer is
    begin
        if (isPhyIp(dev_family)) then
            return 92;
        else
            if (dev_family = "CYCLONEIVGX") then
                return 5;
            elsif (dev_family = "ARRIAGX") then 
                return 1;
            elsif (dev_family = "STRATIXIIGX") then 
                return 1;
            else
                return 17;
            end if;
        end if;
    end function get_reconfig_from_width;  

end; -- body        
        
