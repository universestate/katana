/**
* Example
*/
#include "a_samp"
#include "string"

main() {
  print "Hello, World"

  for (new i = 0; i >= 0; i++) { // infinity loop.
      printf "%d", i;
  }
}

stock getPlayerName(playerid) {
  new _name[MAX_PLAYER_NAME+1];
    GetPlayerName(playerid, _name, sizeof(_name));
  return 1;
}

public OnPlayerSpawn(playerid) {
new str[20];
  format str, 20, "Hello, %s", getPlayerName(playerid);
  SendClientMessage playerid, -1, str;
  return 1;
}
