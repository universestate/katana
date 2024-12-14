#include"a_samp"

main(){}

public OnPlayerCommandText(playerid, cmdtext[])
{
  if (!strcmp(cmdtext, "/jetpack", true))
    { SetPlayerSpecialAction playerid, SPECIAL_ACTION_USEJETPACK; }
  if (!strcmp(cmdtext, "/handsup", true))
    { SetPlayerSpecialAction playerid, SPECIAL_ACTION_HANDSUP; }
  if (!strcmp(cmdtext, "/cuffed", true))
    { SetPlayerSpecialAction playerid, SPECIAL_ACTION_CUFFED; }
  if (!strcmp(cmdtext, "/carry", true))
    { SetPlayerSpecialAction playerid, SPECIAL_ACTION_CARRY; }

  return 0;
}
