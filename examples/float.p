#include"a_samp"

main(){}

public OnPlayerCommandText(playerid, cmdtext[])
{
  if (!strcmp(cmdtext, "/mypos", true))
  {
    new Float:fPlayer[4];
    GetPlayerPos(playerid, fPlayer[0], fPlayer[1], fPlayer[2]);
    GetPlayerFacingAngle(playerid, fPlayer[3]);

    format(string, sizeof(string), "X %.2f Y %.2f Z %.2f A %.2f", fPlayer[0], fPlayer[1], fPlayer[2], fPlayer[3]);
    new File:saves = fopen("savepos.txt", io_append);
    if (saves == File:0) { return 0; }
    fwrite(saves, string), fclose(saves);

    return 1;
  }
  return 0;
}
