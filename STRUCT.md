```pwn
/**
* Thanks to SA-MP Team, ITB CompuPhase.
*/

/* call the main library sa-mp */
#include "a_samp"

main() {
// create Hello World.
  print "\nHello, World!\n"

// example call your function.
  new num1, num2
  CheckNum(num1, num2)
}

/* color defines */
// Embedded Color Codes
#define COLOR_R "{FF0000}" // RED
#define COLOR_Y "{FFF070}" // YELLOW
#define COLOR_W "{FFFFFF}" // WHITE
#define COLOR_GR "{999999}" // GREY

// RGBA Color Codes
#define COLOR_GREY 0xAFAFAFAA
#define COLOR_GREEN 0x33AA33AA
#define COLOR_RED 0xAA3333AA
#define COLOR_WHITE 0xFFFFFF

enum PLAYERS // example enums for the player
{
  pHunger, pThirst, // hunger and thirst
  pHungerTime, pThirstTime, // hunger time and thirst time
  Float:pHealth, Float:pArmour // health armour saves
}
new getD_Player[MAX_PLAYERS][PLAYERS]

// the function..
CheckNum(num, nums) {
  if (num != nums) {
    // logic there..
    num = 1 / 2
    nums = 2 / 1

    printf "num1 %i num2 %i", num, nums // example printf
  }
}

public OnGameModeInit() {

  // example get-times
  new timeString[9] // for format
  new currentTime = gettime()
  
  format( timeString, sizeof(timeString), "%02d:%02d:%02d",
      currentTime / 3600,              // Hours
      (currentTime % 3600) / 60,       // Minutes
      currentTime % 60                 // Seconds
  )
  printf "Current Time: %s", timeString

  return 1
}

public OnGameModeExit() { 
  return 1
}

new a, b, c
new Float:x, Float:y, Float:z

stock myName(p_) { // handling for function getNames
  new _name[MAX_PLAYER_NAME+1]
  GetPlayerName p_, _name, sizeof(_name)
  return 1 // just use return 1
}

public OnPlayerConnect(playerid)
{
  if (a != b || c != a) {
    // logic here
  }

  // reset variables.
  new Float:health, Float:armour
  GetPlayerHealth playerid, health
  GetPlayerArmour playerid, armour

  if (health >= 120.0 || armour >= 120.5) {
    SetPlayerHealth playerid, 100.20
    SetPlayerArmour playerid, 100.40
  }
  getD_Player[playerid][pHealth] = health
  getD_Player[playerid][pArmour] = armour

  // time select.
  getD_Player[playerid][pHungerTime] = gettime()
  getD_Player[playerid][pThirstTime] = gettime()

  return 1
}

public OnPlayerSpawn(playerid)
{
  SendClientMessage playerid, -1, "Use a \"/cursor\" to show your cursor, Use a \"/uncursor\" to hide your cursor." // output: "Use a "Cursor" for show your cursor, Use "/uncursor" to hide your cursor."

  return 1
}

public OnPlayerCommandText(playerid, cmdtext[])
{
  if (!strcmp(cmdtext, "/slap", true)) { // example commands.
    GetPlayerPos playerid, x, y, z
    SetPlayerPos playerid, x, y, z + 4.0 /* z to give a higher vertical, by adding 4.0 to the player's vertical. */

    new string[299]
    format string, sizeof(string), "%s has slapped", myName(playerid)
    SendClientMessageToAll -1, string
  }
  if (!strcmp(cmdtext, "/cursor", true)) {
    new r = random(3) + 1 // example create the random
    switch (r) { // switch
      case 1: SelectTextDraw playerid, COLOR_GREY // if random is 1.
      case 2: SelectTextDraw playerid, COLOR_GREEN // if random is 2.
      case 3: SelectTextDraw playerid, COLOR_RED // if random is 3.
      default: SelectTextDraw playerid, COLOR_WHITE // if random is unknowns.
    }
  }
  if (!strcmp(cmdtext, "/uncursor", true)) {
    CancelSelectTextDraw playerid
  }

  return 0
}

public OnPlayerUpdate(playerid)
{
  if (++ getD_Player[playerid][pHungerTime] >= 20) {
    getD_Player[playerid][pHunger]--;
    goto message_h // goto example
  }
  if (++ getD_Player[playerid][pThirstTime] >= 30) {
    getD_Player[playerid][pThirst]--;
    goto message_t // goto example
  }

  new str[200], str2[200]
  format str, sizeof(str), ""COLOR_R"[WARNING]: "COLOR_GR"Your Hunger is %d!!", getD_Player[playerid][pHunger]
  format str2, sizeof(str2), ""COLOR_R"[WARNING]: "COLOR_GR"Your Thirst is %d!!", getD_Player[playerid][pThirst]

message_h: // your goto logic
  SendClientMessage playerid, -1, str
message_t: // your goto logic
  SendClientMessage playerid, -1, str2

  return 1
}
```
