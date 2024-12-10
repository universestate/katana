:: @start
@echo off

:: CMYK color.
color c

:: title for label Caption Terminal.
title %date%

:: Delayed Variable Expansion.
setlocal enabledelayedexpansion

echo.
echo Starting %date% %time%
echo.

:: set variable.
set "katanaDir=%~dp0"
set "katanaFile=%katanaDir%system.ini"

:next
if not exist "%katanaFile%" (
echo :: system.ini is required to determine the gamemode..
    start "" "pawn-setup.cmd"
        echo.
            echo ; Go out...
        timeout /t 5
    exit
)

echo :: system.ini found..
echo.

set "katana_path_file="
for /f "tokens=1,2 delims==" %%a in ('findstr /c:"target=" "%katanaFile%"') do (
    if not "%%b"=="" (
        set "katana_path_file=%%b"
    )
)

if not defined katana_path_file (
    echo :: system.ini is missing gamemode information.
        timeout /t 5
    exit
)

echo -- target: !katana_path_file!

set "katana_path_gm="
for /f "tokens=1,2 delims==" %%a in ('findstr /c:"drive=" "%katanaFile%"') do (
    if not "%%b"=="" (
        set "katana_path_gm=%%b"
    )
)

if not defined katana_path_gm (
    echo :: drive not found in system.ini.
        timeout /t 5
    exit
)

echo -- drive: !katana_path_gm!

set "katana_path_gm=%katanaDir%!katana_path_gm!"

if not exist "!katana_path_gm!" (
    echo :: Gamemodes folder not found: !katana_path_gm!.
        timeout /t 5
    exit
)

set "katana_pawncc_path="
for /r "%katanaDir%" %%p in (pawncc.exe) do (
    if exist "%%p" (
        set "katana_pawncc_path=%%p"
        goto found_pawncc
    )
)

:found_pawncc
if not defined katana_pawncc_path (
    echo :: pawncc.exe not found in any subdirectories.
        pause
    exit /b
)

if exist "!katana_path_gm!\!katana_path_file!.pwn" ( set "file_extension=.pwn" ) else if exist "!katana_path_gm!\!katana_path_file.kn" ( set "file_extension=.kn" ) else if exist "!katana_path_gm!\!katana_path_file!.p" ( set "file_extension=.p" ) else (
    echo :: [ERROR]: No '.pwn' or '.p' =^> !katana_path_file! in drive "!katana_path_gm!"
        pause
    exit /b
)

echo Found file: !katana_path_file!!file_extension!
    echo Starting compilation...

"!katana_pawncc_path!" "!katana_path_gm!\!katana_path_file!!file_extension!" -o"!katana_path_gm!\!katana_path_file!.amx" :: docs, please see: https://github.com/universestate/katana/tree/main/docs#:~:text=2%20hours%20ago-,README.md,-Update%20README.md

if exist "!katana_path_gm!\!katana_path_file!.amx" (
echo Compilation successful: !katana_path_file!.amx created in the folder.
echo.
    for %%A in ("!katana_path_gm!\!katana_path_file!.amx") do ( echo :: Size of !katana_path_file!.amx: %%~zA bytes )
) else ( echo :: ^(failed^): Compilation failed for !katana_path_file!.. )
echo.

echo :: Press any key to return . . .
pause >nul

goto next
