void kernel_main() {
  char *video_memory = (char *)0xB8000; // VGA text buffer
  video_memory[0] = 'X';                // Print 'X' at top-left
  video_memory[1] = 0x0F;               // White-on-black
}
