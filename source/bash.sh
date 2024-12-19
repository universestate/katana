#!/bin/bash

set -e

_version_="2024.x21 (B-14)"
_SearchDir_="$(dirname "$0")"

function laterium {
    echo
    echo "    ooooo"
    echo "    \`888'"
    echo "     888"
    echo "     888"
    echo "     888"
    echo "     888       o   $_version_"
    echo "    o888ooooood8"
    echo
}

laterium

newtime=$(date +"%H%M.%S")

function cmd {
    read -p "$USER@$(hostname)~$ " typeof

    if [ "$typeof" == "-c" ]; then
        echo
        echo "Compiling..."
        _compiler_
    elif [ "$typeof" == "-r" ]; then
        _part
        end
    elif [ "$typeof" == "-ci" ]; then
        _compiler_

        if grep -qi "error" rus.txt; then
            echo "Error Status...: [yes]"
            end
        else
            echo "Error Status...: [no]"
            _start_this
        fi
    elif [ "$typeof" == "-cls" ]; then
        clears
    elif [ "$typeof" == "-v" ]; then
        echo
        echo "    Laterium Version : $_version_"
        end
    elif [ "$typeof" == "-vsc" ]; then
        mkdir -p .vscode
        
        cat <<EOL > .vscode/tasks.json
{
  "version": "2.0.0",
  "tasks": [
    {
      "label": "Run Batch File",
      "type": "shell",
      "file": "${workspaceFolder}/bash.sh",
      "group": {
        "kind": "build",
        "isDefault": true
      },
      "problemMatcher": [],
      "detail": "Task to run the batch file"
    }
  ]
}
EOL

        echo "Creating '.vscode/tasks.json'...: [yes]"
        xdg-open .vscode/
        end
    elif [ "$typeof" == "help" ]; then
    :_help
        _hash_
        echo "usage: command [-c compile] [-r running server] [-ci compile-running] [-cls clear screen]"
        echo "      [-v laterium version] [-vsc vscode tasks]"
        cmd
    elif [ "$typeof" == "cat" ]; then
        _help
    else
        echo
        echo "    \$ $typeof - This typeof does not exist. Please try again.."
        sleep 2
        cmd
    fi
}

function end {
    echo "Press any key to return . . ."
    read -n 1
    cmd
}

function clears {
    clear
    laterium
    cmd
}

function _compiler_ {
    echo "Searching for .lt files..."

    laterium_pawncc_path=""
    for p in $(find "$_SearchDir_" -name "pawncc" -type f); do
        if [ -f "$p" ]; then
            laterium_pawncc_path="$p"
            break
        fi
    done

    if [ -z "$laterium_pawncc_path" ]; then
        echo
        echo "pawncc.exe not found in any subdirectories."
        echo
        sleep 1
        xdg-open "https://github.com/pawn-lang/compiler/releases"
        cmd
    fi

    found_file=""
    for f in $(find "$_SearchDir_" -name "*.lt" -type f); do
        if [ -f "$f" ]; then
            found_file="$f"
            break
        fi
    done

    if [ -z "$found_file" ]; then
        echo "No .lt files found in: $_SearchDir_"
        sleep 1
        cmd
    fi

    echo "Found file: $found_file"
    echo "Starting compilation.."
    echo

    "$laterium_pawncc_path" "$found_file" -o"$found_file.amx" -d0 > rus.txt 2>&1

    cat rus.txt

    if [ -f "$found_file.amx" ]; then
        echo "Compilation $found_file...: [yes]"
        echo

        echo "Total Size $found_file.amx / $(stat -c %s "$found_file.amx") bytes"
    else
        echo "Compilation $found_file...: [no]"
    fi

    echo
}

function _start_this {
    pkill -f "samp-server.exe"

    echo
    echo "Press any key to Start Your Server's . . ."
    read -n 1

    _part
}

function _part {
    sleep 1
    nohup ./samp-server.exe &

    sleep 2

    if ! pgrep -f "samp-server.exe" > /dev/null; then
        echo "samp-server.exe not found.."
        sleep 1
        xdg-open "https://sa-mp.app/"
        cmd
    fi

    if ! pgrep -f "samp-server.exe" > /dev/null; then
        echo
        echo "Status Starting...: [no]"
        echo "Server failed to run.."
        echo

        if [ -f "server_log.txt" ]; then
            xdg-open "server_log.txt"
        else
            echo "server_log.txt not found."
        fi
    else
        echo
        echo "Status Starting... [yes]"
        echo
    fi
}

function _hash_ {
    compn="$USER@$(hostname)"
    hash=$(echo -n "$compn" | sha1sum | awk '{print $1}')
    echo "$compn | $hash"
}

cmd
