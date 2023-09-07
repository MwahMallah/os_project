#ifndef IDT_H
#define IDT_H

#include "types.h"

#define KERNEL_CS 0x08 // Segment selector (code)

//structure of every interrupt gate (handler)
typedef struct
{
    u16 low_offset;    //upper 16 bits of the handler's address
    u16 sel;           //segment selector
    u8 always0;        //this byte is always 0
    u8  flags;         //flags
    u16 high_offset;   //high 16 bits of handler
} __attribute__((packed)) idt_gate_t;


//pointer to the array of interrupts
typedef struct {
    u16 limit;
    u32 base;
} __attribute__((packed)) idt_register_t;

#define IDT_ENTRIES 256
idt_gate_t idt[IDT_ENTRIES];
idt_register_t idt_reg;

void set_idt_gate(int n, u32 handler);
void set_idt();

#endif