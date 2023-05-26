#include "HLS_HelloWorld.h"

void flash_led(led_t *led_o , led_t led_i){
#pragma HLS INTERFACE ap_vld port=led_i
#pragma HLS INTERFACE ap_ovld port=led_o
	cnt_t i;
	for(i=0;i<CNT_MAX;i++){
//#pragma HLS PIPELINE
		if(i==FLASH_FLAG){
			*led_o = ~led_i;
		}
	}
}
