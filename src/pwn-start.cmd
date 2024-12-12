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

:mains
if not exist "%SystemKN%" (
    echo [System]/settings.ini is required to determine the gamemode..
    timeout /t 1 >nul
    
:builds
    :text
    echo.
    echo            S E T U P

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
    echo            D O N E
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
    ) > "%SystemKN%"

    echo.
    echo            E N D
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
for /f "tokens=1,2 delims==" %%a in ('findstr /c:"target=" "%SystemKN%"') do (
    if not "%%b"=="" (
        set "katana_path_file=%%b"
    )
)

if not defined katana_path_file (
    echo [System]/settings.ini is missing gamemode information.
    timeout /t 1 >nul
    
)

echo              T A R G E T -^> !katana_path_file!

set "katana_path_gm="
for /f "tokens=1,2 delims==" %%a in ('findstr /c:"drive=" "%SystemKN%"') do (
    if not "%%b"=="" (
        set "katana_path_gm=%%b"
    )
)

if not defined katana_path_gm (
    echo [System]/drive not found in settings.ini.
    timeout /t 1 >nul
    goto builds
)

echo              D R I V E -^> !katana_path_gm!
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
        echo [Result]/Size-of !katana_path_file!.amx: %%~zA bytes
    )
) else (
    echo [Fail]/Compilation failed for !katana_path_file!!file_extension!..
)
echo.

echo [System]/Press any key to return . . .
pause >nul

goto mains
goto :eof
