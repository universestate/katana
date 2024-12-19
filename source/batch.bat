@echo off

setlocal enabledelayedexpansion

set "_version_=2024.x21 ^(B-14^)"
set "_SearchDir_=%~dp0"

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

title type `help` to get started

for /f "tokens=1-3 delims=:." %%a in ("%time%") do set newtime=%%a%%b.%%c

:cmd
set /p typeof="%username%@%computername%~$ "

if "%typeof%"=="cat -c" (

echo.
echo Compiling...
    call :_compiler_

) else if "%typeof%"=="cat -r" (

    call :_part
    goto end

) else if "%typeof%"=="cat -ci" (
 
    call :_compiler_

    findstr /i "error" rus.txt > nul
    echo Errorlevel is: %errorlevel%
    if %errorlevel% equ 0 (
        echo Error Status...: [no]
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

        if exist "server_log.txt" (
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

) else if "%typeof%"=="cat -cls" (

:clears
    cls
    goto _laterium_
    goto cmd

) else if "%typeof%"=="cat -v" (

    echo.
        echo    Laterium Version : %_version_%
    echo.
goto end

) else if "%typeof%"=="cat -vsc" (

    mkdir .vscode
        
    echo { > ".vscode\tasks.json"
        echo   "version": "2.0.0", > ".vscode\tasks.json"
        echo   "tasks": [ > ".vscode\tasks.json"
        echo     { > ".vscode\tasks.json"
        echo       "label": "Run Batch File", > ".vscode\tasks.json"
        echo       "type": "shell", > ".vscode\tasks.json"
        echo       "file": "${workspaceFolder}/batch.bat", > ".vscode\tasks.json"
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

) else if "%typeof%"=="help" (

    :_help
    call :_hash_

    echo usage: cat [-c compile] [-r running server] [-ci compile-running] [-cls clear screen]
    echo       [-v laterium version] [-vsc vscode tasks]
    goto cmd

) else if "%typeof%"=="cat" (

    goto _help

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
    echo Searching for .lat files...

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

    set "found_file="
    for /r "%_SearchDir_%" %%f in (*lat*) do (
        if exist "%%f" (
            set "found_file=%%f"
            goto compile_file
        )
    )

    if not defined found_file (
        echo No .lat files found in: "%_SearchDir_%"
        timeout /t 1 >nul
        goto cmd
    )

:compile_file
    echo Found file: !found_file!
    echo Starting compilation..
    echo.

    set "output_file=!found_file:~0,-4!.amx"

    "!laterium_pawncc_path!" "!found_file!" -o"!output_file!" -d0 > rus.txt 2>&1

    type rus.txt

    if exist "!output_file!" (
        echo Compilation !output_file!...: [yes]
        echo.

        for %%A in ("!output_file!") do (
            echo Total Size !output_file! / %%~zA bytes
        )
    ) else (
        echo Compilation !output_file!...: [no]
    )

    echo.

goto :eof

:_hash_
    set "compn=%username%@%computername%"
    for /f "delims=" %%H in ('powershell -NoProfile -Command "[System.BitConverter]::ToString((New-Object System.Security.Cryptography.SHA1Managed).ComputeHash([System.Text.Encoding]::UTF8.GetBytes('%[...]
    title %compn% ^| %hash%
