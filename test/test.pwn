#include "a_samp"

main() {
  print "Hello, World"

  for (new i = 0; i >= 0; i++) { // infinity loop.
      printf "%d", i;
  }
}

public OnPlayerSpawn(playerid) {
  SendClientMessage playerid, -1, "Hello!";

  return 1;
}
