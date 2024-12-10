#!/bin/bash

# Set CMYK color (this is just an example since Linux terminal doesn't support "color c" like Windows)
# Set terminal title to current date
echo -ne "\033]0;$(date)\007"

# Set variables
version="2024.latest.Now (0.0.4)"  # current version

# ASCII art function
function ascii_art() {
    echo "oooo    oooo       .o.       ooooooooooooo       .o.       ooooo      ooo       .o.       "
    echo "\`888   .8P'       .888.      8'   888   \`8      .888.      \`888b.     \`8'      .888.      "
    echo " 888  d8'        .8\"888.          888          .8\"888.      8 \`88b.    8      .8\"888.     "
    echo " 88888\`         .8' \`888.         888         .8' \`888.     8   \`88b.  8     .8' \`888.    "
    echo " 888\`88b.      .88ooo8888.        888        .88ooo8888.    8     \`88b.8    .88ooo8888.   "
    echo " 888  \`88b.   .8'     \`888.       888       .8'     \`888.   8       \`888   .8'     \`888. "
    echo "o888o  o888o o88o     o8888o     o888o     o88o     o8888o o8o        \`8  o88o     o8888o "
    echo ""
}

# Display command options
function display_commands() {
    echo "**************************"
    echo "** [General] "
    echo "* Katana     :       -katana        : What's Katana?"
    echo "* Katana     :       -build         : build Katana compiler."
    echo "* Katana     :       -start         : Start Katana compiler."
    echo "* Katana     :       -bstart        : build - compile.."
    echo "* Katana     :       -runn          : running server's."
    echo "* Katana     :       -srunn         : compile - run server.."
    echo ""
    echo "** [Mod] "
    echo "* Katana     :       -version       : Your Katana Version."
    echo "* Katana     :       -username      : Your Linux Username."
    echo ""
    echo "** [Startup] "
    echo "* Katana     :       -tasks         : Create VSCode Task Katana Compiler."
    echo "* Katana     :       -example       : Create Example Katana Funcc SA-MP."
    echo "* Katana     :       -clear         : Clear Terminal Screen, Back to main menu."
    echo ""
    echo "**************************"
}

# Handle command input and responses
function process_command() {
    read -p "** input cmd: > $ " command

    case "$command" in
        "-katana")
            zenity --info --text="Katana is a compilation tool with multiple functions for the Pawn Compiler in SA-MP."
            zenity --info --text="You do not need to use symbols like ';' and '( )' and other in your program code if using this software."
            zenity --info --text="-[WARNING]-: If you use the code structure from Katana, you are expected to compile it using the software provided by Katana."
            zenity --info --text="Thank you for using this software :)"
            ;;
        
        "-build")
            echo "Building compiler..."
            ./pawn-setup.sh
            ;;
        
        "-start")
            echo "Compiling..."
            ./pawn-start.sh
            ;;
        
        "-bstart")
            ./pawn-setup.sh
            echo "Press any key to open Compiler..."
            read -n 1 -s
            ./pawn-start.sh
            ;;
        
        "-runn")
            ./samp-server &
            sleep 1
            if ! pgrep -x "samp-server" > /dev/null; then
                echo "The program failed to run. Checking logs..."
                if [ -f "server_log.txt" ]; then
                    echo "Opening server_log.txt..."
                    xdg-open "server_log.txt"
                else
                    echo "server_log.txt not found."
                fi
            else
                echo "The program was executed successfully."
            fi
            ;;
        
        "-srunn")
            ./pawn-start.sh
            echo "Press any key to Start Your Server..."
            read -n 1 -s
            ./samp-server &
            sleep 1
            if ! pgrep -x "samp-server" > /dev/null; then
                echo "The program failed to run. Checking logs..."
                if [ -f "server_log.txt" ]; then
                    echo "Opening server_log.txt..."
                    xdg-open "server_log.txt"
                else
                    echo "server_log.txt not found."
                fi
            else
                echo "The program was executed successfully."
            fi
            ;;
        
        "-username")
            echo "Current Username => $(whoami)"
            ;;
        
        "-version")
            echo "Current Katana Version => $version"
            zenity --info --text="Your Katana Version: 2024.latest.Now - build (0.0.4)"
            ;;
        
        "-tasks")
            if [ ! -d ".vscode" ]; then
                mkdir .vscode
            else
                echo ":: the task already exists!."
                return
            fi

            echo ":: Creating .vscode/tasks.json..."
            cat > .vscode/tasks.json <<EOL
{
  "version": "2.0.0",
  "tasks": [
    {
      "label": "Run Katana SA-MP CMD",
      "type": "shell",
      "command": "start",
      "args": ["${workspaceFolder}/pawn-start.sh"],
      "group": {
        "kind": "build",
        "isDefault": true
      },
      "problemMatcher": [],
      "presentation": {
        "reveal": "silent"
      }
    }
  ]
}
EOL
            echo ":: Task configuration created successfully in .vscode/tasks.json."
            ;;
        
        "-example")
            if [ ! -d "guidelines" ]; then
                mkdir guidelines
            else
                echo ":: the example already exists!"
                return
            fi

            echo ":: Creating guidelines/helloworld.pwn..."
            cat > guidelines/helloworld.pwn <<EOL
/* example */
#include "a_samp"

#pragma tabsize 4

main() {
    printthis:
    print "Hello, World!"
        goto printthis;
    return 1;
}

public OnPlayerConnect(playerid) {
    SendClientMessage(playerid, -1, "Hello")
    return 1;
}
EOL
            echo ":: Example tool created in guidelines/helloworld.pwn."
            ;;
        
        "-clear")
            clear
            ascii_art
            display_commands
            ;;
        
        "help")
            display_commands
            ;;
        
        "hello")
            zenity --info --text="Hello, Man :)"
            ;;
        
        "")
            display_commands
            ;;
        
        "katana")
            display_commands
            ;;
        
        *)
            echo ":: $command - This command does not exist. Please try again."
            sleep 2
            ;;
    esac
}

# Main loop
while true; do
    ascii_art
    display_commands
    process_command
done
