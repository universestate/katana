```pwn
/**
* Thanks to SA-MP Team, ITB CompuPhase.
*/

#include "a_samp"

main() {
  print "Hello, World!";

  new num1, num2;
  CheckNum(num1, num2);
}

#define COLOR_R "{FF0000}"
#define COLOR_Y "{FFF070}"
#define COLOR_W "{FFFFFF}"
#define COLOR_GR "{999999}"

enum ENUM_PLAYERS
{
  pHunger, pThirst, pHungerTime, pThirstTime,
  Float:health, Float:armour
}
new getD_Player[MAX_PLAYERS][ENUM_PLAYERS];

CheckNum(num, nums) {
  if (num != nums) {
    num = 1 / 2;
    nums = 2 / 1;

    printf "%i%i", num, nums;
  }
}

public OnGameModeInit() {
:ctimes
  new timeString[9]
  new currentTime = gettime()
  
  format( timeString, sizeof(timeString), "%02d:%02d:%02d",
      currentTime / 3600,              // Hours
      (currentTime % 3600) / 60,       // Minutes
      currentTime % 60                 // Seconds
  )
  printf "Current Time: %s", timeString;

  return 1;
}

public OnGameModeExit() { return 1; }

new a, b, c
new Float:x, Float:y, Float:z

stock myName(p_) {
  new _name[MAX_PLAYER_NAME+1];
  GetPlayerName p_, _name, sizeof(_name);
  return 1;
}

public OnPlayerConnect(playerid)
{
  if (a != b || c != a) {
    // logic here
  }

  // reset variables.
  new Float:health, Float:armour;
  GetPlayerHealth playerid, health;
  GetPlayerArmour playerid, armour;

  if (health >= 120.0 || armour >= 120.5) {
    SetPlayerHealth playerid, 100.20;
    SetPlayerArmour playerid, 100.40;
  }
  getD_Player[playerid][pHealth] = health;
  getD_Player[playerid][pArmour] = armour;

  // time select.
  getD_Player[playerid][pHungerTime] = gettime();
  getD_Player[playerid][pThirstTime] = gettime();
  return 1;
}

public OnPlayerSpawn(playerid)
{
  SendClientMessage playerid, -1, "Use a \"/cursor\" for show your cursor, Use a \"/uncursor\" for hide your cursor.";
  return 1;
}

public OnPlayerCommandText(playerid, cmdtext[])
{
  if (!strcmp(cmdtext, "/slap", true)) {
    GetPlayerPos playerid, x, y, z;

    new string[299];
    format string, sizeof(string), "%s has slapped", myName(playerid);
    SendClientMessageToAll -1, string;
  }
  if (!strcmp(cmdtext, "/cursor", true)) {
    new r = random(4) + 1;
    switch (r) {
      case 1: { SelectTextDraw playerid, COLOR_R; }
      case 2: { SelectTextDraw playerid, COLOR_Y; }
      case 3: { SelectTextDraw playerid, COLOR_W; }
      case 4: { SelectTextDraw playerid, COLOR_GR; }
    }
  }
  if (!strcmp(cmdtext, "/uncursor", true)) {
    CancelSelectTextDraw playerid;
  }
  return 0;
}

public OnPlayerUpdate(playerid)
{
:message_h
  SendClientMessage playerid, -1, ""COLOR_R"[WARNING]: "COLOR_GR"Your Hunger is %d!!", getD_Player[playerid][pHunger];
:message_t
  SendClientMessage playerid, -1, ""COLOR_R"[WARNING]: "COLOR_GR"Your Thirst is %d!!", getD_Player[playerid][pThirst];

  if (++ getD_Player[playerid][pHungerTime] >= 20)
    goto message_h;
  if (++ getD_player[playerid][pThirstTime] >= 30)
    goto message_t;

  return 1;
}
```
