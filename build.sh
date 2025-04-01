#!/bin/bash

# Stop on errors
set -e

# Compile device drivers
gcc -ffreestanding -nostdlib -c devices/vga.c -o devices/vga.o
gcc -ffreestanding -nostdlib -c devices/input/keyboard.c -o devices/input/keyboard.o

# Compile kernel
gcc -ffreestanding -nostdlib -c kernel.c -o kernel.o -I.

# Link everything
ld -Ttext 0x1000 --entry=kernel_main -o kernel.bin \
  kernel.o devices/vga.o devices/input/keyboard.o \
  --oformat binary

# Assemble bootloader
nasm -f bin boot/boot.asm -o boot/boot.bin

# Combine binaries
cat boot/boot.bin kernel.bin >os.bin

qemu-system-x86_64 -drive format=raw,file=os.bin,if=floppy
