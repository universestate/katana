<details>
  
  <summary>More Information</summary>
  
  > [Licenses](https://github.com/universestate/laterium/blob/main/LICENSE.md)
  > [Notices](https://github.com/universestate/laterium/blob/main/NOTICE.md)
  > [Example](https://github.com/universestate/laterium/blob/main/STRUCT.md)
  > [Report/Help](https://github.com/universestate/laterium/pulls)
  
</details>

- [x] **A.** Clone the Laterium repository:
```bash
$ git clone https://github.com/universestate/laterium.git
```
- [x] **B.** Copy `".bat"` or `".sh"` files into the appropriate directory:
```
path\to\your\project
```
- [x] **C.** Please create a `".cat"` extension to mark the file to be compiled. (Example): from `main.pwn` to `main.cat.pwn` (lowercase only).

- [x] **D.** Run the script appropriate for your operating system:
- **Windows `(you can run the batch file directly)`**
  ```bat
  $ cd path\to\batch
  $ windows.bat
  ```
- **Linux/macOS**
  ```sh
  $ cd path/to/bash
  $ chmod +x shell-Unix.sh
  $ ./shell-Unix.sh
  ```
- [x] Use these `cat` commands to access specific functions and information:
  ```sh
  $ cat/help      # More commands Information.
  $ cat -c        # Compile with Laterium compilers.
  $ cat -ci       # Compile and launch your server.
  $ cat -vsc      # Tasks file for Visual Studio Code.
  $ cat -v        # Display version information.
  ```
#
- [x] Code translation:
  ```
  -A<num> alignment in bytes of the data segment and the stack
  -a output assembler code
  -C[+/-] compact encoding for output file (default=+)
  -c<name> codepage name or number; e.g. 1252 for Windows Latin-1
  -Dpath active directory path
  -d<num> debugging level (default=-d1)
  0 no symbolic information, no run-time checks
  1 run-time checks, no symbolic information
  2 full debug information and dynamic checking
  3 same as -d2, but implies -O0
  -e<name> set name of error file (quiet compile)
  -H<hwnd> window handle to send a notification message on finish
  -i<name> path for include files
  -l create list file (preprocess only)
  -o<name> set base name of (P-code) output file
  -O<num> optimization level (default=-O1)
  0 no optimization
  1 JIT-compatible optimizations only
  2 full optimizations
  -p<name> set name of "prefix" file
  -r[name] write cross reference report to console or to specified file
  -S<num> stack/heap size in cells (default=4096)
  -s<num> skip lines from the input file
  -t<num> TAB indent size (in character positions, default=8)
  -v<num> verbosity level; 0=quiet, 1=normal, 2=verbose (default=1)
  -w<num> disable a specific warning by its number
  -X<num> abstract machine size limit in bytes
  -XD<num> abstract machine data/stack size limit in bytes
  -\ use '' for escape characters
  -^ use '^' for escape characters
  -;[+/-] require a semicolon to end each statement (default=-)
  -([+/-] require parentheses for function invocation (default=-)
  sym=val define constant "sym" with value "val"
  sym= define constant "sym" with value 0
  ```
#
