:: @setup
@echo off

:: CMYK color.
color c

:: title for label Caption Terminal.
title %date%

:: Delayed Variable Expansion.
setlocal enabledelayedexpansion

:: set variable.
set "katanaDir=%~dp0"
set "katanaFile=%katanaDir%system.ini"

:start
echo.
    echo :: Starting %date% %time%

:next
echo.
    set /p input=":: Enter drive (Directory Path): > "

if "%input%"=="" (
    echo :: Directory path cannot be empty.
        echo msgbox "[ERROR]: Directory path cannot be empty." > "%tmp%\tmp.vbs"
            cscript /nologo "%tmp%\tmp.vbs"
                del "%tmp%\tmp.vbs"
    goto next
)

if not "!input:~-1!"=="\" set "input=!input!\"

if not exist "!input!" (
    echo :: The specified directory does not exist.
        echo msgbox "[ERROR]: The specified directory does not exist." > "%tmp%\tmp.vbs"
            cscript /nologo "%tmp%\tmp.vbs"
                del "%tmp%\tmp.vbs"
    goto next
)

echo Listing files in the directory:
echo.
dir /c "!input!"

:back
echo.
    set /p input2=":: Enter the name of the target file: > "

if "%input2%"=="" (
    echo :: File name cannot be empty.
        echo msgbox "[ERROR]: File name cannot be empty." > "%tmp%\tmp.vbs"
            cscript /nologo "%tmp%\tmp.vbs"
                del "%tmp%\tmp.vbs"
    goto back
)

echo "!input2!" | findstr /r "\." >nul 
if not errorlevel 1 (
    echo :: The file name should not contain a period.
        echo msgbox "[ERROR]: The file name should not contain a period." > "%tmp%\tmp.vbs"
            cscript /nologo "%tmp%\tmp.vbs"
                del "%tmp%\tmp.vbs"
    goto back
)

echo "!input2!" | findstr /r "\/" >nul
if not errorlevel 1 (
    echo :: The file name should not contain a slash.
        echo msgbox "[ERROR]: The file name should not contain a slash." > "%tmp%\tmp.vbs"
            cscript /nologo "%tmp%\tmp.vbs"
                del "%tmp%\tmp.vbs"
    goto back
)

echo "!input2!" | findstr /r "\*" >nul
if not errorlevel 1 (
    echo :: The file name should not contain an asterisk.
        echo msgbox "[ERROR]: The file name should not contain an asterisk." > "%tmp%\tmp.vbs"
            cscript /nologo "%tmp%\tmp.vbs"
                del "%tmp%\tmp.vbs"
    goto back
)

echo "!input2!" | findstr /r "\," >nul
if not errorlevel 1 (
    echo :: The file name should not contain a comma.
        echo msgbox "[ERROR]: The file name should not contain a comma." > "%tmp%\tmp.vbs"
            cscript /nologo "%tmp%\tmp.vbs"
                del "%tmp%\tmp.vbs"
    goto back
)

echo "!input2!" | findstr /r "\;" >nul
if not errorlevel 1 (
    echo :: The file name should not contain a semicolon.
        echo msgbox "[ERROR]: The file name should not contain a semicolon." > "%tmp%\tmp.vbs"
            cscript /nologo "%tmp%\tmp.vbs"
                del "%tmp%\tmp.vbs"
    goto back
)

echo "!input2!" | findstr /r "\:" >nul
if not errorlevel 1 (
    echo :: The file name should not contain a colon.
        echo msgbox "[ERROR]: The file name should not contain a colon." > "%tmp%\tmp.vbs"
            cscript /nologo "%tmp%\tmp.vbs"
                del "%tmp%\tmp.vbs"
    goto back
)

if exist "!input!\!input2!.pwn" ( echo :: found !input2!.pwn ) else if exist "!input!\!input2!.p" ( echo :: found !input2!.p ) else (
    echo :: [ERROR]: No '.pwn' or '.p' =^> !input2! in drive "!input!"..
        echo.
    goto back
)

echo :: Creating system.ini...
(
    echo [General]
        echo ; no effect
            echo win= 
                echo    x86,
                    echo        x64:
                        echo ; end
                    echo.
                echo [Settings]
            echo drive=!input! ; drive - allowed editing in here..
        echo    target=!input2! ; files - allowed editing in here..
    echo ; end
) > "%katanaFile%"

echo.

echo :: Press any key to return . . .
pause >nul

goto next
