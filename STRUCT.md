```c++
/**
* Thanks to SA-MP Team, ITB CompuPhase.
*/

#include "a_samp"

main() {
  print "Hello, World!";

  new num1, num2;
  CheckNum(num1, num2);
}

CheckNum(num, nums) {
  if (num != nums) {
    num = 1 / 2;
    nums = 2 / 1;

    printf "%i%i", num, nums;
  }
}

public OnGameModeInit() {
  new timeString[9];
  new currentTime = gettime();
  
  format(timeString, sizeof(timeString), "%02d:%02d:%02d",
      currentTime / 3600,              // Hours
      (currentTime % 3600) / 60,       // Minutes
      currentTime % 60                 // Seconds
  );
  
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
  return 0;
}
```
