#include <stdint.h>

#define FRAMEBUFFER_BASE 0x10000000
#define SCREEN_WIDTH  640
#define SCREEN_HEIGHT 480
#define COLOR_WHITE   0xFFFFFF

void draw_pixel(int x, int y, uint32_t color) {
    volatile uint32_t *framebuffer = (volatile uint32_t *)FRAMEBUFFER_BASE;
    framebuffer[y * SCREEN_WIDTH + x] = color;
}

void start() {
    // Clear the screen by setting all pixels to black
    for (int y = 0; y < SCREEN_HEIGHT; ++y) {
        for (int x = 0; x < SCREEN_WIDTH; ++x) {
            draw_pixel(x, y, 0x000000);
        }
    }

    // Draw a simple character 'A' by setting a block of pixels in white color
    for (int y = 10; y < 20; ++y) {
        for (int x = 10; x < 20; ++x) {
            draw_pixel(x, y, COLOR_WHITE);
        }
    }
}

