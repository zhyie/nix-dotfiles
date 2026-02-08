//Modify this file to change what commands output to your statusbar, and recompile using the make command.
static const Block blocks[] = {
	/*Icon*/  /*Command*/   /*Update Interval*/   /*Update Signal*/

  {"", "wpctl get-volume @DEFAULT_AUDIO_SINK@ | awk '{print $2 * 100 \"%\"}'", 0, 5},
  {"", "", 0, 5},
	{"󰁹", "upower -b | awk '/percentage/ {print $2}",	20,		0},
	{"󰃭", "date +'%a %b %d %H:%M'",					5,		0},

};

//sets delimiter between status commands. NULL character ('\0') means no delimiter.
static char delim[] = " | ";
static unsigned int delimLen = 5;
