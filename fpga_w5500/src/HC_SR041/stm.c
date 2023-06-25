#include <stdio.h>
#include <stdint.h>

uint32_t crc32(uint32_t crc, const void *buf, size_t size);

int main() {
    int choice;
    printf("输入1进入计算校验码程序，输入2进行解码程序: ");
    scanf("%d", &choice);

    if (choice == 1) {
        char input[100];
        printf("请输入要计算校验码的字符串: ");
        scanf("%s", input);
        uint32_t crc = crc32(0, input, strlen(input));
        printf("计算出的校验码为: %08x\n", crc);
    } else if (choice == 2) {
        printf("解码程序尚未实现\n");
    } else {
        printf("无效的选择\n");
    }

    return 0;
}

uint32_t crc32(uint32_t crc, const void *buf, size_t size) {
    static uint32_t table[256];
    static int have_table = 0;
    uint8_t *p;

    if (!have_table) {
        for (size_t i = 0; i < 256; i++) {
            uint32_t rem = i;
            for (int j = 0; j < 8; j++) {
                if (rem & 1) {
                    rem >>= 1;
                    rem ^= 0xedb88320;
                } else {
                    rem >>= 1;
                }
            }
            table[i] = rem;
        }
        have_table = 1;
    }

    crc = ~crc;
    p = (uint8_t *)buf;
    for (size_t i = 0; i < size; i++) {
        crc = (crc >> 8) ^ table[(crc & 0xff) ^ p[i]];
    }
    return ~crc;
}
