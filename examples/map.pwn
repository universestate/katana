#include"a_samp"

main(){}

public OnPlayerCommndText(playerid, cmdtext[])
{
  if (!strcmp(cmdtext, "/grovest", true))
  {
    new Float:dist=GetPlayerDistanceFromPoint(playerid, 2495.5, -1683.6, 13.5);

    new str[144+2];
    format(str,sizeof(str), "%.2f meters from Grove Street Gng.", dist);
    SendClientMessage playerid, -1, str;
    return 1;
  }
  return 0;
}
