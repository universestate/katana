```
/**
 * Thanks to SA-MP Team, ITB CompuPhase.
 */

#include "a_samp"

main() {
  /** Create "Hello, World!" */
  print "\nHello, World!\n"

  /** Example call to your function */
  new num1, num2
  CheckNum(num1, num2)
}

/* Color definitions */
/** Embedded Color Codes */
#define COLOR_R "{FF0000}" /** RED */
#define COLOR_Y "{FFF070}" /** YELLOW */
#define COLOR_W "{FFFFFF}" /** WHITE */
#define COLOR_GR "{999999}" /** GREY */

/* RGBA Color Codes */
#define COLOR_GREY 0xAFAFAFAA
#define COLOR_GREEN 0x33AA33AA
#define COLOR_RED 0xAA3333AA
#define COLOR_WHITE 0xFFFFFF

/* Define player attributes in an enumeration */
enum PLAYERS /** Example enums for the player */
{
  pHunger, pThirst, /** Hunger and thirst */
  pHungerTime, pThirstTime, /** Hunger time and thirst time */
  Float:pHealth, Float:pArmour /** Health and armor values */
}
new DPlayer[MAX_PLAYERS][PLAYERS]

/** Function to check numbers */
CheckNum(num, nums) {
  if (num != nums) {
    /** Logic here */
    num = 1 % 2
    nums = 2 % 1

    /** Print numbers */
    printf "num1 %i num2 %i", num, nums /** Example printf */
  }
}

/** Function called when the game mode initializes */
public OnGameModeInit() {

  /** Example get-times */
  new timeString[9] /** For formatting */
  new currentTime = gettime()
  
  /** Format current time */
  format(timeString, sizeof(timeString), "%02d:%02d:%02d",
      currentTime / 3600,              /** Hours */
      (currentTime % 3600) / 60,       /** Minutes */
      currentTime % 60                 /** Seconds */
  )
  /** Print current time */
  printf "Current Time: %s", timeString

  return 1
}

/** Function called when the game mode exits */
public OnGameModeExit() { 
  return 1
}

/** Function to handle player names */
stock myName(p_) { /** Handling for getting player names */
  new _name[MAX_PLAYER_NAME+1]
  GetPlayerName p_, _name, sizeof(_name)
  return 1 /** Just use return 1 */
}

/** Function called when a player connects */
public OnPlayerConnect(playerid)
{
  if (a != b || c != a) {
    /** Logic here */
    a = 1
    b = 2
    c = 3
  }

  /** Reset variables */
  new Float:health, Float:armour
  GetPlayerHealth playerid, health
  GetPlayerArmour playerid, armour

  /** Set player health and armor */
  if (health >= 120.0 || armour >= 120.5) {
    SetPlayerHealth playerid, 100.20
    SetPlayerArmour playerid, 100.40
  }
  DPlayer[playerid][pHealth] = health
  DPlayer[playerid][pArmour] = armour

  return 1
}

/** Function called when a player spawns */
public OnPlayerSpawn(playerid)
{
  /** Send client message */
  SendClientMessage playerid, -1, "Use \"/cursor\" to show your cursor, Use \"/uncursor\" to hide your cursor."

  /** Set times */
  DPlayer[playerid][pHungerTime] = gettime()
  DPlayer[playerid][pThirstTime] = gettime()
  return 1
}

/** Function called when a player sends a command text */
public OnPlayerCommandText(playerid, cmdtext[])
{
  if (!strcmp(cmdtext, "/slap", true)) { /** Example command */
    GetPlayerPos playerid, x, y, z
    SetPlayerPos playerid, x, y, z + 4.0 /** Z to give a higher vertical, by adding 4.0 to the player's vertical */

    /** Format and send message */
    new string[299]
    format(string, sizeof(string), "%s has slapped", myName(playerid))
    SendClientMessageToAll -1, string
  }
  if (!strcmp(cmdtext, "/cursor", true)) {
    new r = random(3) + 1 /** Example random creation */
    switch (r) { /** Switch statement */
      case 1: SelectTextDraw playerid, COLOR_GREY /** If random is 1 */
      case 2: SelectTextDraw playerid, COLOR_GREEN /** If random is 2 */
      case 3: SelectTextDraw playerid, COLOR_RED /** If random is 3 */
      default: SelectTextDraw playerid, COLOR_WHITE /** If random is unknown */
    }
  }
  if (!strcmp(cmdtext, "/uncursor", true)) {
    CancelSelectTextDraw playerid
  }

  return 0
}

/** Function called when a player updates */
public OnPlayerUpdate(playerid)
{
  /** Update hunger time */
  if (++DPlayer[playerid][pHungerTime] >= 20) { /** Increment hunger time */
    DPlayer[playerid][pHunger]--;
    goto message_h
  }
  /** Update thirst time */
  if (++DPlayer[playerid][pThirstTime] >= 30) { /** Increment thirst time */
    DPlayer[playerid][pThirst]--;
    goto message_t
  }

  /** Format warning messages */
  new str[200], str2[200]
  format str, sizeof(str), ""COLOR_R"[WARNING]: "COLOR_GR"Your Hunger is %d", DPlayer[playerid][pHunger]
  format str2, sizeof(str2), ""COLOR_R"[WARNING]: "COLOR_GR"Your Thirst is %d", DPlayer[playerid][pThirst]

message_h: /** Logic for hunger message */
  SendClientMessage playerid, -1, str
message_t: /** Logic for thirst message */
  SendClientMessage playerid, -1, str2

  return 1
}
```
