:: GNU 2.0
@echo off

color c
title %date%
setlocal enabledelayedexpansion

echo.
echo Starting %date% %time%
echo.

set "DirectoryKN=%~dp0"
set "SystemKN=%DirectoryKN%settings.ini"

:next
if not exist "%SystemKN%" (
    echo [System]/settings.ini is required to determine the gamemode..
    timeout /t 1 >nul
    start "" "pwn-build.cmd"
    echo.
    echo [Out]/Exiting . .
    timeout /t 5
    exit
)

echo [System]/settings.ini found..
echo.

set "katana_path_file="
for /f "tokens=1,2 delims==" %%a in ('findstr /c:"target=" "%SystemKN%"') do (
    if not "%%b"=="" (
        set "katana_path_file=%%b"
    )
)

if not defined katana_path_file (
    echo [System]/settings.ini is missing gamemode information.
    timeout /t 1 >nul
    start "" "pwn-build.cmd"
    echo.
    echo [Out]/Exiting . .
    timeout /t 5
    exit
)

echo        T A R G E T =^> !katana_path_file!

set "katana_path_gm="
for /f "tokens=1,2 delims==" %%a in ('findstr /c:"drive=" "%SystemKN%"') do (
    if not "%%b"=="" (
        set "katana_path_gm=%%b"
    )
)

if not defined katana_path_gm (
    echo [System]/drive not found in settings.ini.
    timeout /t 1 >nul
    start "" "pwn-build.cmd"
    echo.
    echo [Out]/Exiting . .
    timeout /t 5
    exit
)

echo        D R I V E =^> !katana_path_gm!
echo.

set "katana_path_gm=%DirectoryKN%!katana_path_gm!"

if not exist "!katana_path_gm!" (
    echo [System]/Gamemodes folder not found: !katana_path_gm!.
    timeout /t 1 >nul
    start "" "https://www.sa-mp.mp/downloads/"
    echo [Out]/Exiting . .
    timeout /t 5
    exit
)

set "katana_pawncc_path="
for /r "%DirectoryKN%" %%p in (pawncc.exe) do (
    if exist "%%p" (
        set "katana_pawncc_path=%%p"
        goto found_pawncc
    )
)

:found_pawncc
if not defined katana_pawncc_path (
    echo.
    echo [System]/pawncc.exe not found in any subdirectories.
    echo.
    timeout /t 1 >nul
    start "" "https://github.com/pawn-lang/compiler/releases"
    echo [Out]/Exiting . .
    timeout /t 5
    exit
)

if exist "!katana_path_gm!\!katana_path_file!.pwn" (
    set "file_extension=.pwn"
) else if exist "!katana_path_gm!\!katana_path_file!.kn" (
     set "file_extension=.kn"
    ) else if exist "!katana_path_gm!\!katana_path_file!.p" (
        set "file_extension=.p" 
) else (
    echo [ERROR]/"!katana_path_gm!" =^> "!katana_path_file!.pwn - !katana_path_file!.p - !katana_path_file!.kn" not found..
    timeout /t 1 >nul
    start "" "pwn-build.cmd"
    echo.
    echo [Out]/Exiting . .
    timeout /t 5
    exit
)

echo Found file: !katana_path_file!!file_extension!
echo Starting compilation..
echo.

"!katana_pawncc_path!" "!katana_path_gm!\!katana_path_file!!file_extension!" -o"!katana_path_gm!\!katana_path_file!.amx"

if exist "!katana_path_gm!\!katana_path_file!.amx" (
    echo [Katana]/Compilation successful: !katana_path_file!.amx created in the folder.
    echo.
    for %%A in ("!katana_path_gm!\!katana_path_file!.amx") do (
        echo [Result]/Size-of !katana_path_file!.amx: %%~zA bytes
    )
) else (
    echo [Fail]/Compilation failed for !katana_path_file!..
)
echo.

echo [System]/Press any key to return . . .
pause >nul

goto next
goto :eof
