@echo off
REM To execute as a standalone program, command:  TimeOfDay.bat Parent
setlocal enableDelayedExpansion
set T1=0:Midnight
set T2=329:A.M.
set T3=1159:in the morning
set T4=1200:Noon
set T5=1659:in the afternoon
set T6=1959:in the evening
set T7=2359:at night
for /F "tokens=2 delims==" %%A in ('WMIC.exe os get LocalDateTime /VALUE') do set dt=%%A&set tm=!dt:~8,4!
set cnt=1
:a
if "%tm%"=="" (set tm=0) else if "%tm:~0,1%"=="0" set tm=%tm:~1%&goto :a
:b
for /F "tokens=1,* delims=:" %%A in ("!T%cnt%!") do if %tm% LEQ %%A (set say=%%B) else set /a cnt+=1&goto :b
if %tm% GTR 1259 set /a tm-=1200
if %tm% LSS 100 set /a tm+=1200
if %tm:~-2%==00 (set tm=%tm:~0,-2%&if %tm:~0,-2% NEQ 12 set tm=%tm:~0,-2% o''clock) else (if %tm:~-2,1%==0 (set tm=%tm:~0,-2% o %tm:~-1%) else (set tm=%tm:~0,-2% %tm:~-2%))
powershell.exe -ExecutionPolicy Bypass -Command "Add-Type -AssemblyName System.Speech;(New-Object System.Speech.Synthesis.SpeechSynthesizer).Speak('The time is %tm% %say%')"
if /I "%1X"=="ParentX" (exit /B) else exit
