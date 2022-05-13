::
:: Name:		Media Streaming Reset.bat
:: Version:		1.0
:: Purpose:		Windows Network Troubleshooting Script to solve Media Streaming Network Related Issues
:: Author:		@dexoidan
:: License:		MIT License
::

@ECHO off
cls
:start
ECHO.
ECHO 1. Reset Winsock ^& Media Streaming
ECHO 2. Network Stack ^& Winsock Reset
ECHO 3. Restart Computer (Close All Programs)
ECHO 4. Exit Program
ECHO 5. Quit Terminal
ECHO.
SET choice=
SET /P choice=Type the number that you want to choose: 
IF NOT '%choice%'=='' set choice=%choice:~0,1%
IF '%choice%'=='1' goto choice1
IF '%choice%'=='2' goto choice2
IF '%choice%'=='3' goto choice3
IF '%choice%'=='4' goto exit
IF '%choice%'=='5' goto closeterminal
ECHO "%choice%" is not a valid option. Please try again.
ECHO.
goto start

:choice1
net session >nul 2>&1
if %errorLevel% == 0 (
	ECHO RESETTING...
	netsh winsock reset >nul
	goto choice3
)
goto end

:choice2
net session >nul 2>&1
if %errorLevel% == 0 (
	ECHO Resetting...
	ipconfig /release >nul
	ipconfig /flushdns >nul
	ipconfig /renew >nul
	netsh int ip reset >nul
	netsh winsock reset >nul
	goto choice3
)
goto end

:choice3
net session >nul 2>&1
if %errorLevel% == 0 (
	shutdown /r /t 3
	goto closeterminal
)
goto exit

:end
ECHO.
ECHO You may be unable to perform the tasks. Please try again.
pause
goto exit

:exit
exit /b 1

:closeterminal
exit