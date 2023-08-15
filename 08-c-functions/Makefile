%.o: %.c
	i386-elf-gcc -ffreestanding -c $< -o $@

%.bin: %.o
	i386-elf-ld -o $@ -Ttext 0x0 --oformat binary $<
	i386-elf-ld -o $@ -Ttext 0x0 --oformat binary $<

disasm: %.bin
	ndisasm -b 32 @<