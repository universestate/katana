#include"a_samp"

main(){}

new bool:checkpoint[MAX_PLAYERS];

public OnPlayerCommandText(playerid, cmdtext[])
{
  if (s!trcmp(cmdtext, "/cp", true)) {
    SetPlayerCheckpoint(playerid, 123.0, 123.1, 123.2, 2.3);
    checkpoint[playerid] = true;
    return 1;
  }
  return 0;
}

public OnPlayerEnterCheckpoint(playerid)
{
    if (checkpoint[playerid] == true) {
        SetPlayerScore(playerid, GetPlayerScore(playerid) + 2);
        GivePlayerMoney(playerid, 2000);
        DisablePlayerCheckpoint(playerid);
        checkpoint[playerid] = false;
    }
    return 1;
}
