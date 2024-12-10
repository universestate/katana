#!/bin/bash

# Set directory and file paths
katanaDir="$(pwd)"
katanaFile="${katanaDir}/system.ini"

# Function to display error messages
function show_error() {
    echo "$1"  # Print error message to the terminal
    sleep 5    # Wait for 5 seconds
    exit 1     # Exit the script with error
}

# Function to wait for user input (like `pause` in Batch)
function wait_for_key() {
    echo ":: Press any key to continue . . ."
    read -n 1 -s -r  # Wait for a single key press
}

echo -e "\nStarting $(date)\n"

# Check if system.ini exists
if [ ! -f "$katanaFile" ]; then
    echo ":: system.ini is required to determine the gamemode..."
    ./pawn-setup.sh  # Assuming this is another script to set up
    wait_for_key
    exit 1
fi

echo ":: system.ini found..\n"

# Read "target" value from system.ini
katana_path_file=$(grep -m 1 "^target=" "$katanaFile" | cut -d '=' -f2)
if [ -z "$katana_path_file" ]; then
    show_error ":: system.ini is missing gamemode information."
fi

echo "-- target: $katana_path_file"

# Read "drive" value from system.ini
katana_path_gm=$(grep -m 1 "^drive=" "$katanaFile" | cut -d '=' -f2)
if [ -z "$katana_path_gm" ]; then
    show_error ":: drive not found in system.ini."
fi

echo "-- drive: $katana_path_gm"

# Combine paths to the full game mode directory
katana_path_gm="$katanaDir$katana_path_gm"

if [ ! -d "$katana_path_gm" ]; then
    show_error ":: Gamemodes folder not found: $katana_path_gm."
fi

# Look for the pawncc compiler (assumes pawncc is in one of the subdirectories)
katana_pawncc_path=$(find "$katanaDir" -type f -name "pawncc" | head -n 1)

if [ -z "$katana_pawncc_path" ]; then
    show_error ":: pawncc not found in any subdirectories."
fi

# Check if the gamemode file exists in one of the supported formats
if [ -f "$katana_path_gm/$katana_path_file.pwn" ]; then
    file_extension=".pwn"
elif [ -f "$katana_path_gm/$katana_path_file.kn" ]; then
    file_extension=".kn"
elif [ -f "$katana_path_gm/$katana_path_file.p" ]; then
    file_extension=".p"
else
    show_error ":: No '.pwn', '.p' or '.kn' found for $katana_path_file in folder $katana_path_gm."
fi

echo "Found file: $katana_path_file$file_extension"
echo "Starting compilation..."

# Compile the Pawn file using pawncc
"$katana_pawncc_path" "$katana_path_gm/$katana_path_file$file_extension" -o"$katana_path_gm/$katana_path_file.amx"

# Check if compilation was successful
if [ -f "$katana_path_gm/$katana_path_file.amx" ]; then
    echo "Compilation successful: $katana_path_file.amx created in the folder."
    # Output file size
    file_size=$(stat -c %s "$katana_path_gm/$katana_path_file.amx")
    echo ":: Size of $katana_path_file.amx: $file_size bytes"
else
    echo ":: (failed): Compilation failed for $katana_path_file.."
fi

echo ""
wait_for_key
