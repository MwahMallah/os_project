#include "util.h"


void memory_copy(char* source, char* dest, int no_bytes) {
    for (int i = 0; i < no_bytes; i++) {
        dest[i] = source[i];
    }
}

void int_to_ascii(int n, char str[]) {
    int sign, i = 0;
    char ascii;

    if ((sign = n) < 0) n = -n;

    do
    {
        str[i++] = n % 10 + '0'; 
        n /= 10;
    } while (n > 0);
    
    if (sign < 0) str[i++] = '-';
    str[i] = '\0';

}