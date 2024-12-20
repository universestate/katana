#!/bin/bash

_version_="2024.x21 (B-14)"
_SearchDir_=$(dirname "$0")

function _laterium_ {
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

function _compiler_ {
    echo "Searching for .lat files..."

    _pawncc=""
    for p in $(find "$_SearchDir_" -name "pawncc"); do
        if [[ -x "$p" ]]; then
            _pawncc="$p"
            break
        fi
    done

    if [[ -z "$_pawncc" ]]; then
        echo
        echo "pawncc not found in any subdirectories."
        echo
        xdg-open "https://github.com/pawn-lang/compiler/releases"
        return
    fi

    for f in $(find "$_SearchDir_" -name "*.lat.pwn*"); do
        if [[ -f "$f" ]]; then
            echo "Found file: $f"
            echo "Starting compilation..."
            echo

            _output="${f%.lat}.amx"
            "$_pawncc" "$f" -o"$_output" -d0 > rus.txt 2>&1

            cat rus.txt

            if [[ -f "$_output" ]]; then
                echo "Compilation $_output...: [yes]"
                echo

                echo "Total Size $_output / $(stat -c%s "$_output") bytes"
            else
                echo "Compilation $_output...: [no]"
            fi

            echo
        fi
    done
}

function _start_this {
    pkill -f "samp-server"
    echo
    read -n 1 -s -r -p "Press any key to Start Your Server's . . ."
    _part
}

function _part {
    ./samp-server &
    sleep 2

    if [[ ! -f samp-server ]]; then
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

function _hash_ {
    compn="$USER@$(hostname)"
    hash=$(echo -n "$compn" | sha1sum | awk '{print $1}')
    echo "$compn | $hash"
}

_laterium_
echo "type 'help' to get started"

while true; do
    read -p "$USER@$(hostname)~$ " typeof

    if [[ "$typeof" == "cat -c" ]]; then
        echo
        echo "Compiling..."
        _compiler_

    elif [[ "$typeof" == "cat -r" ]]; then
        _part

    elif [[ "$typeof" == "cat -ci" ]]; then
        _compiler_

        if grep -qi "error" rus.txt; then
            echo "Failure"
        else
            echo "Success"
            _start_this
        fi

    elif [[ "$typeof" == "cat -cls" ]]; then
        clear
        _laterium_

    elif [[ "$typeof" == "cat -v" ]]; then
        echo
        echo "    Laterium Version : $_version_"
        echo

    elif [[ "$typeof" == "cat -vsc" ]]; then
        mkdir -p .vscode

        cat <<EOL > .vscode/tasks.json
{
  "version": "2.0.0",
  "tasks": [
    {
      "label": "Run Batch File",
      "type": "shell",
      "file": "\${workspaceFolder}/shell-Unix.sh",
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
        xdg-open ".vscode/"

    elif [[ "$typeof" == "help" ]]; then
        _hash_
        echo "usage: cat [-c compile] [-r running server] [-ci compile-running] [-cls clear screen]"
        echo "       [-v laterium version] [-vsc vscode tasks]"

    elif [[ "$typeof" == "cat" ]]; then
        _hash_
        echo "usage: cat [-c compile] [-r running server] [-ci compile-running] [-cls clear screen]"
        echo "       [-v laterium version] [-vsc vscode tasks]"

    elif [[ -z "$typeof" ]]; then
        continue

    else
        echo
        echo "    $typeof - This typeof does not exist. Please try again.."
        sleep 2
    fi
done
