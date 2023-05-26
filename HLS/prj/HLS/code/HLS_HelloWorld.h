#ifndef _HLS_HELLOWORLD_H_
#define _HLS_HELLOWORLD_H_
#include "ap_int.h"
#include "stdio.h"
#define CNT_MAX 100000000
//#define CNT_MAX 100
#define FLASH_FLAG CNT_MAX-2
//typedef     int led_t;
//typedef     int cnt_t;
typedef 	ap_int<1> led_t;
typedef 	ap_int<32> cnt_t;
void flash_led(led_t *led_o , led_t led_i);
#endif
