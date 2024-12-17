@echo off

setlocal enabledelayedexpansion

set "version=12/18/2024 ^(B-13^)"
set "SysSearchDir=%~dp0"
set "SysSettings=%SysSearchDir%settings.ini"

for /f "tokens=2 delims=:" %%a in ('systeminfo ^| find "System Boot Time"') do set boot_time=%%a

:right
echo.
echo           *** W E L C O M E ***
echo.
echo [System]*Input "help" . . 

set time=%time%
set time=%time: =0%

title %date%
color d

for /f "tokens=1-3 delims=:" %%a in ("%time%") do set mytime=%%a%%b%%c

:cmd
set /p command="[%mytime%][%username%@%computername%]*Enter Command:~$"

if "%command%"=="laterium" (

    echo.
    echo    ooooo
    echo    `888'
    echo     888
    echo     888
    echo     888
    echo     888       o   %version%
    echo    o888ooooood8
    echo.

) else if "%command%"=="lt -b" (

    call :_builds_
        echo [System]*Press any key to return . . .
        pause >nul
    call :clears

) else if "%command%"=="lt -c" (

echo.
echo [System]*Compiling...
    call :_compiler_

) else if "%command%"=="lt -bc" (

    call :_builds_
    echo Press any key to open Compiler . . .
        pause >nul
            call :_compiler_

) else if "%command%"=="lt -r" (

    call :_part
    goto end

) else if "%command%"=="lt -sr" (

    call :_compiler_ > rus.txt
    
    findstr /i "Error" rus.txt > nul
    if %errorlevel% equ 0 (
        setlocal disabledelayedexpansion
            echo     Error Detected!
        endlocal
	    goto end
    ) else (
            taskkill /f /im samp-server.exe
    
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
                echo [System]*The program failed to run. Checking logs...Program failed to run. Checking logs...
                
                if exist "server_log.txt" (
                    echo [System]*Opening server_log.txt...
                    start "" "notepad" "server_log.txt"
                ) else (
                    echo [System]*server_log.txt not found.
                )
            ) else (
                echo [System]*The program was executed successfully.
            )
    )
    goto end

) else if "%command%"=="lt -cc" (

:clears
    cls
    goto right
    goto cmd

) else if "%command%"=="lt --v" (

    echo.
        echo    Laterium Version : %version%
    echo.
goto end

) else if "%command%"=="lt -u" (

    echo.
        echo    Current Username : %username%@%computername%!
            echo.
goto end

) else if "%command%"=="lt -vs" (

:taskss
    if not exist ".vscode" (
        mkdir ".vscode"
    ) else ( 
        echo.
            echo [System]*the task already exists!..
                echo.
        goto end
    )

    echo.
        echo [System]*Creating .vscode\tasks.json...

    timeout /t 1
        
    echo { > ".vscode\tasks.json"
        echo   "version": "2.0.0", >> ".vscode\tasks.json"
        echo   "tasks": [ >> ".vscode\tasks.json"
        echo     { >> ".vscode\tasks.json"
        echo       "label": "Run Batch File", >> ".vscode\tasks.json"
        echo       "type": "shell", >> ".vscode\tasks.json"
        echo       "command": "${workspaceFolder}/lt.cmd", >> ".vscode\tasks.json"
        echo       "group": { >> ".vscode\tasks.json"
        echo           "kind": "build", >> ".vscode\tasks.json"
        echo           "isDefault": true >> ".vscode\tasks.json"
        echo       }, >> ".vscode\tasks.json"
        echo       "problemMatcher": [], >> ".vscode\tasks.json"
        echo       "detail": "Task to run the batch file" >> ".vscode\tasks.json"
        echo     } >> ".vscode\tasks.json"
        echo   ] >> ".vscode\tasks.json"
    echo } >> ".vscode\tasks.json"

    echo.
        echo [System]*Task configuration created successfully in .vscode\tasks.json.
            echo.

    start explorer ".vscode\"

    goto end

) else if "%command%"=="lt -md" (

echo.
:___backs
    echo [System]*Input "end" for back to menu . .
    set /p dirs="[%mytime%][%username%@%computername%]*Enter Dir Name: >"


    if "%dirs%"=="end" (
        call :clears
    ) else (
        if exist "!dirs!" (
            echo    Creating '!dirs!' ... No
            echo        folder allready!
        ) else (
            mkdir !dirs!
            echo    Creating '!dirs!' ... Yes
        )
    )
goto ___backs

) else if "%command%"=="dir" (

    dir /s

) else if "%command%"=="help" (
    echo.
    echo    ooooo           $laterium   ;   $lt --v
    echo    `888'           $lt -b      ;   $lt -u
    echo     888            $lt -c      ;   $lt -vs
    echo     888            $lt -bc     ;   $lt -md
    echo     888            $lr -r
    echo     888       o    $lt -sr
    echo    o888ooooood8    $lt -cc
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
    echo [System]*settings.ini found..

    set "laterium_path_gm="
    for /f "tokens=1,2 delims==" %%a in ('findstr /c:"drive=" "%SysSettings%"') do (
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
    for /f "tokens=1,2 delims==" %%a in ('findstr /c:"target=" "%SysSettings%"') do (
        if not "%%b"=="" (
            set "laterium_path_file=%%b"
        )
    )

    if not defined laterium_path_file (
        echo [System]*settings.ini is missing gamemode information.
        timeout /t 1 >nul
        
    )

    set "laterium_path_gm=%SysSearchDir%!laterium_path_gm!"

    if not exist "!laterium_path_gm!" (
        echo [System]*Gamemodes folder not found: !laterium_path_gm!.
            timeout /t 1 >nul
                start "" "https://sa-mp.app/"
            echo [Out]*Exiting . .
        timeout /t 5
        exit
    )

    set "laterium_pawncc_path="
    for /r "%SysSearchDir%" %%p in (pawncc.exe) do (
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

    "!laterium_pawncc_path!" "!laterium_path_gm!\!laterium_path_file!!file_extension!" -o"!laterium_path_gm!\!laterium_path_file!.amx"

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
 
    echo. 
        echo [Time]*Starting %date% %time%
    echo.
    
    :____menus____
    set /p input="[%mytime%][System]*Enter drive: >"

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
    echo [System]*Input "back" for back to build . .
    echo [System]*Input "end" for back to menu . .
    set /p inputs="[%mytime%][System]*Enter target: >"

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
    echo    Creating '!SysSettings!' ... Yes
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
    ) > "%SysSettings%"

    echo.
    echo    End Status  ...  Yes
    echo.
