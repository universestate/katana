:: commands
@echo off

:: CMYK color.
color c

:: title for label Caption Terminal.
title %date%

:: Delayed Variable Expansion.
setlocal enabledelayedexpansion

:: set variable.
set "version=2024.latest.Now ^(0.0.4^)" :: current version.

:ascii
echo oooo    oooo       .o.       ooooooooooooo       .o.       ooooo      ooo       .o.       
echo `888   .8P'       .888.      8'   888   `8      .888.      `888b.     `8'      .888.      
echo  888  d8'        .8"888.          888          .8"888.      8 `88b.    8      .8"888.     
echo  88888`         .8' `888.         888         .8' `888.     8   `88b.  8     .8' `888.    
echo  888`88b.      .88ooo8888.        888        .88ooo8888.    8     `88b.8    .88ooo8888.   
echo  888  `88b.   .8'     `888.       888       .8'     `888.   8       `888   .8'     `888.  
echo o888o  o888o o88o     o8888o     o888o     o88o     o8888o o8o        `8  o88o     o8888o 
echo.

:: command line
:cmd
echo **************************
    echo $ command:
    echo ** [General]
    echo * Katana     :       -katana        : What's Katana?
    echo * Katana     :       -build         : build Katana compiler.
    echo * Katana     :       -start         : Start Katana compiler.
    echo * Katana     :       -bstart        : build - compile..
    echo * Katana     :       -runn          : running server's.
    echo * Katana     :       -srunn         : compile - run server..
    echo.
    echo ** [Mod]
    echo * Katana     :       -version       : Your Katana Version.
    echo * Katana     :       -username      : Your Windows Username.
    echo.
    echo ** [Startup]
    echo * Katana     :       -tasks         : Create VSCode Task Katana Compiler.
    echo * Katana     :       -example       : Create Example Katana Funcc SA-MP.
    echo * Katana     :       -clear         : Clear Terminal Screen, Back to main menu.
    echo.
echo **************************
echo.
set /p command="** input cmd: > $ "

:: response for command.
if "%command%"=="-katana" (

echo msgbox "Katana is a compilation tool with multiple functions for the Pawn Compiler in SA-MP." > "%tmp%\tmp.vbs"
    cscript /nologo "%tmp%\tmp.vbs"
        del "%tmp%\tmp.vbs"

echo msgbox "You do not need to use symbols like ';' and '( )' and other in your program code if using this software. For example, you can use '-example' and immediately check the guidelines\helloworld.pwn file for more information." > "%tmp%\tmp.vbs"
    cscript /nologo "%tmp%\tmp.vbs"
        del "%tmp%\tmp.vbs"

echo msgbox "-[WARNING]-: If you use the code structure from Katana, you are expected to compile it using the software provided by katana. Using the default Pawn Editor software will cause errors." > "%tmp%\tmp.vbs"
    cscript /nologo "%tmp%\tmp.vbs"
        del "%tmp%\tmp.vbs"

echo msgbox "Thank you for using this software :^)" > "%tmp%\tmp.vbs"
    cscript /nologo "%tmp%\tmp.vbs"
        del "%tmp%\tmp.vbs"

) else if "%command%"=="-build" (

echo :: Building compiler...
    start "" "pawn-setup.cmd"
    goto cmd

) else if "%command%"=="-start" (

echo :: Compiling...
    start "" "pawn-start.cmd"

)  else if "%command%"=="-bstart" (

    start "" "pawn-setup.cmd"

    echo Press any key to open Compiler . . .
        pause >nul
            start "" "pawn-start.cmd"

) else if "%command%"=="-runn" (

    start "" "samp-server.exe"

    timeout /t 1 >nul

    tasklist | find /i "samp-server.exe" >nul

    if errorlevel 1 (
        echo :: The program failed to run. Checking logs...Program failed to run. Checking logs...
        
        if exist "server_log.txt" (
            echo :: Opening server_log.txt...
            start "" "notepad" "server_log.txt"
        ) else (
            echo :: server_log.txt not found.
        )
    ) else (
        echo :: The program was executed successfully.
    )

) else if "%command%"=="-srunn" (

echo :: Compiling..
    start "" "pawn-start.cmd"
    
    echo Press any key to Start Your Server's . . .
        pause >nul

    start "" "samp-server.exe"

    timeout /t 1 >nul

    tasklist | find /i "samp-server.exe" >nul

    if errorlevel 1 (
        echo :: The program failed to run. Checking logs...Program failed to run. Checking logs...
        
        if exist "server_log.txt" (
            echo :: Opening server_log.txt...
            start "" "notepad" "server_log.txt"
        ) else (
            echo :: server_log.txt not found.
        )
    ) else (
        echo :: The program was executed successfully.
    )

) else if "%command%"=="-username" (

    echo.
        echo Current Username =^> %username%
            echo.

) else if "%command%"=="-version" (

    echo.
        echo Current Katana Version =^> %version%
    echo.

    echo msgbox "Your Katana Version: 2024.latest.Now - build (0.0.4)" > "%tmp%\tmp.vbs"
        cscript /nologo "%tmp%\tmp.vbs"
            del "%tmp%\tmp.vbs"

) else if "%command%"=="-tasks" (

    if not exist ".vscode" (
        mkdir ".vscode"
    ) else ( 
        echo.
            echo :: the task already exists!..
                echo.
        goto end
    )

    echo.
        echo :: Creating .vscode\tasks.json...

    timeout /t 1

    echo {>> ".vscode\tasks.json"
        echo   "version": "2.0.0",>> ".vscode\tasks.json"
        echo   "tasks": [>> ".vscode\tasks.json"
        echo     {>> ".vscode\tasks.json"
        echo       "label": "Run Katana SA-MP CMD",>> ".vscode\tasks.json"
        echo       "type": "shell",>> ".vscode\tasks.json"
        echo       "command": "start",>> ".vscode\tasks.json"
        echo       "args": [>> ".vscode\tasks.json"
        echo           "${workspaceRoot}/pawn-start.cmd">> ".vscode\tasks.json"
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
        echo :: Task configuration created successfully in .vscode\tasks.json.
            echo.

    goto end

) else if "%command%"=="-example" (

    if not exist "guidelines" (
        mkdir "guidelines"
    ) else (
        echo.
            echo :: the example already exists!
                echo.
        goto end
    )

    echo.
        echo :: Creating guidelines\helloworld.pwn...

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
        echo    return 1;>> "guidelines\helloworld.pwn"
        echo }>> "guidelines\helloworld.pwn"

        echo.>> "guidelines\helloworld.pwn"

        echo ^public OnPlayerConnect(playerid^) {>> "guidelines\helloworld.pwn"
            echo    SendClientMessage playerid, -1, "Hello">> "guidelines\helloworld.pwn"
            echo    return 1;>> "guidelines\helloworld.pwn"
        echo }>> "guidelines\helloworld.pwn"

    echo.
        echo :: Example tool created in guidelines\helloworld.pwn.
            echo.
    
    goto end

) else if "%command%"=="-clear" (

    cls

    goto ascii
    goto cmd

) else if "%command%"=="help" (

    goto cmd

) else if "%command%"=="hello" (

    echo msgbox "Hello, Man :^)" > "%tmp%\tmp.vbs"
        cscript /nologo "%tmp%\tmp.vbs"
            del "%tmp%\tmp.vbs"

) else if "%command%"=="" (

    goto cmd

) else if "%command%"=="katana" (
    
    goto cmd

) else (

    echo.
        echo $ : %command% - This command does not exist. Please try again..

    timeout /t 2
        goto cmd

)

:end
echo :: Press any key to return . . .
pause >nul

goto cmd
