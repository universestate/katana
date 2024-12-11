:: GNU 2.0
@echo off

color c
title %date%
setlocal enabledelayedexpansion

set "DirectoryKN=%~dp0"
set "SystemKN=%DirectoryKN%settings.ini"

:text
echo.
echo            W E L C O M E   

:menu        
echo. 
    echo [Time]/Starting %date% -%time%

:next
echo.
@echo off
for /f "tokens=1-3 delims=:" %%a in ("%time%") do set mytime=%%a%%b%%c
set /p input="[%mytime% ][System]/Enter drive > "


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
echo [System]/Input "back" for back to main menu . .
for /f "tokens=1-3 delims=:" %%a in ("%time%") do set mytime=%%a%%b%%c
set /p inputs="[%mytime% ][System]/Enter target: > "

if "%inputs%"=="" (
    echo msgbox "[ERROR]/File name cannot be empty." > "%tmp%\tmp.vbs"
            cscript /nologo "%tmp%\tmp.vbs"
        del "%tmp%\tmp.vbs"
    goto back
) else if "%inputs%"=="back" (
    cls
    goto text
    goto menu
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
