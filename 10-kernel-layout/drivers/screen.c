#include "screen.h"
#include "ports.h"
#include "../kernel/util.h"

//function declarations
int  get_cursor();
void set_cursor(int);
int  print_char(char, int, int, char);
int  get_row_offset(int);
int  get_col_offset(int);
int  get_screen_offset(int, int);
int  handle_scrolling(int);
/*
    Public kernel API functions
*/

void clear_screen() {
    int max_pos = MAX_COLS * MAX_ROWS;
    unsigned char* vidmem = (unsigned char*) VIDEO_MEMORY;

    for (int row = 0; row < MAX_ROWS; row++)
    {
        for (int col = 0; col < MAX_COLS; col++) {
            print_char(' ', col, row, WHITE_ON_BLACK);
        }
    }
    
    set_cursor(get_screen_offset(0, 0));
}

void kprint_at(char* message, int col, int row, char attribute_byte) {
    int offset;
    if (col >= 0 && row >= 0) {
        offset = get_screen_offset(col, row);
    } else {
        offset = get_cursor();
        col = get_col_offset(offset);
        row = get_row_offset(offset);
    }

    if (!attribute_byte) {
        attribute_byte = WHITE_ON_BLUE;
    }

    int i = 0;

    while (message[i] != 0)
    {
        offset = print_char(message[i++], col, row, attribute_byte);
        row = get_row_offset(offset);
        col = get_col_offset(offset);
    }

    // set_cursor(get_screen_offset(get_col_offset(offset), get_row_offset(offset)));
}

void kprint(char* message, char attribute_byte) {
    kprint_at(message, -1, -1, attribute_byte);
}


/*
    Private kernel functions 
*/


int print_char(char character, int col, int row, char attribute_byte){
    unsigned char* vidmem = (unsigned char *) VIDEO_MEMORY;

    if (col >= MAX_COLS || row >= MAX_ROWS) {
        vidmem[2*(MAX_COLS)*(MAX_ROWS)-2] = 'E';
        vidmem[2*(MAX_COLS)*(MAX_ROWS)-1] = RED_ON_WHITE;
        return get_screen_offset(col, row);
    }

    if (!attribute_byte){
        attribute_byte = WHITE_ON_BLACK;
    }

    int offset;

    if (col >= 0 && row >= 0) {
        offset = get_screen_offset(col, row);
    } else {
        offset = get_cursor();
    }

    if (character == '\n') {
        int current_row = offset / (2*MAX_COLS);
        offset = get_screen_offset(0, current_row + 1);
    } else {
        vidmem[offset] = character;
        vidmem[offset+1] = attribute_byte;
        offset += 2;
    }

    offset = handle_scrolling(offset);
    set_cursor(offset);
    return offset;
}


int handle_scrolling(int cursor_offset) {
    if (cursor_offset < MAX_COLS*MAX_ROWS*2) {
        return cursor_offset;
    }

    for (int i = 1; i < MAX_ROWS; i++) {
        memory_copy(get_screen_offset(0, i) + VIDEO_MEMORY, get_screen_offset(0, i - 1) + VIDEO_MEMORY, MAX_COLS*2);
    }

    char* last_line = get_screen_offset(0, MAX_ROWS - 1) + VIDEO_MEMORY;
    for (int i = 0; i < MAX_COLS*2; i++) {
        last_line[i] = 0;
    }
    
    cursor_offset -= 2*MAX_COLS;

    return cursor_offset;
}


//Use ports manipulation functions from ports.c
//we select reg 14, that stores high byte of cursor's offset
//than we select reg 15, with low byte
int get_cursor() {
    port_byte_write(REG_SCREEN_CTRL, 14);
    int offset = port_byte_read(REG_SCREEN_DATA) << 8; //store as high byte => shift left by 8 bits
    port_byte_write(REG_SCREEN_CTRL, 15);
    offset += port_byte_read(REG_SCREEN_DATA);
    /*
    VGA hardware repors cursor offset as the number of characters (without attribute byte), so we must multiply returned value by two
    */
    return offset * 2;
}

void set_cursor(int offset) {
    offset /= 2; //Convert from cell offset to char offset.
    port_byte_write(REG_SCREEN_CTRL, 14); //store high byte first, so register 14
    port_byte_write(REG_SCREEN_DATA, (unsigned char) (offset >> 8)); // we shift offset by 8 bits => we get high byte
    port_byte_write(REG_SCREEN_CTRL, 15); //store low byte, choose register 15 
    port_byte_write(REG_SCREEN_DATA, (unsigned char) (offset & 0xff)); // bitwise and to choose only low byte
}

int get_screen_offset(int col, int row) { 
    return 2 * (row * MAX_COLS + col);
}

int get_row_offset(int offset) {
    return offset / (2*MAX_COLS);
}

int get_col_offset(int offset) {
   return (offset - (get_row_offset(offset)*2*MAX_COLS))/2;
}

