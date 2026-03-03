#include <stdlib.h>
#include "buttons.h"

void backlight(void) {
    char *btn = getenv("BUTTON");
    if (!btn) return;

    int b = atoi(btn);

    // left click: notify battery percent
    if (b == 1) { system("notify-send 'Brightness' $(light -G | cut -d. -f1)%"); }

    // scroll up: light up by 5
    else if (b == 4) { system("light -A 5"); }

    // scroll down: light down by 5
    else if (b == 5) { system("light -U 5"); }
}
