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
sh build.sh

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
