#include"a_samp"

main(){}

public OnPlayerText(playerid, text[])
{
  if (strlen(text)<0) return 0;

  new name[MAX_PLAYER_NAME+1];
  GetPlayerName(playerid, name, sizeof(name));
  
  new str[144+1];
  format(str,sizeof(str), "%s[%d]: %s",name, playerid, text);
  SendClientMessage playerid, -1, str;

  new Float:fPlayerX, Float:fPlayerY, Float:fPlayerZ;
	new Float:fPlayerToPlayerDist;
 		GetPlayerPos(playerid, fPlayerX, fPlayerY, fPlayerZ);
 
  new Float:dist=3.2;
  SetPlayerChatBubble playerid, text, -1, dist, 1400;
  
  for (new i=0;i<MAX_PLAYERS; i++) if (IsPlayerConnected(i) && (i != playerid) && IsPlayerStreamedIn(playerid,i)) {
	fPlayerToPlayerDist = GetPlayerDistanceFromPoint(i, fPlayerX, fPlayerY, fPlayerZ);
		if (fPlayerToPlayerDist < dist) { SendClientMessage i, -1, str; }
  }
  return 0;
}
