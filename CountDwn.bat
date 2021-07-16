@echo off
REM Countdown to a 24-hour time TODAY (max=Midnight [="0" or "2400"])
REM Syntax: [d:\path\]Alarm.bat +0 /Rm [/Em] /QQ /P/MIN [d:\path\]CountDwn.bat HHMM
REM 	where [[[H]H]M]M = "countdown TO" time
REM 	/Rm = interval between announcements, in minutes
REM 	/Em = duration of announcements, in minutes (optional)
setlocal
set now=%TIME:~0,2%%TIME:~3,2%
set then=%~1#
if "%~2" NEQ "" (set frq=%~2) else set frq=1
if "%~2" NEQ "" (set frq=%~2) else set frq=1
set ap=A M

::Strip leading zeros
:a
if "%then%"=="#" set then=2400#
if %then:~0,1%==0 set then=%then:~1%&&goto :a
set then=%then:~0,-1%

::Resolve 01-59 (Midnight) settings
set dummy=%then%
if %then% LSS 10 set dummy=0%then%
if %then% LSS 100 set dummy=24%dummy%
set then=%dummy%

:: Avoid octal math issues
set dummy=%then:~-2%
if %dummy:~-2,1%==0 set dummy=%dummy:~-1%
set dummy2=%now:~-2%
if %dummy2:~-2,1%==0 set dummy2=%dummy2:~-1%

::Set remaining minutes
set /a rm=(%then:~0,-2%*60+%dummy%)-(%now:~0,-2%*60+%dummy2%)

::Translate %THEN% into English
if %then:~0,-2% GTR 12 if %then:~0,-2% LSS 24 set ap=P M
if %then:~0,-2% GTR 12 (set /a then=%then:~0,-2%-12) else set then=%then:~0,-2%
if %dummy% GTR 0 (
	if %dummy% LSS 10 (
		set then=%then% OH %dummy%
	) else (
		set then=%then% %dummy%
	)
)

::"Minutes" statement
if %rm% GTR 0 if %rm%==1 (set min=minute remains) else set min=minutes remain
if %rm% LSS 0 if %rm%==-1 (set min2=minute has) else set min2=minutes have

::Set message
if %rm% GTR 0 set msg=%rm% %min% until %then% %ap%
if %rm% EQU 0 set msg=It is ZERO hour: countdown has reached %then% %ap%
if %rm% LSS 0 set msg=%rm:~1% %min2% passed since %then% %ap%
call Alarm.bat +0 /S %msg%
exit
