<details>
  <summary>More Information</summary>
  
  > [Licenses](https://github.com/universestate/laterium/blob/main/LICENSE.md)
  > [Notices](https://github.com/universestate/laterium/blob/main/NOTICE.md)
  > [Example](https://github.com/universestate/laterium/blob/main/STRUCT.md)
  > [Report/Help](https://github.com/universestate/laterium/pulls)

</details>

> - [x] easier, faster, smaller size.

- [x] Clone the Laterium repository:
```bash
$ git clone https://github.com/universestate/laterium.git
```
- [x] Copy `".bat"` or `".sh"` files into the appropriate directory.
```
path\to\your\gamemodes
```
- [x] Add the extension `".lat"` for files to be marked. -example, rename `main.pwn` to `main.lat.pwn` (lowercase only).
- [x] Run the script appropriate for your operating system:

- **Windows**
  ```bat
  $ cd path\to\batch
  $ windows.bat
  ```
- **Linux/Mac**
  ```sh
  $ cd path/to/bash
  $ chmod +x shell-Unix.sh
  $ ./shell-Unix.sh
  ```
- [x] Use these `cat` commands to access specific functions and information:
```bash
  $ cat/help      # More commands Information.
  $ cat -c        # Compile with Laterium compilers.
  $ cat -ci       # Compile and launch your server.
  $ cat -vsc      # Tasks file for Visual Studio Code.
  $ cat -v        # Display version information.
```
- [x] How to Use vscode tasks in Linux.
```sh
    # Download libpawnc.so:
    # Download the libpawnc.so file from the Pawn compiler releases.

    # Place libpawnc.so in the correct directory:
    # Place the libpawnc.so file in /usr/local/lib:

    $ sudo cp /path/to/downloaded/libpawnc.so /usr/local/lib/
    
    # Update Library Path:
    # Set the library path to /usr/local/lib:
    
    $ export LD_LIBRARY_PATH=/usr/local/lib:$LD_LIBRARY_PATH
    
    # Run ldconfig:
    # Update the library cache:
    
    $ sudo ldconfig
    
    # Verify Installation:
    # Verify if the library is installed correctly:
    
    $ ldd /path/to/pawncc
    
    # Replace /path/to/downloaded/libpawnc.so and /path/to/pawncc with the actual paths on your system. If the issue persists, ensure there are no permission issues with libpawnc.so and that the library path is correctly set.
```
#
> And thanks to open.mp team `*for this`
![History](HISTORY.png)
