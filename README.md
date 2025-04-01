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

BUILD INSTRUCTIONS:
--------------------------
1. Assemble the bootloader:
nasm -f bin boot.asm -o boot.bin

2. Compile the kernel:
gcc -ffreestanding -c kernel.c -o kernel.o
ld -o kernel.bin -Ttext 0x1000 kernel.o --oformat binary

3. Combine the binaries:
cat boot.bin kernel.bin > os.bin

4. Run in QEMU:
qemu-system-x86_64 -fda os.bin

Expected Output:
---------------
- "Hello, OS World!" message
- 'X' character in top-left corner

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
