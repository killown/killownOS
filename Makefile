CC = gcc
LD = ld
NASM = nasm
QEMU = qemu-system-x86_64
CFLAGS = -ffreestanding -nostdlib -I.
LDFLAGS = -Ttext 0x1000 --entry=kernel_main --oformat binary

all: os.bin

boot/boot.bin: boot/boot.asm boot/print.asm boot/disk.asm
	$(NASM) -f bin $< -o $@

devices/vga.o: devices/vga.c devices/vga.h io.h
	$(CC) $(CFLAGS) -c $< -o $@

devices/input/keyboard.o: devices/input/keyboard.c devices/input/keyboard.h io.h
	$(CC) $(CFLAGS) -c $< -o $@

kernel.o: kernel.c devices/vga.h devices/input/keyboard.h
	$(CC) $(CFLAGS) -c $< -o $@

kernel.bin: kernel.o devices/vga.o devices/input/keyboard.o
	$(LD) $(LDFLAGS) -o $@ $^

os.bin: boot/boot.bin kernel.bin
	cat $^ > $@

run: os.bin
	$(QEMU) -drive file=os.bin,format=raw,if=floppy

clean:
	rm -f *.bin *.o devices/*.o devices/input/*.o boot/*.bin

.PHONY: all clean run
