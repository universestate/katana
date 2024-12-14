#include"a_samp"

main() {
  new value 10 / 20;
  printf "%d", value;
} // do not use return 0; in here..

public OnGameModeInit() {
  return 1;
}

public OnGameModeExit() {
  return 1;
}

public OnPlayerSpawn(playerid) {
  new string[200],
    name[MAX_PLAYER_NAME+1]
    
  GetPlayerName playerid, name, sizeof(name);
  format string, sizeof(string), "Hello, %s", name;

  return 1;
}
