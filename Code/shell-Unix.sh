#!/bin/bash

set -e

_version_="2024.x21 (B-14)"
_SearchDir_="$(dirname "$0")"

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

newtime=$(date +"%H%M.%S")

cmd() {
  read -p "$USER@$(hostname)~$ " typeof

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
      echo
      ;;
    "cat -vsc")
      mkdir -p .vscode
      cat << EOF > .vscode/tasks.json
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
EOF
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
      cmd
      ;;
    *)
      echo
      echo "    $typeof - This typeof does not exist. Please try again.."
      sleep 2
      cmd
      ;;
  esac
}

_start_this() {
  pkill -f samp-server.exe || true
  echo
  echo "Press any key to Start Your Server's . . ."
  read -n 1 -s
  _part
}

_part() {
  sleep 1
  ./samp-server.exe &

  sleep 2

  if ! pgrep -f samp-server.exe > /dev/null; then
    echo "samp-server.exe not found.."
    sleep 1
    xdg-open "https://sa-mp.app/"
    cmd
  fi

  if ! pgrep -f samp-server.exe > /dev/null; then
    echo
    echo "Status Starting...: [no]"
    echo "Server failed to run.."
    echo

    if [[ -f "server_log.txt" ]]; then
      xdg-open server_log.txt
    else
      echo "server_log.txt not found."
    fi
  else
    echo
    echo "Status Starting...: [yes]"
    echo
  fi
}

_compiler_() {
  echo "Searching for .lat files..."

  laterium_pawncc_path=""
  while IFS= read -r -d '' file; do
    if [[ -x "$file" ]]; then
      laterium_pawncc_path="$file"
      break
    fi
  done < <(find "$_SearchDir_" -name "pawncc.exe" -print0)

  if [[ -z "$laterium_pawncc_path" ]]; then
    echo
    echo "pawncc.exe not found in any subdirectories."
    echo
    sleep 1
    xdg-open "https://github.com/pawn-lang/compiler/releases"
    cmd
  fi

  while IFS= read -r -d '' file; do
    if [[ -f "$file" ]]; then
      echo "Found file: $file"
      echo "Starting compilation.."
      echo

      output_file="${file%.lat}.amx"

      "$laterium_pawncc_path" "$file" -o"$output_file" -d0 > rus.txt 2>&1

      cat rus.txt

      if [[ -f "$output_file" ]]; then
        echo "Compilation $output_file!...: [yes]"
        echo

        echo "Total Size $output_file / $(stat -c%s "$output_file") bytes"
      else
        echo "Compilation $output_file!...: [no]"
      fi

      echo
    fi
  done < <(find "$_SearchDir_" -name "*.lat" -print0)
}

_help() {
  _hash_
  echo "usage: cat [-c compile] [-r running server] [-ci compile-running] [-cls clear screen]"
  echo "      [-v laterium version] [-vsc vscode tasks]"
  cmd
}

_hash_() {
  compn="$USER@$(hostname)"
  hash=$(echo -n "$compn" | sha1sum | awk '{print $1}')
  PS1="$compn | $hash"
}

cmd
