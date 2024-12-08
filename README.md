# Katana® Software.
![Katana](unix.jpg)
#
### What's Katana Software?,
`Katana is a compiler software used for compiling Pawn code in San Andreas Multiplayer (SA-MP). Katana Soft is inspired by Ken Thompson, the scientist who created UNIX and the C programming language.`
## installation:
```
$ git clone https://github.com/universestate/Katana-Software
```
## requirements:
- `All you need is your SA-MP GameMode, whether it's version 0.3.7 or 0.3.DL. You will also need a Pawn Compiler file called` 'pawncc.exe .. `If you don’t have it, you can download it from` [Pawn Lang](https://github.com/pawn-lang/compiler/releases).
- **Tutorial installing**: `install the batch file from` "[\src](https://github.com/universestate/Katana-Software/tree/e193de36c726be3fb41689e0bf7231b5d605dd00/src)" `into your gamemode directory. and follow the preview`: [YouTube Video](https://www.youtube.com/watch?v=Xn5ZiOmkCPM).
- On Linux: please see [Linux.ORG](https://www.linux.org/threads/running-windows-batch-files-on-linux.11205/) first.
## Example HelloWorld & Looping.
```pwn
#include "a_samp"

main() {
  print "Hello, World"

  for (new i = 0; i >= 0; i++) { // infinity loop.
      printf "%d", i;
  }
}
```
### **Output**:
![image](space.png)
