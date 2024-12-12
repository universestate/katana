:: GNU 2.0
@echo off

color c
title %date%
setlocal enabledelayedexpansion

set "version=2024.latest.Now - Build ^(0.0.4^)" [System]/current version.

:ascii
echo oooo    oooo       .o.       ooooooooooooo       .o.       ooooo      ooo       .o.       
echo `888   .8P'       .888.      8'   888   `8      .888.      `888b.     `8'      .888.      
echo  888  d8'        .8"888.          888          .8"888.      8 `88b.    8      .8"888.     
echo  88888`         .8' `888.         888         .8' `888.     8   `88b.  8     .8' `888.    
echo  888`88b.      .88ooo8888.        888        .88ooo8888.    8     `88b.8    .88ooo8888.   
echo  888  `88b.   .8'     `888.       888       .8'     `888.   8       `888   .8'     `888.  
echo o888o  o888o o88o     o8888o     o888o     o88o     o8888o o8o        `8  o88o     o8888o 

:cmd
echo.
echo **************************
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
echo **************************
echo.
for /f "tokens=1-3 delims=:" %%a in ("%time%") do set mytime=%%a%%b%%c
set /p command="[%mytime%]/Enter Command:~$ "

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
echo [System]/Building compiler...
    start "" "pwn-build.cmd"
    goto cmd

) else if "%command%"=="2" (

:starts
echo [System]/Compiling...
    start "" "pwn-start.cmd"
    goto cmd

) else if "%command%"=="3" (

:bstarts
    start "" "pwn-build.cmd"

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
    if not exist "guidelines" (
        mkdir "guidelines"
    ) else (
        echo.
            echo [System]/the example already exists!
                echo.
        goto end
    )

    echo.
        echo [System]/Creating guidelines\helloworld.pwn...

    timeout /t 1
    
    echo /* example */>> "guidelines\helloworld.pwn"

        echo #include "a_samp">> "guidelines\helloworld.pwn"
        echo.>> "guidelines\helloworld.pwn"
        
        echo #pragma tabsize 4 >> "guidelines\helloworld.pwn"
        echo.>> "guidelines\helloworld.pwn"

        echo ^main(^) {>> "guidelines\helloworld.pwn"
        echo printthis:>> "guidelines\helloworld.pwn"
        echo    print "Hello, World!">> "guidelines\helloworld.pwn"
        echo        goto printthis;>> "guidelines\helloworld.pwn"
        echo }>> "guidelines\helloworld.pwn"

        echo.>> "guidelines\helloworld.pwn"

        echo ^public OnPlayerConnect(playerid^) {>> "guidelines\helloworld.pwn"
            echo    SendClientMessage playerid, -1, "Hello">> "guidelines\helloworld.pwn"
            echo    return 1;>> "guidelines\helloworld.pwn"
        echo }>> "guidelines\helloworld.pwn"

    echo.
        echo [System]/Example tool created in guidelines\helloworld.pwn.
            echo.
    
    goto end

) else if "%command%"=="10" (

:clears
    cls
    goto ascii
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

    goto cmd

) else if "%command%"=="hello" (

    echo msgbox "Hello, Man :)" > "%tmp%\tmp.vbs"
        cscript /nologo "%tmp%\tmp.vbs"
            del "%tmp%\tmp.vbs"

) else if "%command%"=="katana" (

echo.
echo    oooo    oooo           
echo    `888   .8P'            Version: %version%
echo     888  d8'              Katana Release: [2024/December]
echo     88888`                Username: %username%
echo     888`88b.              Current Date-Time: %date% - %time%
echo     888  `88b.            Computer Name: %computername%
echo    o888o  o888o           
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
