:: GNU 2.0
@echo off

color c
title %date%
setlocal enabledelayedexpansion

set "version=2024.latest ^(0.0.4^)" [System]/current version.

set "DirectoryKN=%~dp0"
set "SystemKN=%DirectoryKN%settings.ini"

:right
echo.
echo            W E L C O M E   
echo.
echo [System]/Input "help" . . 
:cmd
for /f "tokens=1-3 delims=:" %%a in ("%time%") do set mytime=%%a%%b%%c
set /p command="[%mytime%][%username%@%computername%]/Enter Command:~$ "

if "%command%"=="0" (

:katanas
echo msgbox "Katana is a compilation tool with multiple functions for the Pawn Compiler in SA-MP." > "%tmp%\tmp.vbs"
    cscript /nologo "%tmp%\tmp.vbs"
        del "%tmp%\tmp.vbs"

echo msgbox "-[WARNING]-: If you use the code structure from Katana, you are expected to compile it using the software provided by katana. Using the default Pawn Editor software will cause errors." > "%tmp%\tmp.vbs"
    cscript /nologo "%tmp%\tmp.vbs"
        del "%tmp%\tmp.vbs"

echo msgbox "Thank you for using this software :)" > "%tmp%\tmp.vbs"
    cscript /nologo "%tmp%\tmp.vbs"
        del "%tmp%\tmp.vbs"
goto end

) else if "%command%"=="1" (

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
    set /p input="[%mytime%][[System]/Enter drive: > "


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

    echo [System]/Press any key to return . . .
    pause >nul

    goto text
    goto next
    goto :eof

) else if "%command%"=="2" (

:starts
echo [System]/Compiling...
    start "" "pwn-start.cmd"
    goto cmd

) else if "%command%"=="3" (

:bstarts
    start "" "goto builds"

    echo Press any key to open Compiler . . .
        pause >nul
            start "" "pwn-start.cmd"
        goto cmd

) else if "%command%"=="4" (

:runns
    start "" "samp-server.exe"

    timeout /t 1 >nul

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

) else if "%command%"=="5" (

:sruuns
echo [System]/Compiling..
    start "" "pwn-start.cmd"
    
    echo Press any key to Start Your Server's . . .
        pause >nul

    start "" "samp-server.exe"

    timeout /t 1 >nul

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

) else if "%command%"=="6" (

:versions
    echo.
        echo Current Katana Version =^> %version%
    echo.

    echo msgbox "Your Katana Version: 2024.latest.Now - build (0.0.4)" > "%tmp%\tmp.vbs"
        cscript /nologo "%tmp%\tmp.vbs"
            del "%tmp%\tmp.vbs"

) else if "%command%"=="7" (

:usernames
    echo.
        echo Current Username =^> %username%
            echo.

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

    echo {>> ".vscode\tasks.json"
        echo   "version": "2.0.0",>> ".vscode\tasks.json"
        echo   "tasks": [>> ".vscode\tasks.json"
        echo     {>> ".vscode\tasks.json"
        echo       "label": "Run Katana SA-MP CMD",>> ".vscode\tasks.json"
        echo       "type": "shell",>> ".vscode\tasks.json"
        echo       "command": "start",>> ".vscode\tasks.json"
        echo       "args": [>> ".vscode\tasks.json"
        echo           "${workspaceRoot}/pwn-start.cmd">> ".vscode\tasks.json"
        echo       ],>> ".vscode\tasks.json"
        echo       "group": {>> ".vscode\tasks.json"
        echo           "kind": "build",>> ".vscode\tasks.json"
        echo           "isDefault": true>> ".vscode\tasks.json"
        echo       },>> ".vscode\tasks.json"
        echo       "problemMatcher": [],>> ".vscode\tasks.json"
        echo       "presentation": {>> ".vscode\tasks.json"
        echo           "reveal": "silent">> ".vscode\tasks.json"
        echo       }>> ".vscode\tasks.json"
        echo     }>> ".vscode\tasks.json"
        echo   ]>> ".vscode\tasks.json"
    echo }>> ".vscode\tasks.json"

    echo.
        echo [System]/Task configuration created successfully in .vscode\tasks.json.
            echo.

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

goto katanas

) else if "%command%"=="-build" (

goto builds

) else if "%command%"=="-start" (

goto starts

) else if "%command%"=="-bstart" (

goto bstarts

) else if "%command%"=="-runn" (

goto ruuns

) else if "%command%"=="-srunn" (

goto sruuns

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
echo /*         K A T A N A - %username%@%computername%         */
    echo $ command:
    echo **                 G E N E R A L
    echo * [0]     :       -katana        : What's Katana?
    echo * [1]     :       -build         : build Katana compiler.
    echo * [2]     :       -start         : Start Katana compiler.
    echo * [3]     :       -bstart        : build - compile..
    echo * [4]     :       -runn          : running server's.
    echo * [5]     :       -srunn         : compile - run server..
    echo.
    echo **                 R A N D O M
    echo * [6]     :       -version       : Your Katana Version.
    echo * [7]     :       -username      : Your Windows Username.
    echo.
    echo **                 S Y S T E M
    echo * [8]     :       -tasks         : Create VSCode Task Katana Compiler.
    echo * [9]     :       -example       : Create Example Katana Funcc SA-MP.
    echo * [10]    :       -clear         : Clear Terminal Screen, Back to main menu.
    echo.
goto cmd

) else if "%command%"=="samp" (
    
    start "" "https://www.sa-mp.mp/"
    goto end

) else if "%command%"=="cmd" (

    start "" cmd.exe
    goto end

) else if "%command%"=="powershell" (

    start "" powershell.exe
    goto end

) else if "%command%"=="hello" (

    echo msgbox "Hello, Man :)" > "%tmp%\tmp.vbs"
        cscript /nologo "%tmp%\tmp.vbs"
            del "%tmp%\tmp.vbs"

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

) else if "%command%"=="google" (
    
    echo.
    start "" "https://google.com/"
    echo Start "https://google.com/"
    echo.
    goto end

) else if "%command%"=="youtube" (
    
    echo.
    start "" "https://youtube.com/"
    echo Start "https://youtube.com/"
    echo.
    goto end

) else if "%command%"=="sqlmap" (
    
    start "" "https://sqlmap.org/"
    goto end

) else if "%command%"=="evercool" (
    
    echo.
    start "" "https://dsc.gg/everscools/"
    echo Start "https://dsc.gg/everscools/"
    echo.
    goto end

) else if "%command%"=="warning" (

    start "" "https://sampwiki.blast.hk/wiki/Errors_List#Errors:~:text=6%20External%20Links-,General%20Pawn%20Error%20List,-This%20pages%20contains"
    goto end

) else if "%command%"=="error" (

    start "" "https://sampwiki.blast.hk/wiki/Errors_List#Errors:~:text=through%20the%20editor.-,Common%20Warnings,-202%3A%20number%20of"
    goto end

) else if "%command%"=="dir" (
    
    dir /s

) else if "%command%"=="katana" (
for /f "tokens=1-3 delims=:" %%a in ("%time%") do set mytime=%%a%%b%%c
    echo.
    echo        oooo    oooo             
    echo        `888   .8P'       Version: %version%
    echo         888  d8'         Release: [2024/December]
    echo         88888[           Desktop: %username%@%computername%
    echo         888`88b.         Uptime: %myTime%
    echo        +888   .8b.       DD/MM/YYYY HH:MM:SS.ms: %date% - %time%
    echo        o888o    o888,          
    echo.
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
