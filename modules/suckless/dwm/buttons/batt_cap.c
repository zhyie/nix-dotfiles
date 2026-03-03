#include <stdlib.h>
#include "buttons.h"

void battery_click(void) {
    char *btn = getenv("BUTTON");
    if (!btn) return;

    int b = atoi(btn);

    if (b == 1) {
        system("st -e echo battery");
    }

    else if (b == 3) {
        system("notify-send 'Battery' \"$(cat /sys/class/power_supply/BAT0/capacity)% $(cat /sys/class/power_supply/BAT0/status)\"");
    }
}
