@echo off
setlocal enableDelayedExpansion
set fn="X"&set er=0
@echo/
for /F "skip=4 tokens=1 delims=~" %%A in ('dir /X "%SystemDrive%\Program Files*"') do if !fn!=="X" call :a "%%A"
exit /B %er%
:a
set fn=%1
if "%fn:~-7,6%"=="PROGRA" @echo 	Everything is OK!&goto :eof
set er=1
@echo POTENTIALLY FATAL ERROR: Your system does not support Short "8.3" directory names.
@echo Make SURE critical files are in locations with NO spaces in the "drive:\path\" dir tree:
@echo/
@echo 	Alarm.bat and bell.exe
@echo 	%%TEMP%% files are in "%TEMP%\ALRM\"
@echo 	Most executables are in "%SystemRoot%\System32\"
goto :eof
