#!/bin/bash

_version_="2024.x21 (B-14)"
_SearchDir_=$(dirname "$0")

_laterium_() {
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

_laterium_

newtime=$(date +%H%M.%S)

cmd() {
    read -p "$USER@$HOSTNAME~$ " typeof

    if [ "$typeof" == "cat -c" ]; then
        echo
        echo "Compiling..."
        _compiler_
    elif [ "$typeof" == "cat -r" ]; then
        _part
        end
    elif [ "$typeof" == "cat -ci" ]; then
        _compiler_

        if grep -iq "error" rus.txt; then
            echo "Errorlevel is: $?"
            echo "Error Status...: [yes]"
            end
        else
            echo "Errorlevel is: $?"
            echo "Error Status...: [no]"
            _start_this
        fi
    elif [ "$typeof" == "cat -cls" ]; then
        clears
    elif [ "$typeof" == "cat -v" ]; then
        echo
        echo "    Laterium Version : $_version_"
        echo
        end
    elif [ "$typeof" == "cat -vsc" ]; then
        mkdir -p .vscode
        cat <<EOF > .vscode/tasks.json
{
  "version": "2.0.0",
  "tasks": [
    {
      "label": "Run Bash Script",
      "type": "shell",
      "command": "\${workspaceFolder}/windows.sh",
      "group": {
        "kind": "build",
        "isDefault": true
      },
      "problemMatcher": [],
      "detail": "Task to run the bash script."
    }
  ]
}
EOF
        echo "Creating '.vscode/tasks.json'...: [yes]"
        xdg-open .vscode/
        end
    elif [ "$typeof" == "help" ]; then
        _help
    elif [ "$typeof" == "cat" ]; then
        _help
    elif [ -z "$typeof" ]; then
        cmd
    else
        echo
        echo "    $typeof - This typeof does not exist. Please try again.."
        sleep 2
        cmd
    fi
}

end() {
    echo "Press any key to return . . ."
    read -n 1
    cmd
}

_compiler_() {
    echo "Searching for .lat files..."

    laterium_pawncc_path=$(find "$_SearchDir_" -name pawncc -type f | head -n 1)
    if [ -z "$laterium_pawncc_path" ]; then
        echo
        echo "pawncc not found in any subdirectories."
        echo
        sleep 1
        xdg-open https://github.com/pawn-lang/compiler/releases
        cmd
    fi

    find "$_SearchDir_" -name "*.lat.pwn*" -type f | while read -r file; do
        echo "Found file: $file"
        echo "Starting compilation.."
        echo

        output_file="${file%.lat}.amx"
        "$laterium_pawncc_path" "$file" -o"$output_file" -d0 > rus.txt 2>&1

        cat rus.txt

        if [ -e "$output_file" ]; then
            echo "Compilation $output_file...: [yes]"
            echo
            echo "Total Size $output_file / $(stat -c%s "$output_file") bytes"
        else
            echo "Compilation $output_file...: [no]"
        fi
        echo
    done
}

_start_this() {
    pkill -f samp-server

    echo
    echo "Press any key to Start Your Server's . . ."
    read -n 1
    _part
}

_part() {
    sleep 1
    nohup ./samp-server &

    sleep 2

    if ! pgrep -f samp-server > /dev/null; then
        echo "samp-server not found.."
        sleep 1
        xdg-open https://sa-mp.app/
        cmd
    fi

    if ! pgrep -f samp-server > /dev/null; then
        echo
        echo "Status Starting...: [no]"
        echo "Server failed to run.."
        echo

        if [ -e "server_log.txt" ]; then
            xdg-open server_log.txt
        else
            echo "server_log.txt not found."
        fi
    else
        echo
        echo "Status Starting... [yes]"
        echo
    fi
    end
}

_help() {
    _hash_
    echo "usage: cat [-c compile] [-r running server] [-ci compile-running] [-cls clear screen]"
    echo "      [-v laterium version] [-vsc vscode tasks]"
    cmd
}

_hash_() {
    compn="$USER@$HOSTNAME"
    hash=$(echo -n "$compn" | sha1sum | awk '{print $1}')
    echo "title $compn | $hash"
}

cmd
