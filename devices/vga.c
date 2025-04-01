#include "vga.h"

static uint16_t *const vga_buffer = (uint16_t *)VGA_MEMORY;
static size_t terminal_row;
static size_t terminal_column;
static uint8_t terminal_color;

void vga_init(void) {
  terminal_row = 0;
  terminal_column = 0;
  terminal_color = vga_make_color(VGA_COLOR_LIGHT_GREY, VGA_COLOR_BLACK);

  for (size_t y = 0; y < VGA_HEIGHT; y++) {
    for (size_t x = 0; x < VGA_WIDTH; x++) {
      const size_t index = y * VGA_WIDTH + x;
      vga_buffer[index] = vga_make_entry(' ', terminal_color);
    }
  }
}

void vga_putchar(char c) {
  if (c == '\n') {
    terminal_column = 0;
    if (++terminal_row == VGA_HEIGHT) {
      terminal_row = 0;
    }
  } else {
    const size_t index = terminal_row * VGA_WIDTH + terminal_column;
    vga_buffer[index] = vga_make_entry(c, terminal_color);
    if (++terminal_column == VGA_WIDTH) {
      terminal_column = 0;
      if (++terminal_row == VGA_HEIGHT) {
        terminal_row = 0;
      }
    }
  }
}

void vga_puts(const char *str) {
  while (*str) {
    vga_putchar(*str++);
  }
}

void vga_setcolor(uint8_t color) { terminal_color = color; }
