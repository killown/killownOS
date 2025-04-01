#include "devices/input/keyboard.h"
#include "devices/vga.h"

void kernel_main(void) {
  vga_init();
  keyboard_init();
  keyboard_init(); // Initialize keyboard early

  vga_puts("KillownOS Keyboard Test\n");
  vga_puts("Press keys (ESC to exit):\n> ");

  while (1) {
    char c = keyboard_getc();

    if (c == 27) { // ESC
      vga_puts("\nSystem halted.\n");
      break;
    }

    vga_putchar(c);
    if (c == '\n') {
      vga_puts("> ");
    }
  }

  // Halt CPU
  asm volatile("cli; hlt");
}
