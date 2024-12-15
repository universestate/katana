:: -A<num>  alignment in bytes of the data segment and the stack
:: -a       output assembler code
:: -C[+/-]  compact encoding for output file (default=+)
:: -c<name> codepage name or number; e.g. 1252 for Windows Latin-1
:: -Dpath   active directory path
:: -d<num>  debugging level (default=-d1)
::     0    no symbolic information, no run-time checks
::     1    run-time checks, no symbolic information
::     2    full debug information and dynamic checking
::     3    same as -d2, but implies -O0
:: -e<name> set name of error file (quiet compile)
:: -H<hwnd> window handle to send a notification message on finish
:: -i<name> path for include files
:: -l       create list file (preprocess only)
:: -o<name> set base name of (P-code) output file
:: -O<num>  optimization level (default=-O1)
::     0    no optimization
::     1    JIT-compatible optimizations only
::     2    full optimizations
:: -p<name> set name of "prefix" file
:: -r[name] write cross reference report to console or to specified file
:: -S<num>  stack/heap size in cells (default=4096)
:: -s<num>  skip lines from the input file
:: -t<num>  TAB indent size (in character positions, default=8)
:: -v<num>  verbosity level; 0=quiet, 1=normal, 2=verbose (default=1)
:: -w<num>  disable a specific warning by its number
:: -X<num>  abstract machine size limit in bytes
:: -XD<num> abstract machine data/stack size limit in bytes
:: -\       use '\' for escape characters
:: -^       use '^' for escape characters
:: -;[+/-]  require a semicolon to end each statement (default=-)
:: -([+/-]  require parantheses for function invocation (default=-)
:: sym=val  define constant "sym" with value "val"
:: sym=     define constant "sym" with value 0

@echo off

color c
title %date%
setlocal enabledelayedexpansion

echo.
echo Starting %date% %time%
echo.

set "SysSearchDir=%~dp0"
set "SysSettings=%SysSearchDir%settings.ini"

:mains
if not exist "%SysSettings%" (
    echo [System]/settings.ini is required to determine the gamemode..
    timeout /t 1 >nul
    
:builds
    :text
    echo.
    echo           *** S E T U P ***

    :menu        
    echo. 
        echo [Time]/Starting %date% %time%

    :next
    echo.
    for /f "tokens=1-3 delims=:" %%a in ("%time%") do set mytime=%%a%%b%%c
    set /p input="[%mytime%][System]/Enter drive: > "


    if "%input%"=="" (
            echo msgbox "[ERROR]/Directory path cannot be empty." > "%tmp%\tmp.vbs"
                cscript /nologo "%tmp%\tmp.vbs"
                    del "%tmp%\tmp.vbs"
        goto next
    )

    if not "!input:~-1!"=="\" set "input=!input!\"

    if not exist "!input!" (
            echo msgbox "[ERROR]/The specified directory '!input!' does not exist." > "%tmp%\tmp.vbs"
                cscript /nologo "%tmp%\tmp.vbs"
                    del "%tmp%\tmp.vbs"
        goto next
    )

    echo [System]/Found =^> !input!

    echo.
    echo [Dir]/Listing files in the directory:
    echo.
    dir /b "!input!"

    :back
    echo.
    echo [System]/Input "back" for back to main build . .
    echo [System]/Input "end" for back to main menu . .

    for /f "tokens=1-3 delims=:" %%a in ("%time%") do set mytime=%%a%%b%%c
    set /p inputs="[%mytime%][System]/Enter target: > "

    if "%inputs%"=="" (
        echo msgbox "[ERROR]/File name cannot be empty." > "%tmp%\tmp.vbs"
                cscript /nologo "%tmp%\tmp.vbs"
            del "%tmp%\tmp.vbs"
        goto back
    ) else if "%inputs%"=="back" (
        cls
        goto text
        goto menu
    ) else if "%inputs%"=="end" (
        goto mains
    )

    echo "!inputs!" | findstr /r "\." >nul
    if not errorlevel 1 (
        echo msgbox "[ERROR]/The file name should not contain a period (.)" > "%tmp%\tmp.vbs"
                cscript /nologo "%tmp%\tmp.vbs"
            del "%tmp%\tmp.vbs"
        goto back
    )

    if exist "!input!\!inputs!.pwn" ( echo [System]/Found =^> !inputs!.pwn ) else if exist "!input!\!inputs!.p" ( echo [System]/Found =^> !inputs!.p ) else if exist "!input!\!inputs!.kn" ( echo [System]/Found =^> !inputs!.kn ) else (
            echo :: [ERROR]/"!input!" =^> "!inputs!.pwn - !inputs!.p - !inputs!.kn" not found..
        goto back
    )
    echo.
    echo           *** S U C C E S ***
    echo.
    echo [System]/Succes Creating =^> settings.ini ...
    (
        echo [General]
            echo ; no effect
                echo win= 
                    echo    x86,
                        echo        x64:
                            echo ; end
                        echo.
                    echo [Setup]
                echo drive=!input!
            echo    target=!inputs!
        echo ; end
    ) > "%SysSettings%"

    echo.
    echo           *** E N D ***
    echo.

    echo [System]/Press any key to back . . .
    pause >nul
cls
    goto mains
    goto :eof
)

echo [System]/settings.ini found..
echo.

set "katana_path_file="
for /f "tokens=1,2 delims==" %%a in ('findstr /c:"target=" "%SysSettings%"') do (
    if not "%%b"=="" (
        set "katana_path_file=%%b"
    )
)

if not defined katana_path_file (
    echo [System]/settings.ini is missing gamemode information.
    timeout /t 1 >nul
    
)

echo           *** T A R G E T *** -^> !katana_path_file!

set "katana_path_gm="
for /f "tokens=1,2 delims==" %%a in ('findstr /c:"drive=" "%SysSettings%"') do (
    if not "%%b"=="" (
        set "katana_path_gm=%%b"
    )
)

if not defined katana_path_gm (
    echo [System]/drive not found in settings.ini.
    timeout /t 1 >nul
    goto builds
)

echo           *** D R I V E *** -^> !katana_path_gm!
echo.

set "katana_path_gm=%SysSearchDir%!katana_path_gm!"

if not exist "!katana_path_gm!" (
    echo [System]/Gamemodes folder not found: !katana_path_gm!.
        timeout /t 1 >nul
            start "" "https://www.sa-mp.mp/downloads/"
        echo [Out]/Exiting . .
    timeout /t 5
    exit
)

set "katana_pawncc_path="
for /r "%SysSearchDir%" %%p in (pawncc.exe) do (
    if exist "%%p" (
        set "katana_pawncc_path=%%p"
        goto f_pawncc
    )
)

:f_pawncc
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
) else if exist "!katana_path_gm!\!katana_path_file!.p" (
     set "file_extension=.p"
    ) else if exist "!katana_path_gm!\!katana_path_file!.kn" (
        set "file_extension=.kn" 
) else (
    echo [ERROR]/"!katana_path_gm!" =^> "!katana_path_file!.pwn - !katana_path_file!.p - !katana_path_file!.kn" not found..
    timeout /t 1 >nul
    goto builds
)

echo Found file: !katana_path_file!!!
echo Starting compilation..
echo.

"!katana_pawncc_path!" "!katana_path_gm!\!katana_path_file!!file_extension!" -o"!katana_path_gm!\!katana_path_file!.amx"

if exist "!katana_path_gm!\!katana_path_file!.amx" (
    echo [Katana]/Compilation successful: !katana_path_file!.amx created in the folder.
    echo.
for %%A in ("!katana_path_gm!\!katana_path_file!.amx") do (
        echo [Result]/Result-of !katana_path_file!.amx: %%~zA bytes
    )
) else (
    echo [Fail]/Compilation failed for !katana_path_file!!file_extension!..
)
echo.

echo [System]/Press any key to return . . .
pause >nul

goto mains
goto :eof
