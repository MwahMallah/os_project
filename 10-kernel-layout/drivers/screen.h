#ifndef SCREEN_H
#define SCREEN_H

#define VIDEO_MEMORY 0xb8000
#define MAX_ROWS 25
#define MAX_COLS 80
#define WHITE_ON_BLACK 0x0F
#define WHITE_ON_BLUE  0x1F
#define RED_ON_BLACK 0x0C
#define RED_ON_BLUE 0x1C
#define RED_ON_WHITE 0xFC

#define REG_SCREEN_CTRL 0x3D4
#define REG_SCREEN_DATA 0x3D5

void clear_screen();
void kprint(char* message, char attribute_byte);
void kprint_at(char* message, int col, int row, char attribute_byte);


#endif