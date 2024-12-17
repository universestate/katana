```
$ git clone https://github.com/universestate/katana.git
```
`[*] Paste kn.cmd to\path\your\gamemode. or use kn.exe for easy installation.`
```c++
// You can use this struct if your use katana.

main() {
  printf "Hello, World";
// Please don't use 'return 0' in here.
}

public OnGameModeInit() {

inhere:
  // your code.

  goto inhere; // goto struct..

  return 1;
}

// now, ';' is an optional symbol for end.
main() {
  new a, b, c, d /* for variables */

  if (a == b || c == d || c == a) {
    // there..
  }
}

// and now '(' ')' is an optional symbol.
main() {
  new string[200]

  format string, sizeof(string), "your message..";

  // Please don't use it in a way that relies heavily on the symbol ()
  /*
    new a, b
    if a == b () // example
  */
}
```
