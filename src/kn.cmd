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

set "version=2024.latest ^(1.0.2^)"
set "SysSearchDir=%~dp0"
set "SysSettings=%SysSearchDir%settings.ini"

:right
echo.
echo           *** W E L C O M E ***
echo.
echo [System]/Input "help" . . 

:cmd
for /f "tokens=1-3 delims=:" %%a in ("%time%") do set mytime=%%a%%b%%c
set /p command="[%mytime%][%username%@%computername%]/Enter Command:~$ "

if "%command%"=="0" (

:_katanas
    echo.
    echo        oooo    oooo             
    echo        `888   .8P'       Version: %version%
    echo         888  d8'         Release: [2024/December]
    echo         88888[           Desktop: %username%@%computername%
    echo         888`88b.         Uptime: %myTime%
    echo        +888   .8b.       DD/MM/YYYY HH:MM:SS.ms: %date% - %time%
    echo        o888o    o888,          
    echo.
goto end

) else if "%command%"=="rr_s" (

:__starts
    echo.
    echo Starting %date% %time%
    echo.

    set "SysSearchDir=%~dp0"
    set "SysSettings=%SysSearchDir%settings.ini"

    :mains
    if not exist "%SysSettings%" (
        echo [System]/settings.ini is required to determine the gamemode..
        timeout /t 1 >nul
        
        :text
        echo.
        echo           *** S E T U P ***

        :menu        
        echo. 
            echo [Time]/Starting %date% %time%

        :next
        echo.
        set /p input="[%mytime%][System]/Enter drive: >"

        if "%input%"=="end" (
            cls
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

        set /p inputs="[%mytime%][System]/Enter target: >"

        if "%inputs%"=="back" (
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
        echo [ERROR] The file "!katana_path_file!" with extensions .pwn, .p, or .kn not found in: "!katana_path_gm!"
        timeout /t 1 >nul
        goto builds
    )

    echo Found file: !katana_path_file!!!
    echo Starting compilation..
    echo.

    "!katana_pawncc_path!" "!katana_path_gm!\!katana_path_file!!file_extension!" -o"!katana_path_gm!\!katana_path_file!.amx"

    if exist "!katana_path_gm!\!katana_path_file!.amx" (
        echo Compilation done: !katana_path_file!.amx created in the folder.
        echo.

        for %%A in ("!katana_path_gm!\!katana_path_file!.amx") do (
            echo Total Size: !katana_path_file!.amx / %%~zA bytes
        )
    ) else (
        echo Compilation failed for !katana_path_file!!file_extension!..
    )

    echo.

goto end

) else if "%command%"=="1" (

:_builds_
    :text
    echo.
    echo           *** S E T U P ***

    :menu        
    echo. 
        echo [Time]/Starting %date% %time%

    :next
    echo.
    
    set /p input="[%mytime%][System]/Enter drive: >"

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
    set /p inputs="[%mytime%][System]/Enter target: >"

    if "%inputs%"=="back" (
        cls
        goto text
        goto menu
    ) else if "%inputs%"=="end" (
        goto clears
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
    echo           *** S U C C ES ***
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

    echo [System]/Press any key to return . . .
    pause >nul
    goto clears
) else if "%command%"=="2" (

:starts
echo [System]/Compiling...
    goto __starts
    goto cmd
    goto end

) else if "%command%"=="3" (

:bstarts
    goto __starts

    echo Press any key to open Compiler . . .
        pause >nul
            goto __starts
        goto cmd
goto end

) else if "%command%"=="4" (

:_runns
    goto _part
    goto end

) else if "%command%"=="5" (

:_srunns
echo [System]/Compiling..
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
        set /p input="[%mytime%][System]/Enter drive: >"

        if "%input%"=="end" (
            cls
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

        set /p inputs="[%mytime%][System]/Enter target: >"

        if "%inputs%"=="back" (
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
        echo [ERROR] The file "!katana_path_file!" with extensions .pwn, .p, or .kn not found in: "!katana_path_gm!"
        timeout /t 1 >nul
        goto builds
    )

    echo Found file: !katana_path_file!!!
    echo Starting compilation..
    echo.

    "!katana_pawncc_path!" "!katana_path_gm!\!katana_path_file!!file_extension!" -o"!katana_path_gm!\!katana_path_file!.amx"

    if exist "!katana_path_gm!\!katana_path_file!.amx" (
        echo Compilation done: !katana_path_file!.amx created in the folder.
        echo.

        for %%A in ("!katana_path_gm!\!katana_path_file!.amx") do (
            echo Total Size: !katana_path_file!.amx / %%~zA bytes
        )
    ) else (
        echo Compilation failed for !katana_path_file!!file_extension!..
    )

    echo.
    
taskkill /f /im samp-server.exe

    echo Press any key to Start Your Server's . . .
        pause >nul
:_part
timeout /t 1 /nobreak
    start "" "samp-server.exe"

    timeout /t 2 >nul

    tasklist | find /i "samp-server.exe" >nul

    if errorlevel 1 (
        echo [System]/The program failed to run. Checking logs...Program failed to run. Checking logs...
        
        if exist "server_log.txt" (
            echo [System]/Opening server_log.txt...
            start "" "notepad" "server_log.txt"
        ) else (
            echo [System]/server_log.txt not found.
        )
    ) else (
        echo [System]/The program was executed successfully.
    )
goto end

) else if "%command%"=="6" (

:versions
    echo.
        echo Current Katana Version =^> %version%
    echo.

    echo msgbox "Your Katana Version: 2024.latest.Now - build (1.0.2)" > "%tmp%\tmp.vbs"
        cscript /nologo "%tmp%\tmp.vbs"
            del "%tmp%\tmp.vbs"
goto end

) else if "%command%"=="7" (

:usernames
    echo.
        echo Current Username =^> %username%
            echo.
goto end

) else if "%command%"=="8" (

:taskss
    if not exist ".vscode" (
        mkdir ".vscode"
    ) else ( 
        echo.
            echo [System]/the task already exists!..
                echo.
        goto end
    )

    echo.
        echo [System]/Creating .vscode\tasks.json...

    timeout /t 1
        
    echo { > ".vscode\tasks.json"
        echo   "version": "2.0.0", >> ".vscode\tasks.json"
        echo   "tasks": [ >> ".vscode\tasks.json"
        echo     { >> ".vscode\tasks.json"
        echo       "label": "Run Batch File", >> ".vscode\tasks.json"
        echo       "type": "shell", >> ".vscode\tasks.json"
        echo       "command": "${workspaceFolder}/kn.cmd", >> ".vscode\tasks.json"
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
        echo [System]/Task configuration created successfully in .vscode\tasks.json.
            echo.

    start explorer ".vscode\"

    goto end

) else if "%command%"=="9" (

:guides
    if not exist "examples" (
        mkdir "examples"
    ) else (
        echo.
        echo [System]/the example already exists!
        echo.
        goto end
    )

    echo.
    echo [System]/Creating examples\helloworld.pwn...

    timeout /t 1
    
    echo /* example */>> "examples\helloworld.pwn"
    echo #include "a_samp">> "examples\helloworld.pwn"
    echo.>> "examples\helloworld.pwn"
    echo ^main(^) {>> "examples\helloworld.pwn"
    echo tests:>> "examples\helloworld.pwn"
    echo    print "Hello, World!">> "examples\helloworld.pwn"
    echo        goto tests;>> "examples\helloworld.pwn"
    echo }>> "examples\helloworld.pwn"
    echo.>> "examples\helloworld.pwn"
    echo ^public OnPlayerConnect(playerid^) {>> "examples\helloworld.pwn"
    echo    SendClientMessage playerid, -1, "Hello">> "examples\helloworld.pwn"
    echo    return 1;>> "examples\helloworld.pwn"
    echo }>> "examples\helloworld.pwn"

    echo.
    echo [System]/Example tool created in examples\helloworld.pwn.
    echo.

    start explorer "examples\"

    goto end

) else if "%command%"=="10" (

:clears
    cls
    goto right
    goto cmd

) else if "%command%"=="-katana" (

goto _katanas

) else if "%command%"=="-build" (

goto builds

) else if "%command%"=="-start" (

goto starts

) else if "%command%"=="-bstart" (

goto bstarts

) else if "%command%"=="-runn" (

goto _runns

) else if "%command%"=="-srunn" (

goto _srunns

) else if "%command%"=="-version" (

goto versions

) else if "%command%"=="-username" (

goto usernames

) else if "%command%"=="-tasks" (

goto taskss

) else if "%command%"=="-example" (

goto guides

) else if "%command%"=="-clear" (

goto clears

) else if "%command%"=="help" (

    echo.
setlocal DisableDelayedExpansion
	echo Hello, %username%@%computername%!
endlocal
    echo.
    echo *** G E N E R A L ***
    echo [0] -katana    : Katana Stats.
    echo [1] -build     : Build Katana compiler.
    echo [2] -start     : Start Katana compiler.
    echo [3] -bstart    : Build and compile.
    echo [4] -runn      : Run server.
    echo [5] -srunn     : Compile and run server.
    echo.
    echo *** R A N D O M ***
    echo [6] -version   : Katana version.
    echo [7] -username  : Your Windows username.
    echo.
    echo *** S Y S T E M ***
    echo [8] -tasks     : Create VSCode Task.
    echo [9] -example   : Create Katana SA-MP example.
    echo [10] -clear    : Clear terminal screen.
    echo.
    goto cmd

) else if "%command%"=="kill" (

    goto clears

) else if "%command%"=="samp" (

    start "" "https://www.sa-mp.mp/"
    goto end

) else if "%command%"=="cmd" (

    start "" cmd.exe
    goto end

) else if "%command%"=="powershell" (

    start "" powershell.exe
    goto end

) else if "%command%"=="time" (

    echo.
    echo %time%
    echo.
    goto end

) else if "%command%"=="date" (

    echo.
    echo %date%
    echo.
    goto end

) else if "%command%"=="dir" (

    dir /s

) else if "%command%"=="mkdir" (

:dirc
    set /p dirs="[%mytime%][%username%@%computername%]/Enter Dir Name: >"

    if exist "!dirs!" (
        echo [System]/Dir "!dirs!" Allready!
        goto dirc
    ) else (
        mkdir !dirs!
        echo [System]/Dir !dirs! Created..
        goto end
    )

) else if "%command%"=="katana" (

    goto _katanas

) else if "%command%"=="" (

    goto cmd

) else if "%command%"=="-" (

    goto cmd

) else (

    echo.
        echo $ %command% - This command does not exist. Please try again..
    timeout /t 2
        goto cmd

)

:end
echo [System]/Press any key to return . . .
pause >nul
goto cmd
goto :eof
