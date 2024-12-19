@echo off

setlocal enabledelayedexpansion

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

title type `help` to get Started

for /f "tokens=1-3 delims=:." %%a in ("%time%") do set newtime=%%a%%b.%%c

:cmd
set /p typeof="[%newtime%][%username%@%computername%] ~$ "

if "%typeof%"=="-b" (

    call :_builds_
        echo Press any key to return . . .
        pause >nul
    call :clears

) else if "%typeof%"=="-c" (

echo.
echo Compiling...
    call :_compiler_

) else if "%typeof%"=="-bc" (

    call :_builds_
    echo Press any key to open Compiler . . .
        pause >nul
            call :_compiler_

) else if "%typeof%"=="-r" (

    call :_part
    goto end

) else if "%typeof%"=="-cr" (

    call :_compiler_

    findstr /i "Error" rus.txt > nul
    if %errorlevel% equ 0 (
        echo Error Status...:  [no]
        goto _start_this
    ) else (
        echo Error Status...: [yes]
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
                echo samp-server.exe not found..
                timeout /t 1 >nul
                        start "" "https://sa-mp.app/"
		goto cmd
            )
            if errorlevel 1 (
                echo.
                echo Status Starting...: [no]
                echo Server failed to run..
                echo.

                if exist "server_log.txt" (=
                    start "" "notepad" "server_log.txt"
                ) else (
                    echo server_log.txt not found.
                )
            ) else (
                echo.
                echo Status Starting... [yes]
                echo.
            )
    
    goto end

) else if "%typeof%"=="-cls" (

:clears
    cls
    goto _laterium_
    goto cmd

) else if "%typeof%"=="-v" (

    echo.
        echo    Laterium Version : %_version_%
    echo.
goto end

) else if "%typeof%"=="-vsc" (

    mkdir .vscode
        
    echo { > ".vscode\tasks.json"
        echo   "version": "2.0.0", > ".vscode\tasks.json"
        echo   "tasks": [ > ".vscode\tasks.json"
        echo     { > ".vscode\tasks.json"
        echo       "label": "Run Batch File", > ".vscode\tasks.json"
        echo       "type": "shell", > ".vscode\tasks.json"
        echo       "typeof": "${workspaceFolder}/batch.cmd", > ".vscode\tasks.json"
        echo       "group": { > ".vscode\tasks.json"
        echo           "kind": "build", > ".vscode\tasks.json"
        echo           "isDefault": true > ".vscode\tasks.json"
        echo       }, > ".vscode\tasks.json"
        echo       "problemMatcher": [], > ".vscode\tasks.json"
        echo       "detail": "Task to run the batch file" > ".vscode\tasks.json"
        echo     } > ".vscode\tasks.json"
        echo   ] > ".vscode\tasks.json"
    echo } > ".vscode\tasks.json"

    echo Creating '.vscode\tasks.json'...: [yes]

    start explorer ".vscode\"

    goto end

) else if "%typeof%"=="-mk" (

echo.
:___backs
    echo **Input "end" for back to menu . .
    set /p dirs="[%newtime%][%username%@%computername%] Enter Name > "


    if "%dirs%"=="end" (
        call :clears
    ) else (
            mkdir !dirs!
        )
    
goto ___backs

) else if "%typeof%"=="git clone" (
    git clone https://github.com/universestate/laterium.git
    cd laterium
) else if "%typeof%"=="-dir" (

    dir

) else if "%typeof%"=="help" (

call :_hash_

echo usage: command [-b build] [-c compile] [-bc build-compile]
echo       [-r running server] [-cr compile-running] [-cls clear screen]
echo       [-v laterium version] [-vsc vscode tasks]
echo       [-dir directory list] [-mk makedir]
goto cmd

) else if "%typeof%"=="" (

    goto cmd

) else (

    echo.
        echo    $ %typeof% - This typeof does not exist. Please try again..
    timeout /t 2
        goto cmd

)

:end
echo Press any key to return . . .
pause >nul
goto cmd
goto :eof

:_compiler_
    if not exist "%_Settings_%" (
            echo settings.ini is required to determine the gamemode..
            timeout /t 1 >nul
            goto _builds_
    )

    echo settings.ini found..

    set "laterium_path_gm="
    for /f "tokens=1,2 delims==" %%a in ('findstr /c:"drive=" "%_Settings_%"') do (
        if not "%%b"=="" (
            set "laterium_path_gm=%%b"
        )
    )
    
    if not defined laterium_path_gm (
        echo drive not found in settings.ini..
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
        echo settings.ini is missing gamemode information..
        timeout /t 1 >nul
        goto _builds_
    )

    set "laterium_path_gm=%_SearchDir_%!laterium_path_gm!"

    if not exist "!laterium_path_gm!" (
        echo folder not found: !laterium_path_gm!.
            goto cmd
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
            echo pawncc.exe not found in any subdirectories.
        echo.

        timeout /t 1 >nul
            start "" "https://github.com/pawn-lang/compiler/releases"
        goto cmd
    )
    
    if exist "!laterium_path_gm!\!laterium_path_file!.pwn" (
        set "file_extension=.pwn"
    ) else if exist "!laterium_path_gm!\!laterium_path_file!.p" (
        set "file_extension=.p"
    ) else if exist "!laterium_path_gm!\!laterium_path_file!.lt" (
        set "file_extension=.lt"
    ) else (
        echo file "!laterium_path_file!" with extensions .pwn, .p, or .lt not found in: "!laterium_path_gm!"
        timeout /t 1 >nul
        goto _builds_
    )

    echo    [ !laterium_path_file!!file_extension! ] [ !laterium_pawncc_path! ] [ !laterium_path_gm! ]
    echo.

    echo Found file: !laterium_path_file!!!
    echo Starting compilation..
    echo.
	rem don't use any symbols around here
    "!laterium_pawncc_path!" "!laterium_path_gm!\!laterium_path_file!!file_extension!" -o"!laterium_path_gm!\!laterium_path_file!.amx" -d0 > rus.txt

    if exist "!laterium_path_gm!\!laterium_path_file!.amx" (
        echo Compilation !laterium_path_file!!file_extension!...: [yes]
        echo.

        for %%A in ("!laterium_path_gm!\!laterium_path_file!.amx") do (
            echo Total Size !laterium_path_file!.amx / %%~zA bytes
        )
    ) else (
        echo Compilation !laterium_path_file!!file_extension!...: [no]
    )

    echo.

goto :eof
:_builds_
    :text
    echo.
    echo           *** S E T U P ***
    
    :_menus_
    set /p input="[%newtime%][System] Enter drive > "

set input=%input%
set input=%input: =0%

    if not "!input:~-1!"=="\" set "input=!input!\"

    if not exist "!input!" (
        echo specified directory '!input!' does not exist.
        goto _menus_
    )

    echo Found =^> !input!

    echo.
    dir /b "!input!"

:_build_
    echo.
    echo **Input "back" back to build . .
    echo **Input "end" back to menu . .
    set /p inputs="[%newtime%][System] Enter target > "

set inputs=%inputs%
set inputs=%inputs: =0%

    if "%inputs%"=="back" (
        cls
        echo.
        echo           *** B A C K ***
        echo. 
        goto _menus_
    ) else if "%inputs%"=="end" (
        call :clears
    )

    echo "!inputs!" | findstr /r "\." >nul
    if not errorlevel 1 (
        echo.
        echo you don't need any symbols
        goto _build_
    )

    if exist "!input!\!inputs!.pwn" ( echo Found =^> !inputs!.pwn ) else if exist "!input!\!inputs!.p" ( echo Found =^> !inputs!.p ) else if exist "!input!\!inputs!.lt" ( echo Found =^> !inputs!.lt ) else (
            echo "!input!" =^> "!inputs!.pwn - !inputs!.p - !inputs!.lt" not found..
        goto _build_
    )

    echo.
    echo Creating Status '!_Settings_!'...: [yes]
    echo.
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

    echo End Status...: [yes]
    echo.

goto :eof

:_hash_
	set "compn=%username%@%computername%"
	for /f "delims=" %%H in ('powershell -command "[System.BitConverter]::ToString((New-Object System.Security.Cryptography.SHA1Managed).ComputeHash([System.Text.Encoding]::UTF8.GetBytes('%compn%'))).Replace('-','').ToLower()"') do set "hash=%%H"
	title %compn% ^| %hash%
