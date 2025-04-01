#include "keyboard.h"
#include "../../io.h"

#define KEYBOARD_DATA_PORT 0x60

static const char keymap[] = {
    0,   27,  '1',  '2',  '3',  '4', '5', '6',  '7', '8', '9', '0',
    '-', '=', '\b', '\t', 'q',  'w', 'e', 'r',  't', 'y', 'u', 'i',
    'o', 'p', '[',  ']',  '\n', 0,   'a', 's',  'd', 'f', 'g', 'h',
    'j', 'k', 'l',  ';',  '\'', '`', 0,   '\\', 'z', 'x', 'c', 'v',
    'b', 'n', 'm',  ',',  '.',  '/', 0,   '*',  0,   ' '};

void keyboard_init(void) {
  // Enable keyboard interrupts
  outb(0x64, 0xAE); // Enable keyboard
  outb(0x60, 0xF4); // Enable scanning
}

char keyboard_getc(void) {
  while (1) {
    uint8_t status = inb(0x64);
    if (status & 0x01) {
      uint8_t scancode = inb(KEYBOARD_DATA_PORT);
      if (scancode < sizeof(keymap) && keymap[scancode] != 0) {
        return keymap[scancode];
      }
    }
  }
}
