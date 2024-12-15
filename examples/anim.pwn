#include"a_samp"
#include"zcmd"

COMMAND:anim(playerid, params[])
{
    new
        Index = strval(params),
        AnimLib[32],
        AnimName[32];

    if(Index < 1 || Index > 1812)
        return SendClientMessage(playerid, -1, "/anim [1-1812]");

    GetAnimationName(Index, AnimLib, 32, AnimName, 32);
    ApplyAnimation(playerid, AnimLib, AnimName, 4.1, 1, 1, 1, 1, 1, 1);
    return 1;
}
