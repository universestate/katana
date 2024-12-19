#!/bin/bash

_version_="2024.x21 (B-14)"
_SearchDir_="$(dirname "$0")"

_laterium_() {
    echo
    echo "    ooooo"
    echo "    '888'"
    echo "     888"
    echo "     888"
    echo "     888"
    echo "     888       o   $_version_"
    echo "    o888ooooood8"
    echo
}

_laterium_

newtime=$(date +"%H%M.%S")

cmd() {
    read -p "${USER}@${HOSTNAME}~$ " typeof

    case "$typeof" in
        "cat -c")
            echo
            echo "Compiling..."
            _compiler_
            ;;
        "cat -r")
            _part
            ;;
        "cat -ci")
            _compiler_

            if grep -qi "error" rus.txt; then
                echo "Error Status...: [yes]"
            else
                echo "Error Status...: [no]"
                _start_this
            fi
            ;;
        "cat -cls")
            clear
            _laterium_
            ;;
        "cat -v")
            echo
            echo "    Laterium Version : $_version_"
            ;;
        "cat -vsc")
            mkdir -p .vscode
            cat <<EOL > .vscode/tasks.json
{
  "version": "2.0.0",
  "tasks": [
    {
      "label": "Run Batch File",
      "type": "shell",
      "file": "\${workspaceFolder}/batch.bat",
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
            xdg-open .vscode
            ;;
        "help")
            _help
            ;;
        "cat")
            _help
            ;;
        "")
            ;;
        *)
            echo
            echo "    $ $typeof - This typeof does not exist. Please try again.."
            sleep 2
            ;;
    esac
}

_start_this() {
    pkill -f samp-server.exe

    echo
    echo "Press any key to Start Your Server's . . ."
    read -n 1 -s
    _part
}

_part() {
    sleep 1
    samp-server.exe &

    sleep 2

    if ! pgrep -f samp-server.exe > /dev/null; then
        echo "samp-server.exe not found.."
        sleep 1
        xdg-open "https://sa-mp.app/"
        cmd
    elif [ $? -ne 0 ]; then
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

_compiler_() {
    echo "Searching for .lat files..."

    laterium_pawncc_path=""
    for p in $(find "$_SearchDir_" -name pawncc.exe); do
        if [ -e "$p" ]; then
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
    for f in $(find "$_SearchDir_" -name "*.lat*"); do
        if [ -e "$f" ]; then
            found_file="$f"
            break
        fi
    done

    if [ -z "$found_file" ]; then
        echo "No .lat files found in: $_SearchDir_"
        sleep 1
        cmd
    fi

    echo "Found file: $found_file"
    echo "Starting compilation.."
    echo

    output_file="${found_file%.lat*}.amx"

    "$laterium_pawncc_path" "$found_file" -o"$output_file" -d0 > rus.txt 2>&1

    cat rus.txt

    if [ -e "$output_file" ]; then
        echo "Compilation $output_file...: [yes]"
        echo

        echo "Total Size $output_file / $(du -b "$output_file" | cut -f1) bytes"
    else
        echo "Compilation $output_file...: [no]"
    fi

    echo
}

_help() {
    compn="${USER}@${HOSTNAME}"
    hash=$(echo -n "$compn" | sha1sum | awk '{print $1}')
    echo "usage: cat [-c compile] [-r running server] [-ci compile-running] [-cls clear screen]"
    echo "      [-v laterium version] [-vsc vscode tasks]"
}

while true; do
    cmd
done
