#include"a_samp"

main(){}

new example[MAX_PLAYERS char];

public OnPlayerSpawn(playerid) {
	example[playerid] = 'B';
	return 1;
}

public OnPlayerConnect(playerid)
{
  if (example[playerid] == 'B') {
    SendClientMessage playerid, -1, "Your Status is B!";
  }
  return 1;
}
