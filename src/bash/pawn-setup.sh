#!/bin/bash

# Set variables
katanaDir="$(pwd)"
katanaFile="${katanaDir}/system.ini"

# Function to display error message with zenity (GUI pop-up)
function show_error() {
    zenity --error --text="$1"
}

# Function to ask user input
function ask_input() {
    read -p "$1" input
    echo "$input"
}

# Start setup
while true; do
    echo "Starting setup: $(date)"

    # Ask for directory path input
    input=$(ask_input ":: Enter drive (Directory Path): > ")

    if [ -z "$input" ]; then
        show_error "[ERROR]: Directory path cannot be empty."
        continue
    fi

    # Ensure directory path ends with a slash
    if [[ ! "$input" =~ /$ ]]; then
        input="$input/"
    fi

    if [ ! -d "$input" ]; then
        show_error "[ERROR]: The specified directory does not exist."
        continue
    fi

    echo "Listing files in the directory: $input"
    ls "$input"

    # Ask for file name input
    input2=$(ask_input ":: Enter the name of the target file: > ")

    if [ -z "$input2" ]; then
        show_error "[ERROR]: File name cannot be empty."
        continue
    fi

    # Validate the file name for forbidden characters
    if [[ "$input2" == *"."* ]]; then
        show_error "[ERROR]: The file name should not contain a period."
        continue
    fi

    if [[ "$input2" == *"/"* ]] || [[ "$input2" == *"\"* ]] || [[ "$input2" == *"*"* ]] || [[ "$input2" == *","* ]] || [[ "$input2" == *";"* ]] || [[ "$input2" == *":"* ]]; then
        show_error "[ERROR]: The file name contains forbidden characters."
        continue
    fi

    # Check if file exists in the directory
    if [ -e "${input}${input2}.pwn" ]; then
        echo "Found ${input2}.pwn"
    elif [ -e "${input}${input2}.kn" ]; then
        echo "Found ${input2}.kn"
    elif [ -e "${input}${input2}.p" ]; then
        echo "Found ${input2}.p"
    else
        show_error "[ERROR]: No '.pwn' or '.p' or '.kn' file found for ${input2} in directory ${input}."
        continue
    fi

    # Create system.ini
    echo -e "[General]\n; no effect\nwin=\n\tx86,\n\tx64:\n; end\n\n[Settings]\ndrive=$input\ntarget=$input2\n; end" > "$katanaFile"
    
    echo "system.ini has been created at $katanaFile"

    # Ask to return to the next setup step
    read -p ":: Press any key to return . . ."
done
