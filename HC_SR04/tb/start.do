#start.do
#此脚本文件存放于工程文件夹下的tb子文件夹

transcript on
if {[file exists wql_work]} {
	vdel -lib wql_work -all
}
#上面的意思是如果已有 wql_work 这个库，就把它全部删了
#新建 wql_work 库,这是modelsim必须要做的事，作用就是把自己的源代码编译进这个库中。

vlib wql_work  

#将wql_work映射到 work 中，因为操作的时候modelsim是默认对work进行的，
#所以如果不这样modelsim就找不到这个库。

vmap work wql_work

#编译源代码和测试文件，这样写就是默认编译进了 wql_work 中了   
#编译testbench文件					       	
vlog    **_tb.v

#编译 	设计文件（位于工程文件夹下的rtl子文件夹）					       	 
vlog ../rtl/*.v
#vlog ../rtl/*.v
#vlog ../rtl/*.v

#编译IP文件


#指定仿真顶层模块	
vsim -novopt work.module_name_tb 

#添加信号到波形窗 							  
add wave -position insertpoint sim:/module_name_tb//*

#下面将信号显示调整为十进制无符号形式
radix unsigned

run -all