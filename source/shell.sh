#!/bin/bash

version="2024.x21 (B-14)"
search_dir=$(dirname "$0")

_laterium_() {
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

_laterium_

time=$(date +%H%M.%S)
newtime=$time

cmd() {
    read -p "$USER@$HOSTNAME~$ " typeof

    if [[ "$typeof" == "cat -c" ]]; then
        echo
        echo "Compiling..."
        _compiler_
    elif [[ "$typeof" == "cat -r" ]]; then
        _part
        return
    elif [[ "$typeof" == "cat -ci" ]]; then
        _compiler_

        if grep -qi "error" rus.txt; then
            echo "Error Status...: [yes]"
            return
        else
            echo "Error Status...: [no]"
            _start_this
        fi
    elif [[ "$typeof" == "cat -cls" ]]; then
        clears
        _laterium_
        cmd
    elif [[ "$typeof" == "cat -v" ]]; then
        echo
        echo "    Laterium Version : $version"
        echo
        return
    elif [[ "$typeof" == "cat -vsc" ]]; then
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

        xdg-open ".vscode/"
        return
    elif [[ "$typeof" == "help" ]]; then
        _help
    elif [[ "$typeof" == "cat" ]]; then
        _help
    elif [[ -z "$typeof" ]]; then
        cmd
    else
        echo
        echo "    \$ $typeof - This typeof does not exist. Please try again.."
        sleep 2
        cmd
    fi
}

_start_this() {
    pkill -f "samp-server.exe"

    echo
    echo "Press any key to Start Your Server's . . ."
    read -n 1 -s

    _part
}

_part() {
    sleep 1
    xdg-open "samp-server.exe"

    sleep 2

    if ! pgrep -f "samp-server.exe" > /dev/null; then
        echo "samp-server.exe not found.."
        sleep 1
        xdg-open "https://sa-mp.app/"
        cmd
    elif [[ $? -eq 1 ]]; then
        echo
        echo "Status Starting...: [no]"
        echo "Server failed to run.."
        echo

        if [[ -f "server_log.txt" ]]; then
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

clears() {
    clear
}

_help() {
    _hash_
    echo "usage: cat [-c compile] [-r running server] [-ci compile-running] [-cls clear screen]"
    echo "      [-v laterium version] [-vsc vscode tasks]"
    cmd
}

_compiler_() {
    echo "Searching for .lat files..."

    laterium_pawncc_path=""
    for p in $(find "$search_dir" -name pawncc.exe); do
        if [[ -f "$p" ]]; then
            laterium_pawncc_path="$p"
            break
        fi
    done

    if [[ -z "$laterium_pawncc_path" ]]; then
        echo
        echo "pawncc.exe not found in any subdirectories."
        echo
        sleep 1
        xdg-open "https://github.com/pawn-lang/compiler/releases"
        cmd
    fi

    found_file=""
    for f in $(find "$search_dir" -name "*.lat"); do
        if [[ -f "$f" ]]; then
            found_file="$f"
            break
        fi
    done

    if [[ -z "$found_file" ]]; then
        echo "No .lat files found in: $search_dir"
        sleep 1
        cmd
    fi

    echo "Found file: $found_file"
    echo "Starting compilation..."
    echo

    output_file="${found_file%.lat}.amx"

    "$laterium_pawncc_path" "$found_file" -o"$output_file" -d0 > rus.txt 2>&1

    cat rus.txt

    if [[ -f "$output_file" ]]; then
        echo "Compilation $output_file...: [yes]"
        echo

        echo "Total Size $output_file / $(stat -c%s "$output_file") bytes"
    else
        echo "Compilation $output_file...: [no]"
    fi

    echo
}

_hash_() {
    compn="$USER@$HOSTNAME"
    hash=$(echo -n "$compn" | sha1sum | awk '{print $1}')
    echo "$compn | $hash"
}

cmd
