:: How to Install?
:: Paste "batch.cmd" to path\your\gamemode.
:: Docs Command list : https://github.com/universestate/laterium/tree/main/doc

@echo off

setlocal enabledelayedexpansion
color 9
title Loading.. ^| Uptime Boot.
systeminfo | find "System Boot Time"
timeout /t 1 >nul
cls

set "_version_=12/19/2024 ^(B-14^)"
set "_SearchDir_=%~dp0"
set "_Settings_=%_SearchDir_%settings.ini

:_laterium_
 echo.
    echo    ooooo
    echo    `888'
    echo     888
    echo     888
    echo     888
    echo     888       o   %_version_%
    echo    o888ooooood8
    echo.

set time=%time%
set time=%time: =0%

title Type "help"
color 2

for /f "tokens=1-3 delims=:." %%a in ("%time%") do set mytime=%%a%%b.%%c

:cmd
set /p command="[%mytime%][%username%@%computername%] ~$ "

if "%command%"=="-b" (

    call :_builds_
        echo [System]*Press any key to return . . .
        pause >nul
    call :clears

) else if "%command%"=="-c" (

echo.
echo [System]*Compiling...
    call :_compiler_

) else if "%command%"=="-bc" (

    call :_builds_
    echo Press any key to open Compiler . . .
        pause >nul
            call :_compiler_

) else if "%command%"=="-r" (

    call :_part
    goto end

) else if "%command%"=="-cr" (

    call :_compiler_

    findstr /i "Error" rus.txt > nul
    if %errorlevel% equ 0 (
        echo    Error Status  ...  No
        goto _start_this
    ) else (
        echo    Error Status  ...  Yes
        goto end
    )

:_start_this
    taskkill /f /im "samp-server.exe" >nul 2>&1

        echo.
        echo Press any key to Start Your Server's . . .
            pause >nul
        :_part
        timeout /t 1 /nobreak
            start "" "samp-server.exe"
    
            timeout /t 2 >nul
    
            tasklist | find /i "samp-server.exe" >nul
    
            if not exist samp-server.exe (
                echo [Error]*samp-server.exe not found..
                timeout /t 1 >nul
                        start "" "https://sa-mp.app/"
                        echo [Out]*Exiting . .
                timeout /t 5
                exit
            )
            if errorlevel 1 (
                echo.
                echo    Status Starting .. No
                echo        Server failed to run..
                echo.

                if exist "server_log.txt" (=
                    start "" "notepad" "server_log.txt"
                ) else (
                    echo [System]*server_log.txt not found.
                )
            ) else (
                echo.
                echo    Status Starting .. Yes
                echo.
            )
    
    goto end

) else if "%command%"=="-ct" (

:clears
    cls
    goto _laterium_
    goto cmd

) else if "%command%"=="-v" (

    echo.
        echo    Laterium Version : %_version_%
    echo.
goto end

) else if "%command%"=="-vsc" (

    mkdir .vscode
        
    echo { > ".vscode\tasks.json"
        echo   "version": "2.0.0", > ".vscode\tasks.json"
        echo   "tasks": [ > ".vscode\tasks.json"
        echo     { > ".vscode\tasks.json"
        echo       "label": "Run Batch File", > ".vscode\tasks.json"
        echo       "type": "shell", > ".vscode\tasks.json"
        echo       "command": "${workspaceFolder}/batch.cmd", > ".vscode\tasks.json"
        echo       "group": { > ".vscode\tasks.json"
        echo           "kind": "build", > ".vscode\tasks.json"
        echo           "isDefault": true > ".vscode\tasks.json"
        echo       }, > ".vscode\tasks.json"
        echo       "problemMatcher": [], > ".vscode\tasks.json"
        echo       "detail": "Task to run the batch file" > ".vscode\tasks.json"
        echo     } > ".vscode\tasks.json"
        echo   ] > ".vscode\tasks.json"
    echo } > ".vscode\tasks.json"

    echo    Creating '.vscode\tasks.json' .. Yes

    start explorer ".vscode\"

    goto end

) else if "%command%"=="-st" (
:________back
    echo.
    echo [Warning]*Please use a Symbol "/" you can't use "\"
    set /p path_st="[%mytime%][%username%@%computername%]*Enter Batch Path > "

    echo { > "%APPDATA%\Sublime Text\Packages\User\terminal.sublime-build"
    echo    "cmd": ["batch.cmd", "-i includes", "$file", "-;+"], >> "%APPDATA%\Sublime Text\Packages\User\terminal.sublime-build"
    echo    "path": "!path_st!" >> "%APPDATA%\Sublime Text\Packages\User\terminal.sublime-build"
    echo } >> "%APPDATA%\Sublime Text\Packages\User\terminal.sublime-build"

    echo    Creating '%APPDATA%\Sublime Text\Packages\User\terminal.sublime-build' .. Yes

    start explorer "%APPDATA%\Sublime Text\Packages\User\"

    goto end

) else if "%command%"=="-mk" (

echo.
:___backs
    echo [System]*Input "end" for back to menu . .
    set /p dirs="[%mytime%][%username%@%computername%]*Enter Dir Name > "


    if "%dirs%"=="end" (
        call :clears
    ) else (
            mkdir !dirs!
        )
    
goto ___backs

) else if "%command%"=="git clone" (
    git clone https://github.com/universestate/laterium.git
    cd laterium
) else if "%command%"=="-dir" (

    dir

) else if "%command%"=="help" (
    :help
title %date%
    echo.
    echo [+] -b [build]
    echo [+] -c [compile]
    echo [+] -bc [build-compile]
    echo [+] -r [running server]
    echo [+] -cr [compile-running]
    echo [+] -ct [clear terminal]
    echo [+] -v [laterium version]
    echo [+] -vsc [vscode tasks]
    echo [+] -st [sublime text tools build]
    echo [+] -dir [directory list]
    echo [+] -mk [makedir]
    echo.
goto cmd
) else if "%command%"=="" (

    goto cmd

) else (

    echo.
        echo    $ %command% - This command does not exist. Please try again..
    timeout /t 2
        goto cmd

)

:end
echo [System]*Press any key to return . . .
pause >nul
goto cmd
goto :eof

:_compiler_
    if not exist "%_Settings_%" (
            echo [System]/settings.ini is required to determine the gamemode..
            timeout /t 1 >nul
            call _builds_
    )

    echo [System]/settings.ini found..

    set "laterium_path_gm="
    for /f "tokens=1,2 delims==" %%a in ('findstr /c:"drive=" "%_Settings_%"') do (
        if not "%%b"=="" (
            set "laterium_path_gm=%%b"
        )
    )
    
    if not defined laterium_path_gm (
        echo [System]*drive not found in settings.ini.
        timeout /t 1 >nul
        goto _builds_
    )

    set "laterium_path_file="
    for /f "tokens=1,2 delims==" %%a in ('findstr /c:"target=" "%_Settings_%"') do (
        if not "%%b"=="" (
            set "laterium_path_file=%%b"
        )
    )

    if not defined laterium_path_file (
        echo [System]*settings.ini is missing gamemode information.
        timeout /t 1 >nul
        
    )

    set "laterium_path_gm=%_SearchDir_%!laterium_path_gm!"

    if not exist "!laterium_path_gm!" (
        echo [System]*Gamemodes folder not found: !laterium_path_gm!.
            timeout /t 1 >nul
                start "" "https://sa-mp.app/"
            echo [Out]*Exiting . .
        timeout /t 5
        exit
    )

    set "laterium_pawncc_path="
    for /r "%_SearchDir_%" %%p in (pawncc.exe) do (
        if exist "%%p" (
            set "laterium_pawncc_path=%%p"
            goto f_pawncc
        )
    )

    :f_pawncc
    if not defined laterium_pawncc_path (
        echo.
            echo [System]*pawncc.exe not found in any subdirectories.
        echo.

        timeout /t 1 >nul
            start "" "https://github.com/pawn-lang/compiler/releases"
        echo [Out]*Exiting . .
            timeout /t 5
        exit
    )
    
    if exist "!laterium_path_gm!\!laterium_path_file!.pwn" (
        set "file_extension=.pwn"
    ) else if exist "!laterium_path_gm!\!laterium_path_file!.p" (
        set "file_extension=.p"
    ) else if exist "!laterium_path_gm!\!laterium_path_file!.lt" (
        set "file_extension=.lt"
    ) else (
        echo [ERROR]*The file "!laterium_path_file!" with extensions .pwn, .p, or .lt not found in: "!laterium_path_gm!"
        timeout /t 1 >nul
        goto _builds_
    )

    echo    [ !laterium_path_file!!file_extension! ] [ !laterium_pawncc_path! ] [ !laterium_path_gm! ]
    echo.

    echo Found file: !laterium_path_file!!!
    echo Starting compilation..
    echo.

    "!laterium_pawncc_path!" "!laterium_path_gm!\!laterium_path_file!!file_extension!" -o"!laterium_path_gm!\!laterium_path_file!.amx" -d0 > rus.txt :: please see: https://github.com/universestate/laterium#:~:text=%2DA%3Cnum%3E%20alignment,with%20value%200

    if exist "!laterium_path_gm!\!laterium_path_file!.amx" (
        echo    Compilation !laterium_path_file!.amx .. Yes
        echo.

        for %%A in ("!laterium_path_gm!\!laterium_path_file!.amx") do (
            echo    Total Size !laterium_path_file!.amx / %%~zA bytes
        )
    ) else (
        echo    Compilation !laterium_path_file!!file_extension! .. No
    )

    echo.

goto :eof
:_builds_
    :text
    echo.
    echo           *** S E T U P ***
    
    :____menus____
    set /p input="[%mytime%][System]*Enter drive > "

set input=%input%
set input=%input: =0%

    if not "!input:~-1!"=="\" set "input=!input!\"

    if not exist "!input!" (
        echo [ERROR]*The specified directory '!input!' does not exist." > "%tmp%\tmp.vbs
        goto ____menus____
    )

    echo [System]*Found =^> !input!

    echo.
    echo [Dir]*Listing files in the directory:
    echo.
    dir /b "!input!"

:____back
    echo.
    echo [System]*Input "back" back to build . .
    echo [System]*Input "end" back to menu . .
    set /p inputs="[%mytime%][System]*Enter target > "

set inputs=%inputs%
set inputs=%inputs: =0%

    if "%inputs%"=="back" (
        cls
        echo.
        echo           *** B A C K ***
        echo. 
        goto ____menus____
    ) else if "%inputs%"=="end" (
        call :clears
    )

    echo "!inputs!" | findstr /r "\." >nul
    if not errorlevel 1 (
        echo.
        echo [ERROR]*The file name should not contain a period '.'
        goto ____back
    )

    if exist "!input!\!inputs!.pwn" ( echo [System]*Found =^> !inputs!.pwn ) else if exist "!input!\!inputs!.p" ( echo [System]*Found =^> !inputs!.p ) else if exist "!input!\!inputs!.lt" ( echo [System]*Found =^> !inputs!.lt ) else (
            echo :: [ERROR]*"!input!" =^> "!inputs!.pwn - !inputs!.p - !inputs!.lt" not found..
        goto ____back
    )

    echo.
    echo    Creating '!_Settings_!' .. Yes
    echo.
    echo [System]*Succes Creating =^> settings.ini ...
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
    ) > "%_Settings_%"

    echo.
    echo    End Status .. Yes
    echo.
