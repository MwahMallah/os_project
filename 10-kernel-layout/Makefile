C_SOURCES = $(wildcard kernel/*.c drivers/*.c cpu/*.c)
HEADERS = $(wildcard kernel/*.h drivers/*.h cpu/*.h)
OBJ = $(C_SOURCES:.c=.o cpu/interrupt.o)

CC = /usr/local/i386elfgcc/bin/i386-elf-gcc
GDB = gdb
LD = /usr/local/i386elfgcc/bin/i386-elf-ld

all: os-image

run: all
	qemu-system-i386 -fda os-image

os-image: boot/bootsect.bin kernel.bin
	cat $^ > $@

kernel.elf: boot/kernel_entry.o ${OBJ}
	i386-elf-ld -o $@ -Ttext 0x1000 $^ 

debug: os-image kernel.elf
	qemu-system-i386 -s -fda os-image &
	${GDB} -ex "symbol-file kernel.elf"

kernel.bin: boot/kernel_entry.o ${OBJ} 
	${LD} -Ttext 0x1000 --oformat binary $^ -o $@

%.o : %.c ${HEADERS}
	${CC} -g -ffreestanding -c $< -o $@

%.o : %.asm
	nasm $< -f elf -o $@

%.bin : %.asm
	nasm $< -f bin -I '../16bit' -o $@

clean:
	rm -rf *.bin *.o os-image.bin *.elf
	rm -rf kernel/*.o boot/*.bin drivers/*.o boot/*.o cpu/*.o
