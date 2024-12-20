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

:: set time=%time%
:: set time=%time: =0%

title type `help` to get started

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

    ver > nul
    findstr /i "error" rus.txt > nul
    echo Errorlevel after findstr: %errorlevel%
    if %errorlevel% equ 0 (
        echo Success
        goto _start_this
    ) else (
        echo Failure
        goto end
    )

:_start_this
    taskkill /f /im "samp-server.exe" >nul 2>&1

    echo.
    echo Press any key to Start Your Server's . . .
    pause >nul
:_part
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

        title Checking Logs...
        timeout /t 4

        if exist "server_log.txt" (
            type "server_log.txt"
        ) else (
            echo server_log.txt not found.
        )
        echo.
        echo end...
        goto cmd
    ) else (
        echo.
        echo Status Starting... [yes]
        echo.
    )
    goto cmd

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
        echo       "file": "${workspaceFolder}/windows.bat", > ".vscode\tasks.json"
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

    set "_pawncc="
    for /r "%_SearchDir_%" %%p in (pawncc.exe) do (
        if exist "%%p" (
            set "_pawncc=%%p"
            goto f_pawncc
        )
    )

    :f_pawncc
    if not defined _pawncc (
        echo.
        echo pawncc.exe not found in any subdirectories.
        echo.

        timeout /t 1 >nul
        start "" "https://github.com/pawn-lang/compiler/releases"
        goto cmd
    )

    for /r "%_SearchDir_%" %%f in (*.lat.pwn*) do (
        if exist "%%f" (
            echo Found file: %%f
            echo Starting compilation..
            echo.

            set "_output=%%~dpnf"
            set "_output=!_output:.lat=!%.amx"

            "!_pawncc!" "%%f" -o"!_output!" -d0 > rus.txt 2>&1

            type rus.txt

            if exist "!_output!" (
                echo Compilation !_output!...: [yes]
                echo.

                for %%A in ("!_output!") do (
                    echo Total Size !_output! / %%~zA bytes
                )
            ) else (
                echo Compilation !_output!...: [no]
            )

            echo.
        )
    )
goto :eof

:_hash_
    set "compn=%username%@%computername%"
    for /f "delims=" %%H in ('powershell -NoProfile -Command "[System.BitConverter]::ToString((New-Object System.Security.Cryptography.SHA1Managed).ComputeHash([System.Text.Encoding]::UTF8.GetBytes('%compn%')) -replace '-', ''"') do set hash=%%H
    title %compn% ^| %hash%
