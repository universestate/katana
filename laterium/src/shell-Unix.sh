#!/bin/bash

version="2024.x21 (B-14)"
search_dir="$(dirname "$(realpath "$0")")"

_laterium() {
    echo
    echo "    ooooo"
    echo "    '888'"
    echo "     888"
    echo "     888"
    echo "     888"
    echo "     888       o   $version"
    echo "    o888ooooood8"
    echo
}

_compiler() {
    echo "Searching for .lat files..."

    pawncc=""
    while IFS= read -r -d '' file; do
        if [[ -x "$file" ]]; then
            pawncc="$file"
            break
        fi
    done < <(find "$search_dir" -name "pawncc" -print0)

    if [[ -z "$pawncc" ]]; then
        echo
        echo "pawncc not found in any subdirectories."
        echo
        xdg-open "https://github.com/pawn-lang/compiler/releases"
        return
    fi

    while IFS= read -r -d '' file; do
        if [[ -f "$file" ]]; then
            echo "Found file: $file"
            echo "Starting compilation..."
            echo

            output="${file%.lat}.amx"

            "$pawncc" "$file" -o"$output" -d0 > rus.txt 2>&1

            cat rus.txt

            if [[ -f "$output" ]]; then
                echo "Compilation $output...: [yes]"
                echo
                size=$(stat -c%s "$output")
                echo "Total Size $output / $size bytes"
            else
                echo "Compilation $output...: [no]"
            fi

            echo
        fi
    done < <(find "$search_dir" -name "*.lat.pwn*" -print0)
}

_part() {
    pkill -f "samp-server" 2>/dev/null

    echo
    echo "Press any key to start your server's..."
    read -n 1 -s

    ./samp-server &

    sleep 2

    if ! pgrep -f "samp-server" > /dev/null; then
        echo "samp-server not found.."
        sleep 1
        xdg-open "https://sa-mp.app/"
        return
    fi

    if ! pgrep -f "samp-server" > /dev/null; then
        echo
        echo "Status Starting...: [no]"
        echo "Server failed to run.."

        echo "Checking Logs..."
        sleep 4

        if [[ -f "server_log.txt" ]]; then
            cat "server_log.txt"
        else
            echo "server_log.txt not found."
        fi
        echo
        echo "end..."
    else
        echo
        echo "Status Starting... [yes]"
        echo
    fi
}

_help() {
    echo "usage: cat [-c compile] [-r running server] [-ci compile-running] [-cls clear screen]"
    echo "      [-v laterium version] [-vsc vscode tasks]"
}

_laterium

echo
echo "type 'help' to get started"
echo

while true; do
    read -p "$USER@$HOSTNAME~$ " typeof

    case "$typeof" in
        "cat -c")
            echo
            echo "Compiling..."
            _compiler
            ;;
        "cat -r")
            _part
            ;;
        "cat -ci")
            _compiler

            if grep -qi "error" rus.txt; then
                echo "Failure"
            else
                echo "Success"
                _part
            fi
            ;;
        "cat -cls")
            clear
            _laterium
            ;;
        "cat -v")
            echo
            echo "    Laterium Version : $version"
            echo
            ;;
        "cat -vsc")
            if [[ -d ".vscode" ]]; then
                echo "A subdirectory or file .vscode already exists."
            else
                mkdir .vscode
                cat > .vscode/tasks.json <<- EOM
{
  "version": "2.0.0",
  "tasks": [
    {
      "label": "Run Batch File",
      "type": "shell",
      "file": "\${workspaceFolder}/windows.bat",
      "group": {
          "kind": "build",
          "isDefault": true
      },
      "problemMatcher": [],
      "detail": "Task to run the batch file"
    }
  ]
}
EOM
                echo "Creating '.vscode/tasks.json'...: [yes]"
                xdg-open ".vscode"
            fi
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
            echo "$ typeof - This typeof does not exist. Please try again.."
            sleep 2
            ;;
    esac
done
