```
$ git clone https://github.com/universestate/katana.git
```
`[*] Paste kn.cmd to\path\your\gamemode. or use kn.exe for easy installation.`
```pwn
// Simplified Katana-Style Code Example

// You can use this struct if your use katana.
main() {
    printf "Hello, World";
    // Please don't use 'return 0' in here.
}

public OnGameModeInit() {
    inhere:
        // Your code.
        
        goto inhere; // Goto struct..
        return 1;
}

// Now, ';' is an optional symbol for end.
main() {
    new a, b, c, d; // Variables declaration

    if (a == b || c == d || c == a) {
        // Logic here..
    }
}

// And now '(' ')' is an optional symbol.
main() {
    new string[200];

    format string, sizeof(string), "your message..";

    // Please don't use it in a way that relies heavily on the symbol ()
    /*
      new a, b
      if a == b {
        // Example
      }
    */
    
    // But you can use:
    /*
      new a, b
      if (a == b) {
          // Logic here..
      }
    */
}
```
