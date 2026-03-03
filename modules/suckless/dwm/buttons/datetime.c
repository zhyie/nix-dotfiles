#include <stdlib.h>
#include "buttons.h"

void datetime(void) {
    char *btn = getenv("BUTTON");
    if (!btn) return;

    int b = atoi(btn);

    if (b == 1) { system("st -e echo omsimnida"); }
    else if (b == 3) {
        system("notify-send 'Today' \"$(date '📅 %A, %B %d %Y\n🕐 %I:%M %p')\"");
    }
}
