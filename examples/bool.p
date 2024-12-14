#include"a_samp"

main(){}

new bool:status;

public OnGameModeInit() {
  status = true;
  return 1;
}

public OnGameModeExit() {
  status = false;
  return 1;
}
