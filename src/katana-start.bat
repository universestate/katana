:: Katana - Start.

:: Copyright (c) Katana
:: Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the “Software”), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:
:: The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.
:: THE SOFTWARE IS PROVIDED “AS IS”, WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

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
set "SystemExDir=%~dp0"
set "SystemFile=%SystemExDir%system.ini"

:next
if not exist "%SystemFile%" (
    echo :: system.ini is required to determine the gamemode..

start "" "katana-setup.bat"
    echo.
    echo ; Go out...
    timeout /t 5
    exit
)

echo :: system.ini found..
echo.

set "katana_path_file="
for /f "tokens=1,2 delims==" %%a in ('findstr /c:"target=" "%SystemFile%"') do (
    if not "%%b"=="" (
        set "katana_path_file=%%b"
    )
)

if not defined katana_path_file (
    echo :: system.ini is missing gamemode information.
    timeout /t 5
    exit
)

echo -- target gamemode: !katana_path_file!

set "katana_path_gm="
for /f "tokens=1,2 delims==" %%a in ('findstr /c:"drive=" "%SystemFile%"') do (
    if not "%%b"=="" (
        set "katana_path_gm=%%b"
    )
)

if not defined katana_path_gm (
    echo :: drive not found in system.ini.
    timeout /t 5
    exit
)

echo Gamemodes folder: !katana_path_gm!

set "katana_path_gm=%SystemExDir%!katana_path_gm!"

if not exist "!katana_path_gm!" (
    echo :: Gamemodes folder not found: !katana_path_gm!.
    timeout /t 5
    exit
)

set "katana_pawncc_path="
for /r "%SystemExDir%" %%p in (pawncc.exe) do (
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

if exist "!katana_path_gm!\!katana_path_file!.pwn" (
    set "file_extension=.pwn"
) else if exist "!katana_path_gm!\!katana_path_file!.p" (
    set "file_extension=.p"
) else (
echo :: No .pwn, .p file found for gamemode !katana_path_file!..
echo :: The required .pwn, .p file for gamemode was not found.
    pause
    exit /b
)

echo Found file: !katana_path_file!!file_extension!
echo Starting compilation...

"!katana_pawncc_path!" "!katana_path_gm!\!katana_path_file!!file_extension!" -o"!katana_path_gm!\!katana_path_file!.amx"

if exist "!katana_path_gm!\!katana_path_file!.amx" (
echo Compilation successful: !katana_path_file!.amx created in the folder.
echo.
    for %%A in ("!katana_path_gm!\!katana_path_file!.pwn") do ( echo :: Size of !katana_path_file!.pwn: %%~zA bytes )
    for %%A in ("!katana_path_gm!\!katana_path_file!.amx") do ( echo :: Size of !katana_path_file!.amx: %%~zA bytes )
) else (
echo :: Compilation failed for !katana_path_file!..
)
echo.

echo :: Press any key to return . . .
pause >nul

goto next
