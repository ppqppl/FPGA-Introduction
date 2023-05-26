#include "HLS_HelloWorld.h"
#include <stdio.h>

int main(){
	led_t led_i=0x01;
	led_t led_o;
	const int SHIFT_TIME = 4;
	int i;
	for(i=0;i<SHIFT_TIME;i++){
		flash_led(&led_o , led_i);
		led_i = led_o;
		printf("shift_out is %d \n",(int)(led_o&0x01));
	}
}
