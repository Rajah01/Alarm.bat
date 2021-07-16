@echo off
setlocal
set cnt=0
echo.
for /F "skip=4 tokens=1 delims=~" %%A in ('dir /X "%SystemDrive%\Program Files*"') do call :a "%%A"
goto :eof

:a
if %cnt%==1 goto :eof
set cnt=1
set fn=%1
set fn=%fn:~-7,6%
if "%fn%" NEQ "PROGRA" (
echo POTENTIALLY FATAL ERROR: Your system does not support Short "8.3" directory names.
echo Make SURE critical files are in locations with NO spaces in the "drive:\path\" dir tree:
echo.
echo 	Alarm.bat and bell.exe
echo 	%%TEMP%% files are in "%TEMP%\ALRM\"
echo 	Most executables are in "%SystemRoot%\System32\"
) else echo Everything is OK!
goto :eof
