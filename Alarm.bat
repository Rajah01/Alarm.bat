@echo off
setlocal enableExtensions enableDelayedExpansion

rem * USER CONFIGURATION *
rem *** If ANY of these variables, or your CodePage, Locale, or Power Config, are changed, you MUST execute "Alarm.bat /B" before next use! ***

rem Use bell.exe (default; in SAME DIRECTORY as Alarm.bat), or cmd.exe (erase "REM " below)
set exe=bell.exe
REM set exe=cmd.exe

rem Permission to temporarily adjust sound (Volume) level and/or unmute as necessary (On|Off; default=On)
set UnMute=On

rem Threshold Volume level for sound; range 0-100; default=80
rem 	N.B.: Volume is NOT raised if current sound level equal to or greater than this value, or if UnMute=Off
set Volume=80

rem Erase "REM " below to Set a Text-To-Speech (TTS) Voice *DIFFERENT* than your Default Voice (listed FIRST in this Powershell enumeration of available Voice Names)
rem powershell.exe -ExecutionPolicy Bypass -c "Add-Type -AssemblyName System.Speech;$speak=New-Object System.Speech.Synthesis.SpeechSynthesizer;$speak.GetInstalledVoices()|Select-Object -ExpandProperty VoiceInfo|Select-Object -Property Culture,Name,Gender"
REM set Voice=Microsoft David Desktop

rem Delay, in seconds, while numerous commands execute, before destroying the launcher (CPU dependent:
rem   slower computers require more seconds; if you hear fewer than 3 bells, increase the value; default=4)
set Delay=4

rem * END USER CONFIGURATION *

rem ---------------- DO NOT WRITE BELOW THIS LINE! ----------------
set Version=20210805
goto :s
--------
SBCP 437 chars: =" &=delims ANSI: «(ab)=®(ae) »(bb)=¯(af) NBSP  (a0)
:a
set /a udd=100%udd%%%100,umm=100%umm%%%100
set /a z=14-umm,z/=12,y=uyy+4800-z,m=umm+12*z-3,secs=153*m+2
set /a secs=secs/5+udd+y*365+y/4-y/100+y/400-2472633
if 1%uhh% LSS 20 set uhh=0%uhh%
set /a uhh=100%uhh%%%100,unn=100%unn%%%100,uss=100%uss%%%100
set /a secs=secs*86400+uhh*3600+unn*60+uss
goto :eof
:b
set /a secs=%secs%,uss=secs%%60,secs/=60,unn=secs%%60,secs/=60,uhh=secs%%24,udd=secs/24,secs/=24
set /a a=secs+2472632,b=4*a+3,b/=146097,c=-b*146097,c/=4,c+=a
set /a d=4*c+3,d/=1461,e=-1461*d,e/=4,e+=c,m=5*e+2,m/=153,udd=153*m+2,udd/=5
set /a udd=-udd+e+1,umm=-m/10,umm*=12,umm+=m+3,uyy=b*100+d-4800+m/10
(if %umm% LSS 10 set umm=0%umm%)&(if %udd% LSS 10 set udd=0%udd%)
(if %uhh% LSS 10 set uhh=0%uhh%)&(if %unn% LSS 10 set unn=0%unn%)
if %uss% LSS 10 set uss=0%uss%
goto :eof
::DayOfWeek
:c
set dowyy=%1&set dowmm=%2&set dowdd=%3
set /a dowdd=100%dowdd%%%100,dowmm=100%dowmm%%%100
set /a z=14-dowmm,z/=12,y=dowyy+4800-z,m=dowmm+12*z-3,dow=153*m+2
set /a dow=dow/5+dowdd+y*365+y/4-y/100+y/400-2472630,dow%%=7,dow+=1
for /F "tokens=%dow% delims= " %%A in ("Mon Tues Wednes Thurs Fri Satur Sun") do set dow=%%Aday
goto :eof
:d
@set ermsg=BAD "/D" time: specify time 0-2359 *on Alarm day*, and *VALID*, *FUTURE* "/D[d]d[-[m]m[-yy]]" or "/D+#" day&set bad=1&set er=5&goto :r
:e
set ret=%1
if "%ret:~1,1%#"=="#" set ret=0%ret%
goto :eof
:f
set ret=%1
if %ret:~0,1%==0 if "%ret:~1,1%#" NEQ "#" set ret=%ret:~1,1%
set /a %2=%ret%
goto :eof
:g
@for /F "delims=0123456789" %%D in ("%1%2%3") do @if "%%D" NEQ "" goto :d
if "%1#"=="#" goto :d
set fd=%1
call :f %fd% fd
if "%2#" NEQ "#" (set fm=%2) else set fm=%dt:~4,2%
call :f %fm% fm
if "%3#" NEQ "#" (set fy=20%3) else set fy=%dt:~0,4%
if "%t:~0,1%"=="+" goto g:
if %fy% LSS %nwy% goto :d
(if %fm% GTR 12 goto :d)&if %fm% LSS 1 goto :d
(if %fd% GTR 31 goto :d)&if %fd% LSS 1 goto :d
(if %t% GTR 2359 goto :d)&if %t% LSS 0 goto :d
set /a uyy=%fy%,umm=%fm%,udd=%fd%,uhh=%nh%,unn=%nm%,uss=%ns%
call :e %fm%
set fdt=%fy%%ret%
call :e %fd%
set fdt=%fdt%%ret%
%win%xcopy.exe /D:%fm%-%fd%-%fy% /L /Y . .. >NUL 2>&1 || goto :d
if %bad%==1 goto :d
if %dt:~0,8% GTR %fdt% goto :d
call :a
set /a dhm=(%secs%-%orgsecs%)/86400*24
goto :eof
:h
set just1=1
if "%1"=="Image" goto :eof
if exist %TMPA%%fnb% del /F %TMPA%%fnb%
set fnw=%fnb:~0,4%W%fnb:~5%
if exist %TMPA%%fnw% del /F %TMPA%%fnw%
goto :eof
:i
set fnb=%1
for /F "delims=" %%B in ('%win%findstr.exe /bc:"REM " %TMPA%%fnb%') do set rmk=%%B
for /F "delims=" %%B in ('%win%findstr.exe /bc:"rem " %TMPA%%fnb%') do set prevrmk=%%B
set rmk=%rmk:~4%
set prevrmk=%prevrmk:~4%
if "%rptltr%"=="A" goto :eof
if exist %TMPA%ALRMW%fnb:~5,-4%.BAT if exist %win%Tasks\ALRMW%fnb:~5,-4% goto :eof
set just1=0
for /F %%B in ('%tsk% %ex%" /FI "WINDOWTITLE eq %rmk%"') do if !just1!==1 (goto :eof) else call :h %%B
goto :eof
:j
set dummy4=%~1
set dummy4=!dummy4:%ae%=%ab%!
set dummy4=!dummy4:%af%=%bb%!
set %2=%dummy4%
goto :eof
:k
set ret=
set dummy4=!dummy4:/%1=!
for /F "tokens=1,* delims=" %%A in ("%dummy4%") do if "%%B"=="" (set bad=1) else set "ret=%%B"&set "cml=%%A"&set "dummy4=%%A"
:l
if "%ret:~0,1%"==" " set ret=%ret:~1%&goto :l
goto :eof
:m
set dummy5=%~1
if /I %2==d if "%dummy5:~0,1%"=="+" set dummy5=%dummy5:~1%
if "%dummy5:~0,1%"==" " (set bad=1) else set ret=%~1&set "ret=!ret:~0,-1!"
goto :eof
:n
set ret=
set dummy5=!cml:/%1=!
set dummy5=!dummy5:"=!
for /F "tokens=1,* delims=" %%A in ("%dummy5%") do for /F "tokens=1 delims=/ " %%C in ("%%B ") do call :m "%%C " %1
goto :eof
:o
if "%~1"=="" goto :eof
for /F "skip=3 tokens=2 delims= " %%A in ('%tsk% %ex%" /FI "WINDOWTITLE eq %~1"') do if "%%A" NEQ "" %kill%
for /F "skip=3 tokens=2 delims= " %%A in ('%tsk% timeout.exe" /FI "WINDOWTITLE eq %~1"') do if "%%A" NEQ "" %kill%
goto :eof
:p
set /a pos-=2
if "0" LSS "!dt:~%pos%,1!" set %1=!dt:~%pos%,2!&goto :eof
set /a dummy2=%pos%+1
set %1=!dt:~%dummy2%,1!
goto :eof
:q
set ermsg=/W{akes} and /R{epeats} are future, not present (+0), events&set er=6
:r
@echo/&echo   %ermsg%^^^!  Aborting ...
@%cp%&exit /B %er%
--------
:s
set dummy5=0&if exist %~dps0ALRM\ALRMV.txt for /F %%A in (%~dps0ALRM\ALRMV.txt) do if %%A NEQ %Version% set dummy5=1
set cp=REM/&set cml=%~1#&set er=0
if /I "%~1x"=="/Bx" call :ac&if !er!==0 echo/&echo Rebuilt Alarm system variables
if /I "%~1x"=="/Bx" %cp%&exit /B %er%
if exist "%~dps0ALRM\ALRG.bat" (call "%~dps0ALRM\ALRG.bat") else call :ac
if %er% NEQ 0 @%cp%&exit /B %er%
if "%cp%"=="REM/" (set ANSI=REM/) else set ANSI=%cp:~0,-4%^^^^^^^>NUL
for %%A in (allargs dhm hlp) do set %%A=
set kill=%wm% "processid=%%A" delete^>NUL 2^>^&1
set /a autokil=-1,clip=0,dummy2=0,prg=0,spk=0,wake=0
if %~1#==# goto :gc
set cml=%*
set dummy=%cml:"=%
if "%~1x"=="/?x" goto :gc
if /I "%~1x"=="-hx" goto :gc
if /I "%~1x"=="--helpx" goto :gc
if /I "%~1x"=="/Hx" set er=2&echo/&echo Help printed to file "%~dpsn0.txt", q.v.&goto :gc
if not exist %exe% goto :gc
if not exist %TMPA%ALRMV.txt echo %Version%>%TMPA%ALRMV.txt
if /I "%~1x"=="/Tx" goto :tb
if /I "%~1x"=="/Ux" goto :ub
set vw=0
if /I "%~1"=="/V" set vw=1&goto :lb
if /I "%~1"=="/X" goto :lb
::Cancel All
set dummy4=%cml:"=%
if /I "%dummy4:~0,3%"=="/XA" echo/&goto :rb
if %dummy5%==1 set dummy3=%dummy4%&set cml=/XAAN&echo/&@%cp%&goto :rb
::Cancel one e.g. "/X2" (undocumented)
if /I "%dummy4:~0,2%" NEQ "/X" goto :t
set autokil=%dummy4:~2%
set k=%dummy4:~2%
set dummy4=&set kil=1
goto :mb
:t
set w="%TMPA%ALRM.vbs"
if not exist %w% call :bc
set /a plus=-1,pos=14
set nowd=%dt:~0,8%&set nowt=%dt:~8,6%&set otm=%dt:~12,2%&set uyy=%dt:~0,4%
for %%A in (uss unn uhh udd umm) do call :p %%A
set /a nwy=%uyy%,nwn=%umm%,nwd=%udd%,nh=%uhh%,nm=%unn%,ns=%uss%
call :a
set orgsecs=%secs%
set t=%~1
for /F "delims=0123456789+:APMapm" %%A in ("%t%") do if "%%A" NEQ "" set ermsg=Alarm time ("[[[h]h[:]]m]m[A|P[M]]" or "+m") is required. Command "%~nx0 /?" for Help&set er=9&goto :r
set /a bad=0,fncnt=0,len=0,var=0,rptexp=-1,rptintvl=1,rptmins=0
for %%A in (amk bel fdt ffn msg rptA rptfnnum ret tmg) do set %%A=
set repeat=#&set rptfrq=ONCE&set rptltr=N&set torg=%t%
::Delete canceled
if exist %TMPA%ALRMA*.BAT for /F %%A in ('dir /B %TMPA%ALRMA*.BAT') do call :i %%A
::Alarm filename
:u
set dummy=0
if exist %TMPA%ALRMA%fncnt%.BAT set dummy=1&for /F "delims=" %%B in ('%win%findstr.exe /bc:"REM " %TMPA%ALRMA%fncnt%.BAT') do set amk=%%B
if %dummy%==1 set amk=%amk:~4%
if %dummy%==1 for /F "skip=3 tokens=2 delims= " %%A in ('%tsk% %ex%" /FI "WINDOWTITLE eq %amk%"') do if "%%A" NEQ "" set dummy=3
if %dummy% LSS 3 if exist %TMPA%ALRMW%fncnt%.BAT set dummy=2
if %dummy%==2 %win%schtasks.exe /query /tn "ALRMW%fncnt%" >NUL 2>&1
if %dummy%==2 if %errorlevel%==0 set dummy=3
if %dummy% LSS 3 (
	if exist %TMPA%ALRM?%fncnt%.BAT del %TMPA%ALRM?%fncnt%.BAT
	set fn=%TMPA%ALRMA%fncnt%.BAT
) else set /a "fncnt+=1"&set rmk=&goto :u
set dummy4=%cml:"=%
for /F "tokens=2 delims= " %%A in ("%dummy4%") do if "%%A#"=="#" goto :ha
if "%dummy4%"=="%dummy4:/p=%" goto :v
call :k p
if %bad%==1 set ermsg=No program defined&set er=10&goto :r
set prg=2&set bel= /QQ&set allargs=/P%ret%&goto :x
:v
if "%dummy4%"=="%dummy4:/f=%" goto :w
call :k f
if %bad%==1 set ermsg=No filename given&set er=11&goto :r
if not exist "%ret:=%" set ermsg=File "%ret:=%" not found&set er=12&goto :r
set allargs=/F%ret%
set prg=1&set ffn=%ret%
:w
if "%dummy4%" NEQ "%dummy4:/c=%" for /F "tokens=1 delims=" %%A in ("!dummy4:/c=!") do set "cml=%%A"&set "dummy4=%%A"&set clip=1&set prg=1&set allargs=/C
:x
if "%dummy4%"=="%dummy4:/d=%" goto :y
if %dummy4:~0,1%==+ goto :d
call :n d
if %bad%==1 goto :d
set fdt=%ret%
if "%fdt:~8,1%#" NEQ "#" goto :d
if "%fdt:~0,1%"=="+" set plus=-3&set fdt=%fdt:~1%
for /F "delims=0123456789-" %%A in ("%fdt%") do if "%%A" NEQ "" goto :d
set wake=1
if %plus%==-3 set /a "dhm=%fdt%*24"&goto :y
set /a plus=-3,bad=0
for /F "tokens=1-3 delims=-" %%A in ("%fdt%") do call :g %%A %%B %%C
if %bad%==1 exit /B %er%
:y
if "%dummy4%"=="%dummy4:/q=%" goto :z
if "%dummy4%" NEQ "%dummy4:/qqq=%" set bel= /QQQ&goto :z
if "%dummy4%" NEQ "%dummy4:/qq=%" (set bel= /QQ) else set bel= /Q
:z
if "%dummy4%" NEQ "%dummy4:/w=%" set wake=1
if "%dummy4%" NEQ "%dummy4:/s=%" (
	set spk=1
	if %prg%==0 set prg=1
	if "%bel%"=="" set bel= /QQ
)
if %plus%==-2 goto :ha
if %spk%==1 if %clip%==1 set clip=2&set prg=2&set spk=2&if "%bel%"=="" set bel= /QQ
if "%t%"=="+0" if %wake%==1 goto :q
if "%dummy4%"=="%dummy4:/r=%" if "%dummy4%"=="%dummy4:/e=%" (goto :fa) else set ermsg=Missing "/Rm" m{inutes} interval&set er=13&goto :r
if "%dummy4%"=="%dummy4:/rr=%" goto :aa
call :n rr
set rptltr=A&for /F "tokens=1,2 delims=-" %%A in ("%ret%") do set rptfnnum=%%A&set rptmins=%%B
if exist %TMPA%ALRMA%rptfnnum%.BAT call :i ALRMA%rptfnnum%.BAT
if %prg%==0 if exist %TMPA%ALRMA%rptfnnum%.BAT del %TMPA%ALRMA%rptfnnum%.BAT
goto :ba
:aa
call :n r
if %bad%==1 set ermsg=Missing "/Rm" m{inutes} interval&set er=14&goto :r
for /F "delims=0123456789" %%A in ("%ret%") do if "%%A" NEQ "" set ermsg=Non-numeric "/Rm" m{inutes} interval "%ret%"&set er=15&goto :r
set rptltr=R&set rptmins=%ret%&set rptfnnum=%fncnt%&set wake=1&set repeat= /R%rptmins%
if "%t%"=="+0" if %wake%==1 goto :q
if %rptmins%==0 set ermsg=/R0 does not Repeat&set er=16&goto :r
::Taskschd minutes over 9999 must be divisible by 60
set dummy2=0
if %rptmins% GTR 9999 set /a dummy2=%rptmins%%%60&if !dummy2! GTR 0 set /a rptmins=%rptmins%+(60-!dummy2!)
if %rptmins% LSS 2 (goto :ba) else set rptintvl=%rptmins%
if %rptmins% GTR 40320 set ermsg=Out of bounds: /R value range=1-40320 minutes (Repeat every month)&set er=17&goto :r
if %rptintvl% GTR 10080 (set rptfrq=MONTHLY&goto :ba) else if %rptintvl% GTR 1440 (set rptfrq=WEEKLY&goto :ba) else if %rptintvl%==1440 (set rptfrq=DAILY&goto :ba) else set rptfrq=ONCE
:ba
set rptA= /RR%rptfnnum%-%rptmins%
if "%rptltr%#" NEQ "A#" goto :ca
if not exist %TMPA%ALRME%rptfnnum%.txt goto :ea
for /F "tokens=1 delims=#" %%A in (%TMPA%ALRME%rptfnnum%.txt) do set /a dummy4=%%A-%rptmins%
if %dummy4% LSS 1 (set rptexp=0) else set rptexp=%dummy4%
goto :da
:ca
if "%dummy4%"=="%dummy4:/e=%" goto :ea
call :n e
if %bad%==1 set ermsg=Missing "/Em" m{inutes} expiration&set er=18&goto :r
for /F "delims=0123456789" %%A in ("%ret%") do if "%%A" NEQ "" set ermsg=Non-numeric "/Em" m{inutes} expiration "%ret%"&set er=19&goto :r
if %ret% LSS %rptmins% set ermsg=Expiration "/E%ret%" precedes repeat interval "/R%rptmins%" ^(/E#=minutes after HHMM^)&set er=20&goto :r
set /a rptexp=%ret%+1
:da
if %rptexp% GTR 0 echo %rptexp%#>%TMPA%ALRME%rptfnnum%.txt
:ea
if %spk% GTR 0 set rptA= /S%rptA%
:fa
if "%ffn%" NEQ "" if %spk%==1 set prg=2&set spk=2&if "%bel%"=="" set bel= /QQ
::GetMessage
if %clip%==1 goto :ha
if "%ffn%" NEQ "" goto :ha
if %prg%==2 goto :ha
:ga
if "%~2#"=="#" goto :ha
set dummy4=%2
set dummy4=%dummy4:"=%
if "%dummy4:~0,1%#"=="/#" shift /2&goto :ga
set dummy=%cml:"=%
for /F "tokens=1 delims=" %%A in ("!dummy: %dummy4%= %dummy4%!") do set dummy4=%%A#
for %%A in (64 32 16 8 4 2 1) do @if "!dummy4:~%%A,1!" NEQ "" set /a "len+=%%A"&set "dummy4=!dummy4:~%%A!"
set msg=!dummy:~%len%!
set msg=%msg:=%
if "%msg%" NEQ "%msg:`v=%" set var=1
set len=0&set dummy4=%msg%#
for %%A in (4096 2048 1024 512 256 128 64 32 16 8 4 2 1) do @if "!dummy4:~%%A,1!" NEQ "" set /a "len+=%%A"&set "dummy4=!dummy4:~%%A!"
if %prg%==0 if %len% GTR 0 set prg=1
:ha
set ret=0
if /I "%bel%"==" /Q" if %wake%==0 if %clip%==0 if "%ffn%"=="" if %prg%==0 if %len%==0 set ret=1
if %spk% GTR 0 (
	if %wake%==0 if %clip%==0 if "%ffn%"=="" if %prg%==1 if %len%==0 set ret=1
	if /I "%bel%"==" /Q" set ret=1
)
if %ret%==1 set ermsg=Nonsensical, incompatible, or inconsequential command&set er=21&goto :r
if %len%==0 goto :ia
if %prg%==2 goto :ia
if %len% GTR 100 (set tmg=: %ae%%msg:~0,100% ...%af%) else set tmg=: %ae%%msg%%af%
::Now time
:ia
if "%msg%" NEQ "" set allargs=%msg%
::Alarm time
set dummy=%t::=%
set t=
:ja
if "%dummy:~-1%"=="" goto :ka
set t=%dummy:~-1%%t%
set dummy=%dummy:~0,-1%
goto :ja
:ka
if "%t%"=="%t:+=%" goto :la
set "plus=%t:~1%"
for /F "delims=0123456789" %%A in ("%plus%X") do if "%%A" NEQ "X" set ermsg=BAD TIME: "%~1"&set er=22&goto :r
goto :ma
:la
if "%t:~0,1%"=="0" if %t% NEQ 0 set t=%t:~1%&goto :la
set ap=%t:~-1%
if /I %ap%==M set ap=%t:~-2,1%&set t=%t:~0,-1%
if /I %ap%==A set t=%t:~0,-1%
if /I %ap%==P set t=%t:~0,-1%
for /L %%A in (1,1,3) do if "!t:~3!x"=="x" set t=0!t!
if "%t:~3%x"=="x" set t=
for /F "delims=0123456789" %%A in ("%t%X") do if "%%A" NEQ "X" set ermsg=BAD TIME: "%~1"&set er=23&goto :r
set tm=%t:~-2,2%
call :f %tm% tm
set th=%t:~0,-2%
call :f %th% th
if /I %ap%==A (if %th%==12 set th=0)&(if %th%==24 set th=0)
if /I %ap%==A if %th% LEQ %nh% if %tm% LEQ %nm% set /a th+=24
if /I %ap%==P if %th%==24 set th=0
set /a thmod=%th%%%24
if /I %ap%==P if %thmod% LSS 12 if %thmod% GTR 0 set /a th+=12
if /I %ap%==A if %thmod% GTR 11 set ermsg=BAD TIME: "AM" alarm after 11:59 hours&set er=24&goto :r
if /I %ap%==P if %th% LEQ %nh% if %tm% LEQ %nm% set /a th+=24
::Differential in seconds
:ma
if %rptltr%==A set /a plus+=%rptmins%
if %plus%==-3 set /a th=%th%+%dhm% &set plus=-1
if %plus% GTR -1 set /a th=%nh%,tm=%nm%+%plus%&goto :na
if %th% LSS %nh% set /a th+=24
if %th%==%nh% if %tm% LEQ %nm% set /a th+=24
if %tm% LSS %nm% set /a tm+=60,th-=1
:na
set /a th=(%tm%*60+%th%*60*60)/3600,tm=%tm%%%60
set /a h=%th%-%nh%,m=%tm%-%nm%
::Timeout
if %plus% GTR -1 (set /a s=%t:~1%*60) else set /a s=(%h%*60+%m%)*60-%ns%
::Info
if %m% LSS 0 set /a m+=60,h-=1
set /a days=0,mod=%s%%%60
if %mod% NEQ 0 if %mod% LSS 30 set /a m-=1
if %s% LSS 60 set m=0
if %plus% GTR -1 set m=%t:~1%
if %tm%==60 set /a th+=1,tm=0
if %th% GTR 23 set /a days=%th%/24,th=%th%%%24
set ah=%th%
if %tm% LSS 10 set tm=0%tm%
set /a s1=%s%,m1=%m%,h1=%h%
if %wake%==0 goto :ra
::Wake code
call :f %dt:~4,2% m
call :f %dt:~6,2% d
:: What does this add? Sets m=m etc, uses y which is meaningless?
::set /a %dtfmt:~0,1%=!%dtfmt:~0,1%!
::set /a %dtfmt:~1,1%=!%dtfmt:~1,1%!
::set /a %dtfmt:~2,1%=!%dtfmt:~2,1%!
::ECHO m=%m% d=%d% y=%y% uyy=%uyy% nwy=%nwy%
set waketh=%ah%
if %days% GTR 0 set /a waketh=%ah%+24*%days%
if %waketh% LSS 10 set waketh=0%waketh%
set waketh=%waketh%%tm%
if %plus% GTR -1 set /a secs=%orgsecs%+(%plus%*60)&goto :oa
call :f %ah% dummy1
call :f %tm% dummy2
if %waketh% GTR 2359 (set /a uyy=%nwy%,umm=%nwn%,udd=%nwd%,uhh=23,unn=59,uss=59) else set /a uyy=%nwy%,umm=%nwn%,udd=%nwd%,uhh=%dummy1%,unn=%dummy2%,uss=0
call :a
if %waketh% LSS 2400 goto :oa
set /a dummy=%waketh%%%2400
set /a dummy2=(%dummy%/100)*3600
set /a dummy3=%dummy%%%100*60+%dummy2%
set /a secs=%dummy3%+%secs%+1,dummy2=%waketh%/2400
if %dummy2% GTR 1 set /a secs+=(%dummy2%-1)*86400
:oa
call :f %secs% secs1
call :b
set orgtime=%uyy%-%umm%-%udd%T%uhh%:%unn%:%uss%
call :f %uss% orguss
set /a secs=%secs1%+120-%orguss%
call :b
set strtact1=%uhh%:%unn%:%uss%
if %dtfmt%==mdy set strtdt=%umm%%dtsep%%udd%%dtsep%%uyy%&goto :pa
if %dtfmt%==dmy set strtdt=%udd%%dtsep%%umm%%dtsep%%uyy%&goto :pa
if %dtfmt%==ymd set strtdt=%uyy%%dtsep%%umm%%dtsep%%udd%
:pa
set strtact2=%uyy%-%umm%-%udd%T%uhh%:%unn%:00
set /a secs=%secs1%+180-%orguss%+%rptmins%*60
call :b
set endact1=%uhh%:%unn%:00
set /a dur=%rptmins%+1
if %dur% LSS 10 set dur=00:0%dur%&goto :qa
if %dur% LSS 60 set dur=00:%dur%&goto :qa
set /a dummy=%dur%/60,dummy2=%dur%%%60
if %dummy% LSS 10 set dummy=0%dummy%
if %dummy2% LSS 10 set dummy2=0%dummy2%
set dur=%dummy%:%dummy2%
:qa
set endact2=%uyy%-%umm%-%udd%T%uhh%:%unn%:00
set /a secs=%secs1%+%Delay%
call :b
set endact3=%uyy%-%umm%-%udd%T%uhh%:%unn%:%uss%
if %rptexp%==-1 goto :ra
set /a secs=%secs1%+%Delay%+60*(%rptexp%-1)
call :b
set endact3=%uyy%-%umm%-%udd%T%uhh%:%unn%:%uss%
:ra
if %th% LSS 10 set th=0%th%
for %%A in (hours minutes) do set %%A=
if %h1% GTR 0 set hours=%h1% hour&if %h1% GTR 1 set hours=!hours!s
if %plus% GTR -1 if %h1% GTR 0 if %m1% GTR 59 set /a m1=%m1%%%(%h1%*60)
if %m1% GTR 0 set minutes=%m1% minute
if %h1% GTR 0 if %m1% GTR 0 set minutes= %minutes%
if %m1% GTR 1 set minutes=%minutes%s
if "%fdt%"=="%nowd%" if %th%%tm%%otm% LSS %nowt% goto :d
if %plus% GTR -1 (set msg=Alarm  at %th%%tm%.%otm%) else set msg=Alarm  at %th%%tm%.00
if "%rmk%" NEQ "" set msg=%rmk:~0,6% %msg:~7%
set msg=%msg% hours:
if %ah% LSS 12 (set dummy=a) else set dummy=p
if %ah% GTR 12 set /a ah-=12
if %ah%==0 set ah=12
if %ah% LSS 10 (set msg=%msg%  %ah%) else set msg=%msg% %ah%
if %plus% GTR -1 (set msg=%msg%:%tm%.%otm%%dummy%m) else set msg=%msg%:%tm%.00%dummy%m
if %torg% NEQ +0 if %days% GTR 0 set msg=%msg%+%days% day&if %days% GTR 1 set msg=!msg!s
set dummy=%msg%&set rmsg=%msg%&set tmg=%msg%%tmg%
if %wake%==1 if %rptltr%==N (set tmg=Wake  %tmg:~6%) else set tmg=Repeat%tmg:~6%
set msg=%msg% (%s1% seconds
set dummy3=0
if %m1% GTR 0 (set dummy3=1) else if %h1% GTR 0 set dummy3=1
if %dummy3%==1 if %mod%==0 (set msg=%msg%, %hours%%minutes%) else set msg=%msg%, ñ%hours%%minutes%
set msg=%msg%^^^)
if /I "%UnMute%"=="On" if not exist %TMPA%ALRM.ps1 call :cc
if %wake%==0 goto :write
::Wake
@for /F "tokens=1,4 delims= " %%A in ('%win%sc.exe query "Schedule"') do @if /I "%%A"=="STATE" if /I "%%B" NEQ "RUNNING" %win%sc.exe start "Schedule"
if not exist %TMPA%ALRM.exe call :ec
if %er% GTR 0 goto :r
::ALRMW
set dummy=
set k=%TMPA%ALRMW%fncnt%.bat
echo @echo off>%k%
echo setlocal>>%k%
if %rptltr% NEQ N if "%repeat:~0,3%#"==" /R#" set dummy=%repeat:~3%
echo %TMPA%ALRM.exe>>%k%
if %rptltr% NEQ N goto :ta
call :j "%tmg%" dummy4
echo for /F "tokens=1 delims= " %%%%A in ^('%tsk% %ex%" /FI "WINDOWTITLE eq %tmg%"'^) do if "%%%%A"=="Image" for /F "skip=3 tokens=2 delims= " %%%%B in ^('%tsk% %ex%" /FI "WINDOWTITLE eq %tmg%"'^) do if "%%%%B" NEQ "" %wm% "processid=%%%%B" delete^>NUL 2^>^&1 >>%k%
if %prg%==0 echo call %~fs0 +0%bel% %allargs% >>%k%
if %prg% NEQ 1 goto :sa
if %spk%==0 if %clip%==0 echo call %~fs0 +0%bel% %allargs% >>%k%
if %spk%==1 if "%ffn%" NEQ "" echo call %~fs0 +0%bel% %allargs% >>%k%
if %spk%==1 if "%ffn%"=="" if %clip%==0 echo %~fs0 +0%bel% /S %allargs% >>%k%
if %clip%==1 echo call %~fs0 +0%bel% %allargs%>>%k%
:sa
if %prg%==2 if %spk% LSS 2 echo call %~fs0 +0%bel% %allargs:="% >>%k%
if %prg%==2 if "%bel%" NEQ "" if %spk%==2 echo call %~fs0 +0%bel% /S %allargs:="% >>%k%
echo ^(goto^) 2^>NUL^&if exist %TMPA%ALRMA%fncnt%.BAT del /F %TMPA%ALRMA%fncnt%.BAT>>%k%
goto :ua
:ta
if "%allargs%"=="" (set dummy3=) else set dummy3=%allargs:="%
if "%bel%"=="" echo start /MIN %win%cmd.exe /c %~fs0 +0%rptA% %dummy3% >>%k%
if "%bel%"=="" goto :ua
echo start "Wake/Repeat-%fncnt%" /MIN %exe% /c %~fs0 +0%rptA%%bel% %dummy3% >>%k%
:ua
if %rptltr%==R (
	@echo exit>>%k%
	set du= /du %dur%
	set et=
) else (
	set du=
	set et= /et %endact1%
)
if %ver% LSS 10 (
	set rptmins=1
	if %rptltr%==N set du= /du 0000:02
	set et=
)
::"/rl HIGHEST"=Title "Administator: ..." AND requires permission
if %rptltr%==N "%win%schtasks.exe" /create /sc %rptfrq% /tn ALRMW%fncnt% /tr "%ComSpec% /c start %exe% /c %k%" /st %strtact1%%et% /sd %strtdt% /ri %rptmins%%du% >NUL
if %rptltr% NEQ N "%win%schtasks.exe" /create /sc %rptfrq% /tn ALRMW%fncnt% /tr "%exe% /c call %k%&exit" /st %strtact1%%et% /sd %strtdt% /ri %rptmins%%du% >NUL
"%win%schtasks.exe" /query /tn ALRMW%fncnt% /xml >%TMPA%ALRMW%fncnt%.xml
set w="%TMPA%ALRMW%fncnt%.vbs"
echo Dim fn,txt,pos1,pos2,pos3 >%w%
echo fn="%TMPA%ALRMW%fncnt%.xml">>%w%
echo Set objFSO=CreateObject("Scripting.FileSystemObject")>>%w%
echo Set objFile=objFSO.OpenTextFile(fn,1)>>%w%
echo txt=objFile.ReadAll>>%w%
echo objFile.Close>>%w%
echo txt=Replace(txt,"Batteries>true","Batteries>false")>>%w%
if %rptltr%==R (
	echo If InStr^(1,txt,"<Hidden>false</Hidden>",1^)^>0 Then>>%w%
	echo 	txt=Replace^(txt,"<Hidden>false</Hidden>","<Hidden>true</Hidden>"^)>>%w%
	echo Else>>%w%
	echo 	txt=Replace^(txt,"    <MultipleIns","    <ExecutionTimeLimit>PT0S</ExecutionTimeLimit>" ^& vbCr ^& vbCrLf ^& "    <Hidden>true</Hidden>" ^& vbCr ^& vbCrLf ^& "    <MultipleIns"^)>>%w%
	echo End If>>%w%
)
if %rptltr%==N echo txt=Replace(txt,"  <Settings>","  <Settings>" ^& vbCr ^& vbCrLf ^& "    <DeleteExpiredTaskAfter>PT0S</DeleteExpiredTaskAfter>")>>%w%
if %rptltr%==R if %rptexp% GTR -1  echo txt=Replace(txt,"  <Settings>","  <Settings>" ^& vbCr ^& vbCrLf ^& "    <DeleteExpiredTaskAfter>PT0S</DeleteExpiredTaskAfter>")>>%w%
echo txt=Replace(txt,"    <WakeToRun>false</WakeToRun>" ^& vbCr ^& vbCrLf,"")>>%w%
echo txt=Replace(txt,"<IdleSettings>" ^& vbCr ^& vbCrLf ^& "      <Duration>PT10M</Duration>" ^& vbCr ^& vbCrLf ^& "      <WaitTimeout>PT1H</WaitTimeout>","<WakeToRun>true</WakeToRun>" ^& vbCr ^& vbCrLf ^& "    <IdleSettings>")>>%w%
if %rptltr%==R if %rptfrq% NEQ MONTHLY if %rptfrq% NEQ WEEKLY (
	echo pos1=InStr^(1,txt,"Repetition"^)>>%w%
	echo pos2=InStr^(pos1,txt,"Duration"^)-4 >>%w%
	echo pos1=InStr^(pos2,txt,"/Repetition"^)-1 >>%w%
	echo txt=Mid^(txt,1,pos2^) ^& Mid^(txt,pos1^)>>%w%
)
if %ver% LSS 10 if %rptltr%==N (
	echo pos1=InStr^(1,txt,"Repetition"^)-1 >>%w%
	echo pos2=InStr^(pos1,txt,"StartBoundary"^)>>%w%
	echo txt=Mid^(txt,1,pos1^) ^& Mid^(txt,pos2^)>>%w%
)
set dummy4=0
if %rptfrq%==MONTHLY (
	set dummy4=1
	echo Set regexp=CreateObject^("VBScript.RegExp"^)>>%w%
	echo regexp.Pattern="<Day>(\d+)</Day>">>%w%
	if %udd% LSS 28 echo txt=regexp.Replace^(txt,"<Day>%udd%</Day>"^)>>%w%
	if %udd% GTR 27 echo txt=regexp.Replace^(txt,"<Day>Last</Day>"^)>>%w%
)
if %rptfrq%==WEEKLY call :c %uyy% %umm% %udd%
if %rptfrq%==WEEKLY (
	set dummy4=1
	echo Set regexp=CreateObject^("VBScript.RegExp"^)>>%w%
	echo regexp.Pattern="\b(\w+)day\b">>%w%
	echo txt=regexp.Replace^(txt,"%dow%"^)>>%w%
)
if %dummy4%==1 (
	echo pos1=InStr^(1,txt,"<Repetition>"^)>>%w%
	if %rptfrq%==MONTHLY echo pos2=InStr^(pos1,txt,"<ScheduleByMonth>"^)+1 >>%w%
	if %rptfrq%==WEEKLY echo pos2=InStr^(pos1,txt,"<ScheduleByWeek>"^)+1 >>%w%
	echo txt=Mid^(txt,1,pos1^) ^& Mid^(txt,pos2^)>>%w%
)
if %rptexp% GTR -1 echo txt=Replace(txt,"<Repetition>","<Repetition>" ^& vbCr ^& vbCrLf ^& "        <Duration>PT%rptexp%M</Duration>"^)>>%w%
echo txt=Replace(txt,"<StartBoundary>%strtact2%</StartBoundary>","<StartBoundary>%orgtime%</StartBoundary>")>>%w%
if %rptltr%==N call :j "%tmg%" dummy3
:: Insert Ascii-160 within dummy3, to differentiate ALRMW from ALRMA: replace space after Repeat
set dummy3=%dummy3:~0,6%%a0%%dummy3:~7%
if %rptltr%==N echo txt=Replace(txt,"<Arguments>/c start","<Arguments>/c start &quot;%dummy3%&quot; /MIN")>>%w%
if %rptltr% NEQ R (
	echo If InStr^(1,txt,"<EndBoundary>%endact2%</EndBoundary>",1^)^>0 Then>>%w%
	echo 	txt=Replace^(txt,"<EndBoundary>%endact2%</EndBoundary>","<EndBoundary>%endact3%</EndBoundary>"^)>>%w%
	echo Else>>%w%
	echo 	txt=Replace^(txt,"</StartBoundary>","</StartBoundary>" ^&vbCr ^& vbCrLf ^& "      <EndBoundary>%endact3%</EndBoundary>"^)>>%w%
	echo End If>>%w%
)
if %rptltr%==R if %rptexp% GTR -1 echo txt=Replace(txt,"</StartBoundary>","</StartBoundary>" ^& vbCr ^& vbCrLf ^& "      <EndBoundary>%endact3%</EndBoundary>")>>%w%
echo Set objFile=objFSO.OpenTextFile(fn,2)>>%w%
echo objFile.Write txt >>%w%
echo objFile.Close>>%w%
echo Wscript.Quit>>%w%
"%win%cscript.exe" //Nologo %w%
"%win%schtasks.exe" /create /tn ALRMW%fncnt% /xml "%TMPA%ALRMW%fncnt%.xml" /f >NUL
del /F %w%
del /F "%TMPA%ALRMW%fncnt%.xml"
:Write
setlocal disableDelayedExpansion
echo @echo off >%fn%
echo REM %tmg%>>%fn%
echo rem %tmg%>>%fn%
if %wake%==1 if "%rptltr%" NEQ "A" (
	echo pause^>NUL>>%fn%
	echo ^(goto^) 2^>NUL^&if exist %fn% del /F %fn%>>%fn%
	goto :ab
)
echo setlocal>>%fn%
if %rptltr%==N if %s% GTR 0 (
	echo set t=%s% >>%fn%
	if %s% GTR 99999 (
		if %s% GTR 199998 echo :#>>%fn%
		echo %to% 99999 ^>NUL>>%fn%
		echo set /a t-=99999 >>%fn%
		if %s% GTR 199998 echo if %%t%% GTR 99999 goto :#>>%fn%
	)
	echo %to% %%t%% ^>NUL>>%fn%
)
if /I "%bel%"==" /QQ" set bel= /Q&echo %pw% -file "%TMPA%ALRM.ps1" -snd 1 -vol %vol%>>%fn%
set ps=0
if /I %UnMute%==On if /I "%bel%" NEQ " /Q" (
	set ps=1
	echo %pw% -file "%TMPA%ALRM.ps1" -snd 1 -vol %vol%>>%fn%
	if %spk%==0 echo set e=%%errorlevel%% >>%fn%
)
::Can't set dummy2 for spk=1 because shuts off sound before speech is finished
if /I "%bel%" NEQ " /Q" if %ps%==1 if %spk%==0 (
	echo if %%e:~0,1%%==1 set dummy2=^&goto :[>>%fn%
	echo ^(set s=%%e:~1%%^)>>%fn%
	echo if %%s%%==0 ^(set vol=0^) else if %%s%%==100 ^(set vol=1.00^) else ^(set vol=0.%%s%%^)>>%fn%
	echo set dummy2=%pw% -file "%TMPA%ALRM.ps1" -snd %%e:~0,1%% -vol %%vol%%>>%fn%
	echo :[>>%fn%
)
if %prg%==0 if "%rptltr%" NEQ "N" @echo start "%rmsg%" /MIN %exe% /c %to% %Delay% /NOBREAK ^^^>NUL>>%fn%
if "%rmk%"=="" (set dummy3=%tmg%) else set dummy3=%rmk%
call :j "%dummy3%" dummy4
if "%rmk%" NEQ "%prevrmk%" call :j "%prevrmk%" dummy5
if %spk%==0 if %prg%==1 for /F "usebackq" %%A in (`%wm% "caption='more.com' and commandline like '%%%%ALRMC%fncnt%.txt%%%%'" get processid 2^>^&1`) do @for /F "delims=0123456789" %%D in ("%%AX") do @if "%%D"=="X" %kill%
if %var%==1 for /F "tokens=*" %%A in ('%cs% "%allargs%" "M" %fncnt%') do for /F "tokens=*" %%B in ("%%A") do set allargs=%%B
if %spk%==0 if %prg%==1 if %rptltr%==N (
	if %clip%==1 (
		echo start "%tmg%" %exe% /c %cs% %fncnt% "C"^^^&echo/^^^&echo/^^^&%ANSI%^^^&%mr% "%TMPA%ALRMC%fncnt%.txt"^^^&pause^^^>NUL>>%fn%
	) else (
		if "%ffn%" NEQ "" (
			echo start "%tmg%" %exe% /c echo/^^^&echo/^^^&%ANSI%^^^&%mr% "%ffn:=%"^^^&echo/^^^&echo/^^^&echo 			    ^^^^^^^< Hit any key to Dismiss ^^^^^^^>^^^&pause^^^>NUL>>%fn%
		) else (
			if %wake%==0 echo start "%tmg%" %exe% /c echo/^^^&echo/^^^&%ANSI%^^^&%cs% "%allargs%" "M" %fncnt%^^^&%mr% "%TMPA%ALRMC%fncnt%.txt"^^^&pause^^^>NUL>>%fn%
			if %wake%==1 echo start "%dummy4%" %exe% /c echo/^^^&echo/^^^&%ANSI%^^^&%cs% "%allargs%" "M" %fncnt%^^^&%mr% "%TMPA%ALRMC%fncnt%.txt"^^^&pause^^^>NUL>>%fn%
		)
	)
)
if %spk%==0 if %prg%==1 if %rptltr% NEQ N (
	if %clip%==0 (
		if "%ffn%"=="" (
			echo start "%dummy3%" %exe% /c echo/^^^&echo/^^^&%ANSI%^^^&%cs% "%allargs%" "M" %fncnt%^^^&%mr% "%TMPA%ALRMC%fncnt%.txt"^^^&pause^^^>NUL^^^&exit>>%fn%
		) else (
			echo start "%tmg%" %exe% /c echo/^^^&echo/^^^&%ANSI%^^^&%mr% "%ffn:=%"^^^&echo/^^^&echo/^^^&echo 			    ^^^^^^^< Hit any key to Dismiss ^^^^^^^>^^^&pause^^^>NUL>>%fn%
		)
	) else echo start "%dummy3%" %exe% /c echo/^^^&echo/^^^&%ANSI%^^^&%cs% %fncnt% "C"^^^&%mr% "%TMPA%ALRMC%fncnt%.txt"^^^&pause^^^>NUL^^^&exit>>%fn%
	
)
set dummy6="%TMPA%ALRMR%rptfnnum%.BAT"
if %rptltr%==A (
	if exist %dummy6% del /F %dummy6%
	call :o "%rmk%"
	call :o "%prevrmk%"
	if %prg%==1 call :o "%dummy4%"
	if defined dummy5 call :o "%dummy5%"
)
if exist %dummy6% del /F %dummy6%
if %rptltr% NEQ A goto :xa
echo @echo off>%dummy6%
if %rptexp%==0 goto :va
echo start "%tmg%" /MIN %exe% /c echo/^^^&echo/^^^&pause^^^>NUL>>%dummy6%
echo echo @echo off^>"%TMPA%ALRMA%rptfnnum%.BAT">>%dummy6%
echo @echo REM %tmg%^>^>"%TMPA%ALRMA%rptfnnum%.BAT">>%dummy6%
echo @echo rem %rmk%^>^>"%TMPA%ALRMA%rptfnnum%.BAT">>%dummy6%
echo @echo pause^>NUL^>^>"%TMPA%ALRMA%rptfnnum%.BAT">>%dummy6%
echo @echo ^^^(goto^^^) 2^^^>NUL^^^&if exist "%TMPA%ALRMA%rptfnnum%.BAT" del /F "%TMPA%ALRMA%rptfnnum%.BAT"^>^>"%TMPA%ALRMA%rptfnnum%.BAT">>%dummy6%
if %rptexp%==-1 goto :xa
if %rptexp% GTR 0 goto :wa
::If %rptexp%=0: NOT called if not ALRMR
:va
echo if exist "%TMPA%ALRME%rptfnnum%.txt" del /F "%TMPA%ALRME%rptfnnum%.txt">>%dummy6%
set /a dummy4=30-%Delay%*2
echo %to% %dummy4% /NOBREAK^>NUL>>%dummy6%
echo %win%schtasks.exe /delete /tn ALRMW%rptfnnum% /F>>%dummy6%
echo if exist "%TMPA%ALRMC%fncnt%.txt" del /F "%TMPA%ALRMC%fncnt%.txt">>%dummy6%
echo if exist "%TMPA%ALRMW%rptfnnum%.bat" del /F "%TMPA%ALRMW%rptfnnum%.bat">>%dummy6%
echo start /MIN %exe% /c %~fs0 /X%rptfnnum% >>%dummy6%
:wa
echo exit>>%dummy6%
:xa
if %spk%==1 if /I "%bel%" NEQ " /QQQ" goto :ya
if /I "%bel%"==" /Q" goto :ya
if /I "%bel%"==" /QQ" goto :ya
echo for %%%%A in (2 1 2) do echo ^&%to% %%%%A /NOBREAK^>NUL>>%fn%
:ya
if %prg% NEQ 2 goto :za
if %spk%==2 goto :za
if "%allargs%" NEQ "" set allargs=%allargs:/P=%
if "%allargs%" NEQ "" set allargs=%allargs:="%
if %ps%==0 echo start "%dummy%" %allargs% >>%fn%
if %ps%==1 echo start "%dummy%" /WAIT %allargs%^&%%dummy2%% >>%fn%
echo ^(goto^) 2^>NUL^&if exist "%%~dpsnx0" del /F "%%~dpsnx0">>%fn%
goto :ab
:za
if %spk%==1 echo %to% 1 /NOBREAK^>NUL>>%fn%
if %spk%==1 if %rptltr% NEQ R echo start /MIN %cs% "%allargs%" "S" "%voice%">>%fn%
if %clip%==0 if %spk%==2 if %rptltr% NEQ R echo start /MIN %pw% -c "Add-Type -AssemblyName System.Speech;$words=(Get-Content '%ffn:=%');$speak=(New-Object System.Speech.Synthesis.SpeechSynthesizer);%Voice%$speak.Speak($words);">>%fn%
if %clip%==2 if %rptltr% NEQ R echo start /MIN %pw% -c "Add-Type -AssemblyName System.Speech;$words=(Get-Clipboard);$speak=(New-Object System.Speech.Synthesis.SpeechSynthesizer);%Voice%$speak.Speak($words);">>%fn%
if %ps%==1 if %spk%==0 echo %%dummy2%% >>%fn%
echo ^(goto^) 2^>NUL^&if exist %fn% del /F %fn%>>%fn%
::Execute
:ab
if %rptltr%==N if %spk% GTR 0 (
	start "Launcher" /MIN %exe% /c start "%tmg%" /MIN /WAIT %exe% /c %fn%
	%to% %Delay% /NOBREAK>NUL
	call :o Launcher
)
if %spk%==0 start "%tmg%" /MIN %exe% /c %fn%
if %rptltr%==R if %spk% GTR 0 start "%tmg%" /MIN %exe% /c "%TMPA%ALRMA%rptfnnum%.BAT"
if %rptltr%==A (
	%to% %Delay% /NOBREAK>NUL
	if %spk% GTR 0 start "%tmg%" /MIN /WAIT %exe% /c %fn%
	if %rptexp%==0 (start "Expiration Pending ..." /MIN /WAIT %exe% /c %dummy6%) else (start "%tmg%" /MIN /WAIT %exe% /c %dummy6%)
	%to% %Delay% /NOBREAK>NUL
	if exist %dummy6% del /F %dummy6%
	if exist %fn% del /F %fn%
)
::Quit
echo/
if %rptltr%==N (
	if %wake%==0 @%cp%&echo   %msg%&exit /B %er%
	if %wake%==1 set msg=Wake%msg:~5%
)
if %rptltr% NEQ R goto :cb
for %%A in (dummy2 dummy3) do set %%A=
if %rptmins%==1 (set dummy=minute) else set dummy=%rptmins% minutes
if %rptmins% GTR 1439 set /a dummy2=(%rptmins%*100)/1440
if "%dummy2%" NEQ "" if "%dummy2%"=="2800" set dummy=%dummy% (1 month)
if "%dummy2%" NEQ "" if "%dummy2%" NEQ "2800" set dummy=%dummy% (%dummy2:~0,-2%.%dummy2:~-2% days)
if "%dummy2%"=="" if %rptmins% GTR 59 set /a dummy3=%rptmins%/60
if "%dummy3%" NEQ "" set /a dummy2=%rptmins%%%60
if "%dummy3%" NEQ "" set dummy=%dummy% (%dummy3% hours %dummy2% mins)
set dummy2=Wake [and Repeat every %dummy% thereafter
if %rptexp%==-1 goto :bb
set /a dummy=%rptexp%-1
if %dummy%==1 (set dummy3=minute) else set dummy3=minutes
set dummy2=%dummy2%, for %dummy% %dummy3%
:bb
set msg=%dummy2%]%msg:~6%
:cb
echo   %msg%
if %rptltr%==A @%cp%&exit /B %er%
if %wake%==1 if %rptltr%==N if "%torg%"=="+0" (goto) 2>NUL &if exist %TMPA%ALRM?%fncnt%.BAT del /F %TMPA%ALRM?%fncnt%.BAT
@%cp%&exit /B %er%
-------------
:db
set just1=1
set dmsg=%~1
set dmsg=%dmsg:~4%
goto :eof
:eb
set res=%~1
if "%res:~-1,1%" NEQ " " goto :eof
set res=%res:~0,-1%
goto :eof
:fb
set num=%~1
call :eb "%num:~5,3%"
set num=%res%
if not exist %TMPA%ALRMW%num%.bat goto :eof
set validnums=%validnums%g%num%g
if "%validnums%"=="g%num%g" echo/&echo Wake number^(s^):
set k=%num%
call :ob
echo   #%num%	%dmsg%
goto :eof
:gb
set just1=1
set wmsg=%*
set wmsg=%wmsg:~4%
goto :eof
:hb
set num=%~n1
set num=%num:~5%
set wmsg=
if exist %TMPA%ALRMW%num%.bat set /a wcnt+=1&goto :eof
set /a acnt+=1
if %acnt%==1 echo/&echo Alarm number^(s^):
set just1=0
for /F "skip=1 tokens=*" %%A in (%TMPA%ALRMA%num%.BAT) do if !just1!==1 (goto :ib) else call :gb %%A 
:ib
if defined wmsg echo   #%num%	%wmsg%
goto :eof
:jb
call :o "%~1"
goto :eof
:kb
set dummy3=%dmsg:~4%&set dummy=1
if "%dmsg:~4,1%" NEQ " " set dummy3=%dmsg:~5%&set dummy=0
if "%dmsg:~5,1%" NEQ " " set dummy3=%dmsg:~6%&set dummy=2
if %dummy%==0 call :jb "Alarm%dummy3%"&goto :eof
if %dummy%==1 call :jb "Wake%dummy3%"&goto :eof
if %dummy%==2 call :jb "Repeat%dummy3%"
goto :eof
:lb
set validnums=
set /a wcnt=0,acnt=0,kil=0
if exist %TMPA%ALRMA*.BAT for /F %%A in ('dir /B %TMPA%ALRMA*.BAT') do call :hb %%A
for /F "tokens=1-4 delims= " %%A in ('%win%schtasks.exe /query^|%win%findstr.exe /c:ALRMW') do call :fb %%A %%B %%C %%D
set /a cnt=%wcnt%+%acnt%
if %cnt%==0 echo/&echo   No Alarms&echo   No Wakes^|Repeats&@%cp%&exit /B %er%
if %vw%==1 echo/&echo 	^( Now:	  %dt:~8,4%.%dt:~12,2% hours ^)&echo ^( Cancel one[all] Alarm^|Wake/Repeat^(s^):  %~nx0 /X[A] ^)&@%cp%&exit /B %er%
set kil=1
echo/
if %cnt%==1 if %num% LEQ 25 set k=%num%&set autokil=-2&goto :rb
set k=-1
set /p k=Number to Kill (or "All"):  
set k=%k: =%&set k=!k:#=!&set k=!k:"=!
if "%k%"=="-1" set ermsg=No number&set er=25&goto :r
if /I "%k%"=="ALL" echo/&goto :rb
:mb
for /F "delims=0123456789" %%A in ("%k%X") do if "%%A" NEQ "X" set ermsg="%k%" is not a number&set er=26&goto :r
if not exist %TMPA%ALRMW%k%.bat (
	if exist %TMPA%ALRMA%k%.BAT echo/&goto :ob
	set ermsg=Non-existent task "ALRMA%k%"&set er=27&goto :r
)
echo/
for /F "tokens=3 delims= " %%A in ('%win%schtasks.exe /query^|%win%findstr.exe /c:ALRMW%k%') do set tm=%%A
%win%schtasks.exe /delete /tn ALRMW%k% /f >NUL
if %autokil%==-1 goto :ob
if exist %TMPA%ALRME%autokil%.txt del /F %TMPA%ALRME%autokil%.txt
set just1=0
if exist %TMPA%ALRMA%autokil%.bat for /F "skip=2 tokens=*" %%A in (%TMPA%ALRMA%autokil%.BAT) do if !just1!==1 (goto :nb) else call :db "%%A"
:nb
if exist %TMPA%ALRMA%autokil%.bat call :kb
:ob
set just1=0
if exist %TMPA%ALRMA%k%.BAT for /F "skip=1 tokens=*" %%A in (%TMPA%ALRMA%k%.BAT) do if !just1!==1 (goto :pb) else call :db "%%A"
:pb
if %kil%==0 goto :eof
call :kb
if exist %TMPA%ALRM?%k%.BAT del /F %TMPA%ALRM?%k%.BAT
if %autokil%==-1 echo Killed #%k%:&if defined dmsg echo 	%dmsg%
@%cp%&exit /B %er%
:qb
set dummy=1
::Assume bell and timeout always deleteable, cmd not unless ...
if %3==0 if "%~2" NEQ "Alarm" if "%~2" NEQ "Wake" if "%~2" NEQ "Repeat" set dummy=0
if %dummy%==1 %wm% "processid=%~1" delete>NUL 2>&1
goto :eof 
::Kill ALL
:rb
if /I %ex%==bell.exe for /F "skip=3 tokens=2,10 delims= " %%A in ('%tskv% %ex%"') do if "%%A" NEQ "" call :qb "%%A" "%%B" 1
for /F "skip=3 tokens=2,10 delims= " %%A in ('%tskv% timeout.exe"') do if "%%A" NEQ "" call :qb "%%A" "%%B" 1
set cspec=%ComSpec%
:sb
if "%cspec%" NEQ "%cspec:\=%" for /F "tokens=1* delims=\" %%A in ("%cspec%") do set cspec=%%B&goto :sb
for /F "skip=3 tokens=2,10 delims= " %%A in ('%tskv% %cspec%"') do if "%%A" NEQ "" call :qb "%%A" "%%B" 0
::26 iterations
for /L %%A in (0,1,26) do @%win%schtasks.exe /delete /tn ALRMW%%A /F >NUL 2>&1
if exist %TMPA%ALRM*.BAT del /F %TMPA%ALRM*.BAT
if exist %TMPA%ALRM*.TXT del /F %TMPA%ALRM*.TXT
if %autokil%==-2 (set ret= ^(including Alarm #%num%^)) else set ret=
if /I "%cml:~3,1%" NEQ "A" echo Alarms #0 to #25 canceled%ret%&@%cp%&exit /B %er%
@echo Working ^(canceling Alarms #0 to #1000^) ...
::1001 iterations
for /L %%A in (0,1,1001) do @%win%schtasks.exe /delete /tn ALRMW%%A /F >NUL 2>&1
if exist %TMPA%ALR* del /F %TMPA%ALR*
if exist %win%Tasks\ALRMW* del /F %win%Tasks\ALRMW*
if exist "%~dpsn0.txt" del /F "%~dpsn0.txt"
@echo/
if "%cml:~4,1%" NEQ "N" (@echo %~nx0 system cleaned) else @echo New %~nx0 version: system cleaned.&call %~dpsnx0 %dummy3%
@%cp%&exit /B %er%
:tb
if not exist %TMPA%ALRM.ps1 call :cc
set pw2=%pw% -file "%TMPA%ALRM.ps1" -snd
if /I %UnMute%==On (%pw2% 1 -vol %vol%) else %pw2% 0
set e=%errorlevel%
set s=%e:~1%
if %s%==0 (set vol=0) else if %s%==100 (set vol=1.00) else set vol=0.%s%
if %s% NEQ 0 if %s:~0,1%==0 set s=%s:~1%
set s=%s%%%
if %e:~0,1% NEQ 1 if %e:~0,1% NEQ 3 set s=%s%, Muted
echo UnMute On^|Off:		%UnMute%
if /I %UnMute%==On echo Volume Threshold: 	%Volume%%%
echo System sound level:	%s%
for /F "tokens=4 delims=. " %%A in ('ver') do if %%A GEQ 10 (
	if not exist %TMPA%ALRM2.ps1 call :dc
	%pw% -file "%TMPA%ALRM2.ps1"
)
%to% %Delay% >NUL
@echo 
%to% %Delay% >NUL
if /I %UnMute%==On if "%e:~0,1%#" NEQ "1#" %pw% -file "%TMPA%ALRM.ps1" -snd %e:~0,1% -vol %vol%
@%cp%&exit /B %er%
:ub
@echo/&for /F %%A in ('%pw% -c "Test-Connection -ComputerName holmgren.org -Quiet -Count 1"') do if %%A==False set ermsg=No connectivity&set er=28&goto :r
%cp%
%pw% -c "(New-Object Net.WebClient).DownloadFile('https://holmgren.org/ALRMV.txt','%~dps0ALRMV.txt')"
for /F %%A in (%~dps0ALRMV.txt) do set dummy=%%A
if exist %~dps0ALRMV.txt del /F %~dps0ALRMV.txt
if %dummy%==%Version% (
	@echo You have the latest version ^(v%dummy%^)
	set dummy2=^(Download ^"AlarmBat.zip^" again?^) [y^^^|N
) else set dummy2=Download ^"AlarmBat.zip^" version %dummy%? (you have v%Version%) [Y^^^|n
set /p dummy2=%dummy2%]: 
if %dummy%==%Version% (if /I "%dummy2%" NEQ "Y" exit /B %er%) else if /I "%dummy2%"=="N" exit /B %er%
%pw% -c "(New-Object Net.WebClient).DownloadFile('https://holmgren.org/AlarmBat.zip','%~dps0AlarmBat.zip')"
@echo Latest "AlarmBat.zip" v%dummy% downloaded to "%~dps0"
@echo/
set /p dummy2=Install ^"Alarm.bat^" and ^"AlarmBat_ReadMe.txt^" (replace 2 files)? [Y^|n]: 
if /I "%dummy2%" NEQ "N" %pw% -c "$shell=New-Object -ComObject shell.application;$zip=$shell.NameSpace('%~dps0AlarmBat.zip');foreach($item in $zip.items()){if($item.Name -like 'Alarm*'){$shell.Namespace('%~dps0').CopyHere($item,0x14)}}"&@echo Done&exit /B %er%
exit /B %er%
:vb
set %2=%~s1
goto :eof
:wb
if "%2"=="cscript" set cs=%1 //Nologo %TMPA%ALRM.vbs&goto :eof
if "%2"=="reg" set reg=%1 query "HKCU\Control Panel\International" /v&goto :eof
if "%2"=="timeout" set to=%1 /T&goto :eof
set tsk=%1 /FI ^"IMAGENAME eq
set tskv=%1 /V /FI ^"IMAGENAME eq
goto :eof
:xb
if "%2"=="more" set mr=%1 /E /S&goto :eof
if /I "%cml:~0,4%"=="/XAA" goto :eof
set cp=%1
for /F "tokens=4" %%A in ('%cp%') do set ret=%%A
if %ret%==437 set cp=REM/&goto :eof
%cp% 437 >NUL&@echo %cp% 437 ^>NUL>>%TMPA%ALRG.bat
set cp=%cp% %ret% ^>NUL&@echo set cp=%cp% %ret% ^^^>NUL>>%TMPA%ALRG.bat
goto :eof
:yb
set /a bad+=1
set "dummy2=%dummy2%	%~1&echo/"
goto :eof
:zb
if "%dummy%#"=="#" call :yb "%2.exe"&goto :eof
call :vb "%dummy%" dummy
set %1=%dummy% %~3
set dummy=
goto :eof
:ac
if not exist "%~dps0ALRM\" md "%~dps0ALRM\"&if not exist "%~dps0ALRM\" set ermsg=Running as Administrator? No "%~dps0ALRM\" directory can be created&set cp=REM/&set er=5&call :r&goto :eof
call :vb "%~dps0ALRM\" TMPA
if exist %TMPA%ALRG.bat del /F %TMPA%ALRG.bat
call :vb "%SystemRoot%\System32\" win
set dummy=&set dummy2=&set bad=0
for %%A in (more chcp) do if exist "%win%%%A.com" (call :xb %win%%%A.com %%A) else call :yb "%%A.com"
for %%A in (cmd findstr forfiles powercfg sc schtasks xcopy) do if not exist "%win%%%A.exe" call :yb "%%A.exe"
for %%A in (cscript reg timeout tasklist) do if exist "%win%%%A.exe" (call :wb %win%%%A.exe %%A) else call :yb "%%A.exe"
for /F "tokens=4 delims=. " %%A in ('ver') do set ver=%%A
for /R "%SystemRoot%\Microsoft.NET\Framework\" %%A in ("*csc.exe") do set dummy=%%A
call :zb csc csc ""
for /R "%win%" %%A in ("*WMIC.exe") do if exist "%%A" set dummy=%%A
call :zb wm WMIC "process where"
set pw2=powershell -ExecutionPolicy Bypass -c
for /R "%win%WindowsPowershell\" %%A in ("*powershell.exe") do set dummy=%%A
call :zb pw powershell "-ExecutionPolicy Bypass"
if "%exe%"=="" set exe=cmd.exe
set ex=%exe%
if /I "%exe:~0,3%"=="cmd" (set exe=%win%cmd.exe) else set exe=%~dps0bell.exe&if not exist %~dps0bell.exe call :yb "%~dps0bell.exe"
if %bad% GTR 0 (
	if exist %TMPA%ALRG.bat del /F %TMPA%ALRG.bat
	echo/&echo 		    Missing file^(s^)^^^!&echo/
	set dummy=^^^!^^^!^^^!^^^!^^^!		%~n0 cannot continue^^^!		^^^!^^^!^^^!^^^!^^^!
	<NUL set /p dummy3=!dummy!
	for /L %%A in (1,1,2) do call :fc 52
	%to% 1 >NUL
	@echo/&echo/&@echo Install or otherwise acquire *%bad%* missing file^(s^):&echo %dummy2%&set er=3&goto :eof
	
)
if "%Delay%"=="" set Delay=4
for /F "delims=0123456789" %%A in ("%Delay%") do if "%%A" NEQ "" set ermsg="Delay" variable must be numeric (currently "%Delay%")&set er=7&call :r&goto :eof
if "%Volume%"=="" set Volume=80
if /I "%UnMute%X" NEQ "OnX" set UnMute=Off
for /F "delims=0123456789" %%A in ("%Volume%") do if "%%A" NEQ "" set ermsg="Volume" threshold must be numeric, in range 0-100 ^(currently "%Volume%"^)&set er=8&call :r&goto :eof
if %Volume% GTR 99 (set vol=1.00) else set vol=0.%Volume%&if %Volume% LSS 10 set vol=0.0%Volume%&if %Volume% LSS 1 set vol=0
if "%Voice%" NEQ "" set Voice=$speak.SelectVoice('%Voice%');
@for /F "tokens=4" %%A in ('%win%powercfg.exe /getactivescheme') do set GUID=%%A
for /F "delims=" %%A in ('%win%powercfg.exe -q %GUID% ^|%win%findstr.exe /c:"(Sleep)"') do for /F "tokens=3 delims= " %%B in ("%%A") do set SleepGUID=%%B
for /F "delims=" %%A in ('%win%powercfg.exe -q %GUID% ^|%win%findstr.exe /c:"(Allow wake timers)"') do for /F "tokens=4 delims= " %%B in ("%%A") do set WakeGUID=%%B
@for %%A in (ac dc) do %win%powercfg.exe -set%%Avalueindex %GUID% %SleepGUID% %WakeGUID% 001
for /F "tokens=3" %%A in ('%reg% sDate 2^>NUL') do set dtsep=%%A
if "%dtsep%"=="" set dtsep=/
for /F "tokens=3" %%A in ('%reg% iDate 2^>NUL') do set iDate=%%A
if "%iDate%"=="0" set dtfmt=mdy
if "%iDate%"=="1" set dtfmt=dmy
if "%iDate%"=="2" set dtfmt=ymd
for /F %%A in ('%pw% -c "Get-Date -Format 'yyyyMMddHHmmss'"') do set dt=%%A
@echo for /F %%%%A in ('%pw% -c "Get-Date -Format 'yyyyMMddHHmmss'"') do set dt=%%%%A>>%TMPA%ALRG.bat
set ret=%~dps0
for %%A in (a0 ab ae af bb) do @for /F %%B in ('%win%forfiles.exe /P "%ret:~0,-1%" /M "%~nx0" /C "%win%cmd.exe /c echo 0x%%A"') do set %%A=%%B
for %%A in (a0 ab ae af bb cs csc Delay dtfmt dtsep ex exe mr pw pw2 TMPA to tsk tskv UnMute ver Voice vol Volume win wm) do @echo set %%A=!%%A!>>%TMPA%ALRG.bat
set bad=0&for %%A in (dummy dummy2 dummy3 GUID reg ret SleepGUID WakeGUID) do set %%A=
goto :eof
:bc
@echo Dim txt,cms,fncnt,ret,lenm,spc,cl,voice,wsh,fso,wdth>%w%
@echo txt=WScript.Arguments(0)>>%w%
@echo cms=WScript.Arguments(1)>>%w%
@echo Set wsh=WScript.CreateObject("WScript.Shell")>>%w%
@echo If cms^<^>"S" Then>>%w%
@echo 	If cms="M" Then fncnt=WScript.Arguments(2)>>%w%
@echo 	Set ret=wsh.Exec("%pw% Write-Host $host.UI.RawUI.WindowSize.Width")>>%w%
@echo 	ret.StdIn.Close>>%w%
@echo 	wdth=Trim(ret.StdOut.ReadAll())>>%w%
@echo 	cl=1*CInt(wdth)>>%w%
@echo 	If cms="C" Then>>%w%
@echo 		fncnt=txt>>%w%
@echo 		txt=CreateObject("htmlfile").ParentWindow.ClipboardData.GetData("text")>>%w%
@echo 	End If>>%w%
@echo End If>>%w%
@echo If InStr(1,Mid(txt,1),"`",1)^>0 Then>>%w%
@echo 	If InStr(1,txt,"`v`",1)^>0 Or InStr(1,txt,"`var`",1)^>0 Then>>%w%
@echo 		txt=Replace(txt,"`v`","%%",1,-1,1)>>%w%
@echo 		txt=Replace(txt,"`var`","%%",1,-1,1)>>%w%
@echo 		Set objExec=wsh.Exec("%win%cmd.exe /c echo " ^& txt)>>%w%
@echo 		With objExec>>%w%
@echo 			Do While .Status=0 >>%w%
@echo 				WScript.Sleep 1 >>%w%
@echo 				Do While Not .StdOut.AtEndOfStream>>%w%
@echo 					txt=.StdOut.ReadLine>>%w%
@echo 					WScript.Echo txt>>%w%
::Check .StdErr to see if it is at the end of its stream. If not, call ReadLine on it
@echo 					If Not .StdErr.AtEndOfStream Then>>%w%
@echo 						txt=.StdErr.ReadLine>>%w%
@echo 						WScript.Echo "Error: " ^& txt>>%w%
@echo 					End If>>%w%
@echo 				Loop>>%w%
@echo 			Loop>>%w%
@echo 		End With>>%w%
@echo 	End If>>%w%
@echo 	txt=Replace(txt,"`a`","&",1,-1,1)>>%w%
@echo 	txt=Replace(txt,"`amp`","&",1,-1,1)>>%w%
@echo 	txt=Replace(txt,"`bar`","|",1,-1,1)>>%w%
@echo 	txt=Replace(txt,"`gt`",">",1,-1,1)>>%w%
@echo 	txt=Replace(txt,"`lt`","<",1,-1,1)>>%w%
@echo 	txt=Replace(txt,"`x`","^!",1,-1,1)>>%w%
@echo 	txt=Replace(txt,"`xcl`","^!",1,-1,1)>>%w%
@echo 	txt=Replace(txt,"`crt`","^",1,-1,1)>>%w%
@echo 	txt=Replace(txt,"`rp`",")",1,-1,1)>>%w%
@echo 	txt=Replace(txt,"`lp`","(",1,-1,1)>>%w%
@echo 	txt=Replace(txt,"`sl`","/",1,-1,1)>>%w%
@echo 	txt=Replace(txt,"`bq`","`",1,-1,1)>>%w%
@echo 	txt=Replace(txt,"`pct`","%%",1,-1,1)>>%w%
@echo 	txt=Replace(txt,"`q`","""",1,-1,1)>>%w%
@echo 	txt=Replace(txt,"`quo`","""",1,-1,1)>>%w%
@echo End If>>%w%
@echo lenm=Len(txt)>>%w%
::@echo Wscript.Echo "txt=" ^& txt ^& " cms=" ^& cms ^& " cl=" ^& cl ^& " lenm=" ^& lenm ^& " fncnt=" ^& fncnt>>%w%
@echo If cms^<^>"S" Then>>%w%
@echo 	If lenm^<cl Then>>%w%
@echo 		spc=Round((cl-lenm)/2)>>%w%
@echo 		txt=Space(spc) ^& txt>>%w%
@echo 	End If>>%w%
@echo 	If cl^>27 Then>>%w%
@echo 		spc=Round((cl-27)/2)>>%w%
@echo 		txt=txt ^& vbCrLf ^& Chr(^&H08) ^& vbCrLf ^& vbCrLf ^& Space(spc) ^& "< Hit any key to Dismiss >" ^& vbCrLf ^& vbCrLf>>%w%
@echo 	End If>>%w%
@echo 	Set fso=CreateObject("Scripting.FileSystemObject").OpenTextFile("%TMPA%ALRMC" ^& fncnt ^& ".txt",2,true,0)>>%w%
@echo 	fso.WriteLine(txt)>>%w%
@echo 	fso.Close>>%w%
@echo 	Wscript.Quit>>%w%
@echo End If>>%w%
::"S"
@echo txt=Replace(txt,"'","''")>>%w%
@echo If WScript.Arguments.Count^>2 Then>>%w%
@echo 	voice=WScript.Arguments(2)>>%w%
@echo Else>>%w%
@echo 	voice="">>%w%
@echo End If>>%w%
@echo txt=Replace(txt,"&","""&""")>>%w%
@echo wsh.Run "%win%cmd.exe /c start /MIN %pw% -c ""Add-Type -AssemblyName System.Speech;$speak=New-Object System.Speech.Synthesis.SpeechSynthesizer;" ^& voice ^& "$speak.Speak(""""""" ^& txt ^& """"""");""">>%w%
@echo Wscript.Quit>>%w%
goto :eof
:cc
set k=%TMPA%ALRM.ps1
@echo param([int32]$snd=1,[string]$vol=$null,[string]$sysvol=$null)>%k%
@echo Add-Type -Language CsharpVersion3 -TypeDefinition @'>>%k%
@echo using System.Runtime.InteropServices;>>%k%
@echo [Guid("5CDF2C82-841E-4546-9722-0CF74078229A"),InterfaceType(ComInterfaceType.InterfaceIsIUnknown)]>>%k%
@echo interface IAudioEndpointVolume{int f();int g();int h();int i();int SetMasterVolumeLevelScalar(float fLevel,System.Guid pguidEventContext);int j();>>%k%
@echo int GetMasterVolumeLevelScalar(out float pfLevel);int k();int l();int m();int n();int SetMute([MarshalAs(UnmanagedType.Bool)] bool bMute,System.Guid pguidEventContext);int GetMute(out bool pbMute);}>>%k%
@echo [Guid("D666063F-1587-4E43-81F1-B948E807363F"),InterfaceType(ComInterfaceType.InterfaceIsIUnknown)]>>%k%
@echo interface IMMDevice{int Activate(ref System.Guid id,int clsCtx,int activationParams,out IAudioEndpointVolume aev);}>>%k%
@echo [Guid("A95664D2-9614-4F35-A746-DE8DB63617E6"),InterfaceType(ComInterfaceType.InterfaceIsIUnknown)]>>%k%
@echo interface IMMDeviceEnumerator{int f();int GetDefaultAudioEndpoint(int dataFlow,int role,out IMMDevice endpoint);}>>%k%
@echo [ComImport,Guid("BCDE0395-E52F-467C-8E3D-C4579291692E")] class MMDeviceEnumeratorComObject{ }>>%k%
@echo public class Audio{static IAudioEndpointVolume Vol(){var enumerator=new MMDeviceEnumeratorComObject() as IMMDeviceEnumerator;IMMDevice dev=null;>>%k%
@echo Marshal.ThrowExceptionForHR(enumerator.GetDefaultAudioEndpoint(0,1,out dev));IAudioEndpointVolume epv=null;>>%k%
@echo var epvid=typeof(IAudioEndpointVolume).GUID;Marshal.ThrowExceptionForHR(dev.Activate(ref epvid,23,0,out epv));return epv;}>>%k%
@echo public static float Volume{get{float v=-1;Marshal.ThrowExceptionForHR(Vol().GetMasterVolumeLevelScalar(out v));return v;}>>%k%
@echo set{Marshal.ThrowExceptionForHR(Vol().SetMasterVolumeLevelScalar(value,System.Guid.Empty));}}>>%k%
@echo public static bool Mute{get{ bool mute;Marshal.ThrowExceptionForHR(Vol().GetMute(out mute));return mute;}>>%k%
@echo set{ Marshal.ThrowExceptionForHR(Vol().SetMute(value,System.Guid.Empty));}}}>>%k%
@echo '@>>%k%
@echo if($snd -gt 1){if($snd -gt 2){[Audio]::Volume=$vol}if($snd -ne 3){[Audio]::Mute=$true}exit}>>%k%
@echo $sysvol=[Audio]::Volume;if($sysvol -gt 0){if($sysvol -lt 1.00){$sysvol=$sysvol.Substring(2);if($sysvol.Length -gt 2){$sysvol=$sysvol.Substring(0,2)}if($sysvol.Length -eq 1){if($sysvol -ne "0"){$sysvol=[string]$sysvol+"0"}}}else{$sysvol="100"}}else{$sysvol="0"}>>%k%
@echo if($snd -eq 0){$snd=1;if([Audio]::Mute -eq 'True'){$snd=2}$snd=[string]$snd+$sysvol;exit $snd}>>%k%
@echo if([Audio]::Mute -eq 'True'){$snd=2;[Audio]::Mute=$false}if([Audio]::Volume -lt $vol){$snd+=2;[Audio]::Volume=$vol}$snd=[string]$snd+$sysvol;exit $snd>>%k%
goto :eof
:dc
set k=%TMPA%ALRM2.ps1
@echo Add-Type -TypeDefinition @'>%k%
@echo using System.Runtime.InteropServices;>>%k%
@echo [Guid("D666063F-1587-4E43-81F1-B948E807363F"),InterfaceType(ComInterfaceType.InterfaceIsIUnknown)]>>%k%
@echo interface IMMDevice {int a();int o();int GetId([MarshalAs(UnmanagedType.LPWStr)] out string id);}>>%k%
@echo [Guid("A95664D2-9614-4F35-A746-DE8DB63617E6"),InterfaceType(ComInterfaceType.InterfaceIsIUnknown)]>>%k%
@echo interface IMMDeviceEnumerator {int f();int GetDefaultAudioEndpoint(int dataFlow,int role,out IMMDevice endpoint);}>>%k%
@echo [ComImport,Guid("BCDE0395-E52F-467C-8E3D-C4579291692E")] class MMDeviceEnumeratorComObject { }>>%k%
@echo public class Audio {public static string GetDefault(int direction){var enumerator=new MMDeviceEnumeratorComObject() as IMMDeviceEnumerator;IMMDevice dev=null;Marshal.ThrowExceptionForHR(enumerator.GetDefaultAudioEndpoint(direction,1,out dev));string id=null;Marshal.ThrowExceptionForHR(dev.GetId(out id));return id;}}>>%k%
@echo '@>>%k%
@echo function getFriendlyName($id){$reg="HKLM:\SYSTEM\CurrentControlSet\Enum\SWD\MMDEVAPI\$id";return (get-ItemProperty $reg).FriendlyName;}>>%k%
@echo $id0=[audio]::GetDefault(0);write-host "Output:			$(getFriendlyName $id0)";>>%k%
goto :eof
:ec
set fnb=%TMPA%ALRMakeMouseMove.bat
@echo // 2^>nul^|^|@goto :#>%fnb%
@echo /*>>%fnb%
@echo :#>>%fnb%
@echo @echo off>>%fnb%
@echo call %%csc%% /nologo /warn:0 /out:"%%TMPA%%ALRM.exe" "%fnb%" ^|^| (set er=4)>>%fnb%
@echo exit /B>>%fnb%
@echo */>>%fnb%
@echo using System;>>%fnb%
@echo using System.Runtime.InteropServices;>>%fnb%
@echo namespace MouseMover {>>%fnb%
@echo public class MouseSimulator {>>%fnb%
@echo [DllImport("user32.dll",SetLastError=true)]>>%fnb%
@echo static extern uint SendInput(uint nInputs,ref INPUT pInputs,int cbSize);>>%fnb%
@echo [DllImport("user32.dll")]static extern int GetSystemMetrics(SystemMetric smIndex);struct INPUT {public SendInputEventType type;public MouseKeybdhardwareInputUnion mkhi;}>>%fnb%
@echo [StructLayout(LayoutKind.Explicit)]struct MouseKeybdhardwareInputUnion{[FieldOffset(0)]public MouseInputData mi;}>>%fnb%
@echo public struct POINT{public int X;public int Y;public POINT(int x,int y){this.X=x;this.Y=y;}}>>%fnb%
@echo struct MouseInputData {public int dx;public int dy;public uint mouseData;public MouseEventFlags dwFlags;public uint time;public IntPtr dwExtraInfo;}>>%fnb%
@echo enum MouseEventFlags:uint {MOUSEEVENTF_MOVE=0x0001}enum SendInputEventType:int {InputMouse}enum SystemMetric{SM_CXSCREEN=0,SM_CYSCREEN=1,}>>%fnb%
@echo static void MoveMouseBy(int x,int y){INPUT mouseInput=new INPUT();mouseInput.type=SendInputEventType.InputMouse;mouseInput.mkhi.mi.dwFlags=MouseEventFlags.MOUSEEVENTF_MOVE;>>%fnb%
@echo mouseInput.mkhi.mi.dx=x;mouseInput.mkhi.mi.dy=y;SendInput(1,ref mouseInput,Marshal.SizeOf(mouseInput));}>>%fnb%
@echo public static void Main(){MoveMouseBy(1,0);MoveMouseBy(-1,0);}}}>>%fnb%
call %fnb%
if exist %fnb% del /F %fnb%
if %er%==4 set ermsg=Error creating "%TMPA%ALRM.exe"
goto :eof
:fc
%to% 1 >NUL
for /L %%B in (0,1,%1) do <NUL set /p= 
%to% 1 >NUL
<NUL set /p dummy3=!dummy!
goto :eof
:gc
if not exist %exe% (
	@echo/
	set dummy=^^^!^^^!^^^!^^^!^^^!		FATAL ERROR: "%ex%" DOES NOT EXIST^^^!		^^^!^^^!^^^!^^^!^^^!
	<NUL set /p dummy3=!dummy!
	for /L %%A in (1,1,3) do call :fc 68
	%to% 1 >NUL
	if /I %exe:~-8%==bell.exe echo/&echo/&@echo  UnZIP "bell.exe" from AlarmBat.zip and locate it in the same "%~dps0" directory as %~nx0&@echo/&pause
)
setlocal disableDelayedExpansion
if /I "%~1x" NEQ "/Hx" if exist "%~dpsn0.txt" goto :hc
set hlp= ^>^>%~dpsn0.txt
@echo/>%~dpsn0.txt
@echo		%~nx0 v%Version%	Notification program for the Windows command line%hlp%
@echo/%hlp%
@echo NOTIFY Usage: %~dpsn0.bat AlarmTime [Switches] [Action] ^(in order^)%hlp%
@echo ======  Syntax: %~dpsn0[.bat] HH[:]MM[A^|P[M]] ^| +m ...				Alarm_Time%hlp%
@echo 	... [/D[d]d[-[m]m[-yy]] ^| /D+n] [/Q[Q[Q]]] [/Rm [/Em]] [/S] [/W ] ...		Switches%hlp%
@echo 	... [Typed Message] ^| [/C{lipboard}] ^| [/F{ile}] ^| [/P{rogram} [arguments]]	Action%hlp%
@echo/%hlp%
@echo   AlarmTime ^(REQUIRED; first argument^). Two forms:%hlp%
@echo 	[[[H]H[:]]M]M {24-hour time^|12-hour time with A^|P[M] suffix; may omit leading zeroes, e.g. Midnight: "0000"="0"}%hlp%
@echo 	+m {precise minutes from NOW, e.g. "+30"; not valid with /D switch}%hlp%
@echo/%hlp%
@echo   Switches ^(optional; relaxed order^):%hlp%
@echo 	/D {HHMM=trigger time on alarm day; implies /W}. Two forms:%hlp%
@echo 		/Ddd-mm-yy {date of alarm, in [d]d[-[m]m[-yy]] form; d is minimally required}%hlp%
@echo 		/D+n {n=number of days in future until alarm, e.g. /D+2}%hlp%
@echo 	/Q[Q[Q]] {/Q Quiet, Mute Audio+Bells; /QQ UnMute Audio; /QQQ UnMute Audio+Bells}%hlp%
@echo 	/Rm {Repeat alarm every m minutes (minimum=1); initial instance occurs at HHMM; implies /W}. Repeats until:%hlp%
@echo 		/Em {m=Expiration in minutes after HHMM ^(explicit duration^)}; or%hlp%
@echo 		{manual cancellation with "%~n0 /X" ^(indefinite duration^)}%hlp%
@echo 	/S {Speak ^(instead of display^) TYPED ^| CLIPBOARD ^| FILE text; implies /QQ}%hlp%
@echo 	/W {Wake computer from future Sleep ^| Hibernation, and persist through Restarts}%hlp%
@echo/%hlp%
@echo   Action. DEFAULT: Three alarm Bells {override with /Q}. Four supplementary arguments:%hlp%
@echo 	/P[START_command_switches ]["][d:\path\]PROGRAM["] [arguments] {implies /QQ; override with /Q ^| /QQQ}%hlp%
@echo      Messages {displayed in Foreground window; hit any key to Dismiss; imply Bells unless /S[poken], override with /Q}:%hlp%
@echo 	TYPED text {max chars ñ8170}%hlp%
@echo 	/C {CLIPBOARD text, any length}%hlp%
@echo 	/F["][d:\path\]textfile_name["] {FILE text, any length}%hlp%
@echo/%hlp%
@echo/%hlp%
@echo INFO Usage: %~dpsn0.bat /B /H /T /U /V /X[A[A]] /?^|-h^|--help^|{no_arguments}%hlp%
@echo ====		Seven alternatives:%hlp%
@echo 	/B {^(re^)Build Alarm system variables}%hlp%
@echo 	/H {Print Help ^(THIS^) to file "%~dpsn0.txt"}%hlp%
@echo 	/T {Test bell audibility ^& volume}%hlp%
@echo 	/U {check for Alarm.bat Update}%hlp%
@echo 	/V {View pending Alarms^|/W{akes}^|/R{epeats} by number}%hlp%
@echo 	/X {Cancel one Alarm^|Wake^|Repeat by number, or type "ALL" when prompted}%hlp%
@echo 		/XA	{Cancel Alarms 0-25}%hlp%
@echo 		/XAA	{Cancel Alarms 0-1000; Reset ^(wipe^) system}%hlp%
@echo/	/?^|-h^|--help^|no_arguments {Display THIS}%hlp%
@echo/%hlp%
@echo Time Declaration: 0050 :50 50a 1250AM 12:50a... 0150 150 1:50 1:50am... 1350 13:50 150p 1:50PM... +90...%hlp%
@echo		  {For each future day, add 2400 to HHMM time: "time+(days*2400)"}%hlp%	
@echo		7:00am today    =  700 {if time today earlier than 7:00am}%hlp%
@echo		7:00am tomorrow =  700 {if time today later than 7:00am}, *OR*%hlp%
@echo		7:00am tomorrow = 3100 ^(700+2400^) {any time today}, *OR*%hlp%
@echo		7:00am tomorrow =  700 /D+1 {any time today, simpler}%hlp%
@echo		7:00am in 9 days=22300 {command "set /a 700+9*2400" returns "22300"}, *OR*%hlp%
@echo		7:00am in 9 days= 7:00a /D+9 {ditto; simpler}%hlp%
@echo		  N.B.: "7am" = [000]7 = 12:07am, not 0700^|7:00am! %hlp%
@echo/%hlp%
@echo Examples:%hlp%
@echo 	%~fs0 530p {TIME is the only required argument; default alarm is 3 audible bells}%hlp%
@echo 	%~nx0 1730 Call home%hlp%
@echo 	%~n0 300pm /Q Baby still napping?%hlp%
@echo 	%~n0 5515 /W Wake up - big day ahead {7:15am day after tomorrow ^(715+2400*2^)}%hlp%
@echo 	%~n0 715a /D+2 Wake up - big day ahead {ditto}%hlp%
@echo 	%~n0 +1 /R1 {bell nag starts in one minute, and repeats every minute}%hlp%
@echo 	%~n0 715 /R1440 Daily reminder to wake {at 7:15a every 24 hours=1440 minutes}%hlp%
@echo 	%~n0 715 /R1440 /Pcmd.exe /c %~dpsnx0 +1 /R1 /S Get going`xcl` {at 7:15a every%hlp%
@echo 	  morning, /S{peaks} reminder every minute until terminated with "%~n0 /X"}%hlp%
@echo 	%~n0 810 /R3 /E36 /S It's `var`TIME:~0,2`var`:`var`TIME:~3,2`var`. Train leaves at 9 {Speak "nag"%hlp%
@echo 	  every 3 minutes; Repeat expires in 36 minutes}%hlp%
@echo 	%~n0 510p /D15-6 Conference with Lawyer {15th of June}%hlp%
@echo 	%~n0 510a /d+3 Taxi to airport%hlp%
@echo 	%~n0 +0 /S /F"C:\Texts\Moby Dick.txt" {Speak a text file.}%hlp%
@echo   START a Program instead of sounding alarm ^(/P switch^):%hlp%
@echo 	%~n0 +60 /P"Do Something.bat"%hlp%
@echo 	%~n0 900pm /Phttps://www.msnbc.com/live%hlp%
@echo 	%~n0 +180 /Q /Pcmd.exe /k @echo ^^%%DATE^^%% ^^%%TIME^^%% %hlp%
@echo 	%~n0 7:15a /D+1 /R1440 /PFamous_for_Nothing-DanielleMiraglia.mp4 {requires an external player%hlp%
@echo 	  ASSOCiated with .MP4, and a sound file residing in the %%PATH%% ^(cf. ASSOC and FTYPE commands^)}%hlp%
@echo   Fully-qualified /P{rogram} commands, with optional START arguments:%hlp%
@echo 	%~n0 645a /w /p/MAX F:\VLC\vlc.exe -f --play-and-exit "J:\Video\Glenn_Gould\BWV 1080 Contrapunctus XIV Da Capo I.mp4"%hlp%
@echo 	%~n0 +0 /P/MIN %pw2% "Add-Type -AssemblyName System.Speech;$words=(Get-Clipboard);$speak=New-Object System.Speech.Synthesis.SpeechSynthesizer;$speak.SelectVoice('Microsoft Zira Desktop');$speak.Speak($words)"%hlp%
@echo 	%~n0 +0 /S /C {ditto: Speak Clipboard content, but a /C shortcut instead of a fully-described /Program as above}%hlp%
@echo 	%~n0 1200 /R60 /E540 /P/MIN %pw2% (New-Object Media.SoundPlayer "%~dps0Auxiliaries\BigBen.wav").PlaySync() {Chimes hourly}%hlp%
@echo 	  Each morning for 5 days, a child instance of %~n0 announces the Time every minute for 5 minutes, starting at 7:30am:%hlp%
@echo 	%~n0 729 /R1440 /E5760 /P/MIN cmd.exe /c %~nx0 +1 /R1 /E5 /P/MIN %~dps0Auxiliaries\TimeOfDay.bat%hlp%
@echo/%hlp%
@echo Cancel Alarm^|Wake/Repeat:  %~nx0 /X[A[A]] {/X selects one alarm among several; a single%hlp%
@echo	  pending Alarm is canceled automatically/hands-off ^| /XA or "All" cancels all pending%hlp%
@echo	  alarms #0-25 ^| /XAA cancels all pending alarms #0-1000.%hlp%
@echo	  Terminate PowerShell manually to kill e.g. Speech.%hlp%
@echo/%hlp%
@echo 	Notes:%hlp%
@echo Configure User Variables on lines 4-26 of "%~dpsn0.bat"%hlp%
@echo Reset the Alarm system after changes to Alarm config, Power Config, Locale, or CodePage: "Alarm.bat /B"%hlp%
@echo External file "%~dps0bell.exe" ^(bundled herewith^) is used by default instead of cmd.exe. Bell.exe is Cmd.exe%hlp%
@echo   with a bell icon, to distinguish Alarms from ordinary CMD sessions in the Taskbar. For a "pure" standalone%hlp%
@echo   BATch with no external dependencies, replace bell.exe with cmd.exe ^(erase "REM " on line 9 of %~nx0^).%hlp%
@echo Message Content: Single-byte characters ^"^|^&`^<^> are DISALLOWED. Chars ^"^|^&`/!%%^^()^<^> may be displayed using%hlp%
@echo   backquoted substitute strings, most commonly ^`q^` to display quotes.%hlp%
@echo   See "%~dps0AlarmBat_ReadMe.txt" for the list of substitute strings.%hlp%
@echo Default Alarm Sound: In recent Windows versions, the .WAVfile equivalent of DOS Ascii-07^|Ctrl-G ^(^^G^) "bell"%hlp%
@echo   is specified ^(and may be changed^) in MMSYS.CPL ^> Sounds ^> "Critical Stop".%hlp%
@echo If at alarm time Sound is Muted or below %Volume%^%% ^(and no /Q{uiet} command^), %~n0 UnMutes the system and/or%hlp%
@echo   raises the sound level to %Volume%^%%, then on exit ^(*unless /S{poken}*^) restores original Mute^|Volume%hlp%
@echo   settings. To disable this function, change the "UnMute" variable from "On" to "Off" ^(line 12%hlp%
@echo   of %~nx0^). Change the threshold Volume level from %Volume%^%% to another value on line 16.%hlp%
@echo If your ^(uncommon^) Windows system disallows "short" ^(8.3^) filenames (find out: execute%hlp%
@echo   "TestForShortDirectoryNames.bat", bundled herewith^), then locate %~nx0 in a directory tree%hlp%
@echo   with NO spaces!%hlp%
@echo Do not locate "%~nx0" and "bell.exe" in a Windows-protected directory ^(e.g. "%win%"^).%hlp%
@echo Recommended: Situate %~nx0 in the %%PATH%%, or append ";%~dp0" to the %%PATH%%, to obviate%hlp%
@echo   specifying "{%~dp0}%~n0[.bat]" in commands. Use Powershell (not SETX) to append:%hlp%
@echo   powershell -c "[Environment]::SetEnvironmentVariable('Path',$env:Path+';%~dp0','User')"%hlp%
@echo All files in the "%~dps0ALRM\" directory are RESERVED.%hlp%
@echo/%hlp%
@echo 	Wake/Repeat:%hlp%
@echo Enables Task Scheduler service "Schedule" ^(if not running^).%hlp%
@echo Executes as a Scheduled Task in the Local User account:  you MUST be signed in!%hlp%
@echo Sets "Control Panel > Power Options > Change advanced power settings > Sleep > Allow wake timers" to%hlp%
@echo   "Enable" for *both* AC and BATTERY power.%hlp%
@echo//R{epeat} command examples: Every 30 mins=/R30 ^| day=/R1440 ^| week=/R10080 ^| 28+ days {"Monthly"}=/R40320 {max}%hlp%
@echo   Calculate repeat interval in minutes: e.g. "set /a 60*6" returns 6 hours; "set /a 60*24*28" returns 28 days%hlp%
@echo   For long intervals, click a Bell icon in the Taskbar and hit any key, to remove a persistent icon without%hlp%
@echo   removing the Task ^(verify with "%~n0 /V"^). "%~n0 /X" destroys both the icon window and the Task.%hlp%
@echo /R{epeat}: adjust the CPU-dependent "Delay" variable as necessary ^(see comments at line 22^).%hlp%
@echo Task Scheduler is a temperamental program. See further comments in "%~dps0AlarmBat_ReadMe.txt".%hlp%
@echo/%hlp%
@echo 	Alarm.bat is freeware and open source. No warranties are expressed or implied.%hlp%
@echo			Robert Holmgren  https://github.com/Rajah01/Alarm.bat/releases/ %hlp%
if /I "%~1x"=="/Hx" @%cp%&exit /B %er%
:hc
@cls
%mr% %~dpsn0.txt
@%cp%&exit /B 1
