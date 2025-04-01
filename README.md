KillownOS - Minimal x86 Operating System
=======================================

Description:
------------
A bare-metal OS for learning low-level systems programming. This demonstrates bootloading, protected mode switching, and basic hardware interaction.

Requirements (Arch Linux):
--------------------------
- nasm
- qemu
- gcc-multilib

Install dependencies:
sudo pacman -S nasm qemu gcc-multilib

Build Instructions:
------------------
1. Assemble bootloader:
nasm -f bin boot.asm -o boot.bin

2. Compile kernel:
gcc -m32 -ffreestanding -nostdlib -c kernel.c -o kernel.o
ld -m elf_i386 -Ttext 0x1000 -nostdlib kernel.o -o kernel.bin

3. Combine binaries:
cat boot.bin kernel.bin > KillownOS.bin

Run in QEMU:
-----------
qemu-system-x86_64 -drive format=raw,file=KillownOS.bin

Expected Output:
---------------
- "Hello, OS World!" message
- 'X' character in top-left corner

Makefile Contents:
-----------------
all: KillownOS.bin

boot.bin: boot.asm
	nasm -f bin $< -o $@

kernel.o: kernel.c
	gcc -m32 -ffreestanding -nostdlib -c $< -o $@

kernel.bin: kernel.o
	ld -m elf_i386 -Ttext 0x1000 -nostdlib $< -o $@

KillownOS.bin: boot.bin kernel.bin
	cat $^ > $@

run: KillownOS.bin
	qemu-system-x86_64 -drive format=raw,file=$<

clean:
	rm -f *.bin *.o

Learning Concepts:
-----------------
- CPU boot process (Real Mode)
- Protected mode transition
- VGA text mode programming
- Bare metal C programming

Next Steps:
----------
- Add keyboard input
- Implement interrupts
- Create memory manager
- Build simple filesystem

Warning:
-------
This is for educational purposes only. Expect crashes and hardware faults.

License:
--------
Unlicense (Public Domain)
