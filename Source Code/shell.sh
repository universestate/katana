#!/bin/bash

_version_="2024.x21 (B-14)"
_SearchDir_="$(pwd)"

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
    read -p "$USER@$HOSTNAME~$ " typeof

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
            if grep -iq "error" rus.txt; then
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
            cat <<EOT > .vscode/tasks.json
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
EOT
            echo "Creating '.vscode/tasks.json'...: [yes]"
            xdg-open .vscode
            ;;
        "help")
            _help
            ;;
        "cat")
            _help
            ;;
        *)
            echo
            echo "    \$ $typeof - This typeof does not exist. Please try again.."
            sleep 2
            ;;
    esac
    cmd
}

_start_this() {
    pkill -f "samp-server"
    echo
    echo "Press any key to Start Your Server's . . ."
    read -n 1 -s
    _part
}

_part() {
    sleep 1
    ./samp-server &

    sleep 2

    if ! pgrep -f "samp-server" > /dev/null; then
        echo "samp-server.exe not found.."
        sleep 1
        xdg-open "https://sa-mp.app/"
    fi
}

_compiler_() {
    echo "Searching for .lat files..."

    laterium_pawncc_path=""
    for pawncc in $(find "$_SearchDir_" -name "pawncc.exe"); do
        if [[ -f "$pawncc" ]]; then
            laterium_pawncc_path="$pawncc"
            break
        fi
    done

    if [[ -z "$laterium_pawncc_path" ]]; then
        echo
        echo "pawncc.exe not found in any subdirectories."
        echo
        sleep 1
        xdg-open "https://github.com/pawn-lang/compiler/releases"
        return
    fi

    for file in $(find "$_SearchDir_" -name "*.lat*"); do
        if [[ -f "$file" ]]; then
            echo "Found file: $file"
            echo "Starting compilation.."
            echo

            output_file="${file%.*}.amx"

            "$laterium_pawncc_path" "$file" -o"$output_file" -d0 > rus.txt 2>&1

            cat rus.txt

            if [[ -f "$output_file" ]]; then
                echo "Compilation $output_file...: [yes]"
                echo
                echo "Total Size $output_file / $(stat -c %s "$output_file") bytes"
            else
                echo "Compilation $output_file...: [no]"
            fi

            echo
        fi
    done
}

_help() {
    _hash_

    echo "usage: cat [-c compile] [-r running server] [-ci compile-running] [-cls clear screen]"
    echo "      [-v laterium version] [-vsc vscode tasks]"
}

_hash_() {
    compn="$USER@$HOSTNAME"
    hash=$(echo -n "$compn" | sha1sum | awk '{print $1}')
    echo -ne "\033]0;$compn | $hash\007"
}

cmd
