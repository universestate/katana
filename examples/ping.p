#include"a_samp"

main(){}

public OnPlayerConnect(playerid) {
  new _ping=GetPlayerPing(playerid),
    _str[22];
  format(_str,sizeof(_str), "Your Ping: %d", _ping);
  SendClientMessage playerid, -1, _str;
  return 1;
}
