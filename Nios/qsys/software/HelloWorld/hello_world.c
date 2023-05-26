#include "system.h"
#include "altera_avalon_pio_regs.h"
#include "alt_types.h"
const alt_u8
led_data[8]={0x01,0x03,0x07,0x0F,0x1F,0x3F,0x7F,0xFF};
int main (void) {
	int count=0;
	alt_u8 led;
	volatile int i;
	while (1)
	{
		if (count==7)
		{count=0;}
		else
		{count++;}
		led=led_data[count];
		IOWR_ALTERA_AVALON_PIO_DATA(PIO_LED_BASE, led);		// 点亮	 LED
		// 熄灭前一个灯
		led=led_data[count-1];
		IOWR_ALTERA_AVALON_PIO_DATA(0, led);		// 熄灭	 LED
		// 熄灭结束
		i = 0;
		while (i<500000)
			i++;
		printf("Hello world!\n");
	}
	return 0;
}
