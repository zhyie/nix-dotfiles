#include <stdlib.h>
#include <string.h>
#include "buttons.h"

void audio_vol(void) {
    char *btn = getenv("BUTTON");
    if (!btn) return;

    int b = atoi(btn);

    // left click: vol mute
    if (b == 1) system("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle");

    // scroll up: vol up
    else if (b == 4) system("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+");

    // scroll down: vol down
    else if (b == 5) system("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-");
}

