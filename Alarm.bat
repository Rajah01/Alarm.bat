@echo off
setlocal enableExtensions enableDelayedExpansion

rem * USER CONFIGURATION *
rem Use bell.exe (default; in SAME DIRECTORY as Alarm.bat), or cmd.exe (erase "REM " below)
set exe=bell.exe
REM set exe=cmd.exe

rem Permission to temporarily adjust sound (Volume) level and/or unmute as necessary (On|Off; default=On)
set UnMute=On

rem Threshold Volume level for sound; range 0-100; default=80
rem 	N.B.: Volume is NOT raised if current sound level equal to or greater than this value, or if UnMute=Off
set Volume=80

rem Standard Windows ANSI Codepage for your locale; default=1252
set ANSI=1252

rem Erase "REM" below to Set a Text-To-Speech (TTS) Voice *DIFFERENT* than your Default Voice (listed FIRST in the following enumeration of available Voice Names)
rem powershell.exe -ExecutionPolicy Bypass -c "Add-Type -AssemblyName System.Speech;$speak=New-Object System.Speech.Synthesis.SpeechSynthesizer;$speak.GetInstalledVoices()|Select-Object -ExpandProperty VoiceInfo|Select-Object -Property Culture,Name,Gender"
REM set Voice=Microsoft David Desktop

rem Delay, in seconds, while numerous commands execute, before destroying the launcher (CPU dependent:
rem   slower computers require more seconds; if you hear fewer than 3 bells, increase the value; default=4)
set Delay=4

rem * END USER CONFIGURATION *

rem ---------------- DO NOT WRITE BELOW THIS LINE! ----------------
set Version=20210720
goto :x
--------
SBCP 437 chars: =" &=<temp_delimiters> <ANSI:>�(ab)=�(ae) �(bb)=�(af) <+NBSP �(a0)>
Short 8.3 names
:a
set %2=%~s1
goto :eof
:b
set /a udd=100%udd%%%100,umm=100%umm%%%100
set /a z=14-umm,z/=12,y=uyy+4800-z,m=umm+12*z-3,secs=153*m+2
set /a secs=secs/5+udd+y*365+y/4-y/100+y/400-2472633
if 1%uhh% LSS 20 set uhh=0%uhh%
set /a uhh=100%uhh%%%100,unn=100%unn%%%100,uss=100%uss%%%100
set /a secs=secs*86400+uhh*3600+unn*60+uss
goto :eof
:c
set /a secs=%secs%,uss=secs%%60,secs/=60,unn=secs%%60,secs/=60,uhh=secs%%24,udd=secs/24,secs/=24
set /a a=secs+2472632,b=4*a+3,b/=146097,c=-b*146097,c/=4,c+=a
set /a d=4*c+3,d/=1461,e=-1461*d,e/=4,e+=c,m=5*e+2,m/=153,udd=153*m+2,udd/=5
set /a udd=-udd+e+1,umm=-m/10,umm*=12,umm+=m+3,uyy=b*100+d-4800+m/10
(if %umm% LSS 10 set umm=0%umm%)&(if %udd% LSS 10 set udd=0%udd%)
(if %uhh% LSS 10 set uhh=0%uhh%)&(if %unn% LSS 10 set unn=0%unn%)
if %uss% LSS 10 set uss=0%uss%
goto :eof
::DayOfWeek
:d
set dowyy=%1&set dowmm=%2&set dowdd=%3
set /a dowdd=100%dowdd%%%100,dowmm=100%dowmm%%%100
set /a z=14-dowmm,z/=12,y=dowyy+4800-z,m=dowmm+12*z-3,dow=153*m+2
set /a dow=dow/5+dowdd+y*365+y/4-y/100+y/400-2472630,dow%%=7,dow+=1
for /F "tokens=%dow% delims= " %%A in ("Mon Tues Wednes Thurs Fri Satur Sun") do set dow=%%Aday
goto :eof
:e
set ret=%1
if %ret:~0,1%==0 if "%ret:~1,1%#" NEQ "#" set ret=%ret:~1,1%
set /a %2=%ret%
goto :eof
:f
@set ermsg=BAD "/D" time: specify time 0-2359 *on Alarm day*, and *VALID*, *FUTURE* "/D[d]d[-[m]m[-yy]]" or "/D+#" day&set bad=1&set er=3&goto :w
:g
set ret=%1
if "%ret:~1,1%#"=="#" set ret=0%ret%
goto :eof
:h
@for /F "delims=0123456789" %%D in ("%1%2%3") do @if "%%D" NEQ "" goto :f
if "%1#"=="#" goto :f
set fd=%1
call :e %fd% fd
if "%2#" NEQ "#" (set fm=%2) else set fm=%dt:~4,2%
call :e %fm% fm
if "%3#" NEQ "#" (set fy=20%3) else set fy=%dt:~0,4%
if "%t:~0,1%"=="+" goto g:
if %fy% LSS %nwy% goto :f
(if %fm% GTR 12 goto :f)&if %fm% LSS 1 goto :f
(if %fd% GTR 31 goto :f)&if %fd% LSS 1 goto :f
(if %t% GTR 2359 goto :f)&if %t% LSS 0 goto :f
set /a uyy=%fy%,umm=%fm%,udd=%fd%,uhh=%nh%,unn=%nm%,uss=%ns%
call :g %fm%
set fdt=%fy%%ret%
call :g %fd%
set fdt=%fdt%%ret%
%win%xcopy.exe /D:%fm%-%fd%-%fy% /L /Y . .. >NUL 2>&1 || goto :f
if %bad%==1 goto :f
if %dt:~0,8% GTR %fdt% goto :f
call :b
set /a dhm=(%secs%-%orgsecs%)/86400*24
goto :eof
:i
set just1=1
if "%1"=="Image" goto :eof
if exist %TMPO%%fnb% del /F %TMPO%%fnb%
set fnw=%fnb:~0,4%W%fnb:~5%
if exist %TMPO%%fnw% del /F %TMPO%%fnw%
goto :eof
:j
set fnb=%1
for /F "delims=" %%B in ('%win%findstr.exe /bc:"REM " %TMPO%%fnb%') do set rmk=%%B
for /F "delims=" %%B in ('%win%findstr.exe /bc:"rem " %TMPO%%fnb%') do set prevrmk=%%B
set rmk=%rmk:~4%
set prevrmk=%prevrmk:~4%
if "%rptltr%"=="A" goto :eof
if exist %TMPO%ALRMW%fnb:~5,-4%.BAT if exist %win%Tasks\ALRMW%fnb:~5,-4% goto :eof
set just1=0
for /F %%B in ('%tsk% %ex%" /FI "WINDOWTITLE eq %rmk%"') do if !just1!==1 (goto :eof) else call :i %%B
goto :eof
:k
call :e %dt:~4,2% m
call :e %dt:~6,2% d
if "%iDate%"=="0" set dtfmt=mdy
if "%iDate%"=="1" set dtfmt=dmy
if "%iDate%"=="2" set dtfmt=ymd
set /a %dtfmt:~0,1%=!%dtfmt:~0,1%!
set /a %dtfmt:~1,1%=!%dtfmt:~1,1%!
set /a %dtfmt:~2,1%=!%dtfmt:~2,1%!
goto :eof
:l
if %dtfmt%==mdy set %1=%umm%%dtsep%%udd%%dtsep%%uyy%
if %dtfmt%==dmy set %1=%udd%%dtsep%%umm%%dtsep%%uyy%
if %dtfmt%==ymd set %1=%uyy%%dtsep%%umm%%dtsep%%udd%
goto :eof
:m
set dummy4=%~1
set dummy4=!dummy4:%ae%=%ab%!
set dummy4=!dummy4:%af%=%bb%!
set %2=%dummy4%
goto :eof
:n
set ret=
set dummy4=!dummy4:/%1=!
for /F "tokens=1,* delims=" %%A in ("%dummy4%") do if "%%B"=="" (set bad=1) else set "ret=%%B"&set "cml=%%A"&set "dummy4=%%A"
:o
if "%ret:~0,1%"==" " set ret=%ret:~1%&goto :o
goto :eof
:p
set dummy5=%~1
if /I %2==d if "%dummy5:~0,1%"=="+" set dummy5=%dummy5:~1%
if "%dummy5:~0,1%"==" " (set bad=1) else set ret=%~1&set "ret=!ret:~0,-1!"
goto :eof
:q
set ret=
set dummy5=!cml:/%1=!
set dummy5=!dummy5:"=!
for /F "tokens=1,* delims=" %%A in ("%dummy5%") do for /F "tokens=1 delims=/ " %%C in ("%%B ") do call :p "%%C " %1
goto :eof
:r
if "%~1"=="" goto :eof
for /F "skip=3 tokens=2 delims= " %%A in ('%tsk% %ex%" /FI "WINDOWTITLE eq %~1"') do if "%%A" NEQ "" %kill%
for /F "skip=3 tokens=2 delims= " %%A in ('%tsk% timeout.exe" /FI "WINDOWTITLE eq %~1"') do if "%%A" NEQ "" %kill%
goto :eof
:s
for /F "tokens=*" %%A in ('%cs% "%allargs%" "M" %fncnt%') do for /F "tokens=*" %%B in ("%%A") do set allargs=%%B
goto :eof
:t
set %1=
goto :eof
:u
set /a pos-=2
if "0" LSS "!dt:~%pos%,1!" set %1=!dt:~%pos%,2!&goto :eof
set /a dummy2=%pos%+1
set %1=!dt:~%dummy2%,1!
goto :eof
:v
set ermsg=/W{akes} and /R{epeats} are future, not present (+0), events&set er=4
:w
@echo/&echo   %ermsg%^^^! Aborting ...
@%cp%&exit /B %er%
--------
:x
if exist "%TEMP%\ALRM\ALRMG.bat" (call "%TEMP%\ALRM\ALRMG.bat") else call :ec&if "!er!"=="5" exit /B 5
if "%ANSI%"=="" set ANSI=1252
set ANSI=%cp% %ANSI%^^^^^^^>NUL
for /F "tokens=4" %%A in ('%cp%') do set cp=%cp% %%A ^>NUL&%cp% 437 >NUL
if "%exe%"=="" set exe=cmd.exe
set ex=%exe%
for %%A in (allargs dhm hlp) do call :t %%A
if /I "%exe:~0,3%"=="cmd" (set exe=%win%cmd.exe) else set exe=%~dps0bell.exe
if %~1#==# goto :jc
set kill=%wm% "processid=%%A" delete^>NUL 2^>^&1
set /a autokil=-1,clip=0,dummy2=0,er=0,prg=0,spk=0,wake=0
set cml=%*
set dummy=%cml:"=%
if "%Voice%" NEQ "" set Voice=$speak.SelectVoice('%Voice%');
if "%~1x"=="/?x" goto :jc
if /I "%~1x"=="-hx" goto :jc
if /I "%~1x"=="--helpx" goto :jc
if /I "%~1x"=="/Hx" echo/&echo Help printed to file "%~dpsn0.txt", q.v.&goto :jc
if not exist %exe% goto :jc
if not exist %TMPO%ALRMV.txt echo %Version%>%TMPO%ALRMV.txt
if /I "%~1x"=="/Ux" goto :zb
if "%Delay%"=="" set Delay=4
for /F "delims=0123456789" %%A in ("%Delay%") do if "%%A" NEQ "" set ermsg="Delay" variable must be numeric (currently "%Delay%")&set er=6&goto :w
if "%Volume%"=="" set Volume=80
if /I "%UnMute%X" NEQ "OnX" set UnMute=Off
for /F "delims=0123456789" %%A in ("%Volume%") do if "%%A" NEQ "" set ermsg="Volume" threshold must be numeric, in range 0-100 ^(currently "%Volume%"^)&set er=7&goto :w
if %Volume% GTR 99 (set vol=1.00) else set vol=0.%Volume%&if %Volume% LSS 10 set vol=0.0%Volume%&if %Volume% LSS 1 set vol=0
if /I "%~1x"=="/Tx" goto :yb
set vw=0
if /I "%~1"=="/V" set vw=1&goto :qb
if /I "%~1"=="/X" goto :qb
::Cancel All
set dummy4=%cml:"=%
if /I "%dummy4:~0,3%"=="/XA" echo/&goto :wb
for /F %%A in (%TMPO%ALRMV.txt) do if %%A NEQ %Version% set dummy3=%dummy4%&set cml=/XAAN&echo/&goto :wb
::Cancel one by number e.g. "/X2" (undocumented)
if /I "%dummy4:~0,2%" NEQ "/X" goto :y
set autokil=%dummy4:~2%
set k=%dummy4:~2%
set dummy4=&set kil=1
goto :rb
:y
set w="%TMPO%ALRM.vbs"
if not exist %w% call :fc
for /F %%A in ('%pw% "Get-Date -Format 'yyyyMMddHHmmss'"') do set dt=%%A
set /a plus=-1,pos=14
set nowd=%dt:~0,8%&set nowt=%dt:~8,6%&set otm=%dt:~12,2%&set uyy=%dt:~0,4%
for %%A in (uss unn uhh udd umm) do call :u %%A
set /a nwy=%uyy%,nwn=%umm%,nwd=%udd%,nh=%uhh%,nm=%unn%,ns=%uss%
call :b
set orgsecs=%secs%
set t=%~1
for /F "delims=0123456789+:APMapm" %%A in ("%t%") do if "%%A" NEQ "" set ermsg=Alarm time ("[[[h]h[:]]m]m[A|P[M]]" or "+m") is required. Command "%~nx0 /?" for Help&set er=8&goto :w
set /a bad=0,fncnt=0,len=0,pct=0,rptexp=-1,rptintvl=1,rptmins=0
for %%A in (amk bel fdt ffn msg rptA rptfnnum ret tmg) do call :t %%A
set repeat=#&set rptfrq=ONCE&set rptltr=N&set torg=%t%
::Delete canceled
if exist %TMPO%ALRMA*.BAT for /F %%A in ('dir /B %TMPO%ALRMA*.BAT') do call :j %%A
::Alarm filename
:z
set dummy=0
if exist %TMPO%ALRMA%fncnt%.BAT set dummy=1&for /F "delims=" %%B in ('%win%findstr.exe /bc:"REM " %TMPO%ALRMA%fncnt%.BAT') do set amk=%%B
if %dummy%==1 set amk=%amk:~4%
if %dummy%==1 for /F "skip=3 tokens=2 delims= " %%A in ('%tsk% %ex%" /FI "WINDOWTITLE eq %amk%"') do if "%%A" NEQ "" set dummy=3
if %dummy% LSS 3 if exist %TMPO%ALRMW%fncnt%.BAT set dummy=2
if %dummy%==2 %win%schtasks.exe /query /tn "ALRMW%fncnt%" >NUL 2>&1
if %dummy%==2 if %errorlevel%==0 set dummy=3
if %dummy% LSS 3 (
	if exist %TMPO%ALRM?%fncnt%.BAT del %TMPO%ALRM?%fncnt%.BAT
	set fn=%TMPO%ALRMA%fncnt%.BAT
) else set /a "fncnt+=1"&set rmk=&goto :z
set dummy4=%cml:"=%
for /F "tokens=2 delims= " %%A in ("%dummy4%") do if "%%A#"=="#" goto :ma
if "%dummy4%"=="%dummy4:/p=%" goto :aa
call :n p
if %bad%==1 set ermsg=No program defined&set er=9&goto :w
set prg=2&set bel= /QQ&set allargs=/P%ret%&goto :ca
:aa
if "%dummy4%"=="%dummy4:/f=%" goto :ba
call :n f
if %bad%==1 set ermsg=No filename given&set er=10&goto :w
if not exist "%ret:=%" set ermsg=File "%ret:=%" not found&set er=11&goto :w
set allargs=/F%ret%
set prg=1&set ffn=%ret%
:ba
if "%dummy4%" NEQ "%dummy4:/c=%" for /F "tokens=1 delims=" %%A in ("!dummy4:/c=!") do set "cml=%%A"&set "dummy4=%%A"&set clip=1&set prg=1&set allargs=/C
:ca
if "%dummy4%"=="%dummy4:/d=%" goto :da
if %dummy4:~0,1%==+ goto :f
call :q d
if %bad%==1 goto :f
set fdt=%ret%
if "%fdt:~8,1%#" NEQ "#" goto :f
if "%fdt:~0,1%"=="+" set plus=-3&set fdt=%fdt:~1%
for /F "delims=0123456789-" %%A in ("%fdt%") do if "%%A" NEQ "" goto :f
set wake=1
if %plus%==-3 set /a "dhm=%fdt%*24"&goto :da
set /a plus=-3,bad=0
for /F "tokens=1-3 delims=-" %%A in ("%fdt%") do call :h %%A %%B %%C
if %bad%==1 exit /B %er%
:da
if "%dummy4%"=="%dummy4:/q=%" goto :ea
if "%dummy4%" NEQ "%dummy4:/qqq=%" set bel= /QQQ&goto :ea
if "%dummy4%" NEQ "%dummy4:/qq=%" (set bel= /QQ) else set bel= /Q
:ea
if "%dummy4%" NEQ "%dummy4:/w=%" set wake=1
if "%dummy4%" NEQ "%dummy4:/s=%" (
	set spk=1
	if %prg%==0 set prg=1
	if "%bel%"=="" set bel= /QQ
)
if %plus%==-2 goto :ma
if %spk%==1 if %clip%==1 set clip=2&set prg=2&set spk=2&if "%bel%"=="" set bel= /QQ
if "%t%"=="+0" if %wake%==1 goto :v
if "%dummy4%"=="%dummy4:/r=%" if "%dummy4%" NEQ "%dummy4:/e=%" set ermsg=Missing "/Rm" m{inutes} interval&set er=12&goto :w
if "%dummy4%"=="%dummy4:/r=%" goto :ka
if "%dummy4%"=="%dummy4:/rr=%" goto :fa
call :q rr
set rptltr=A&for /F "tokens=1,2 delims=-" %%A in ("%ret%") do set rptfnnum=%%A&set rptmins=%%B
if exist %TMPO%ALRMA%rptfnnum%.BAT call :j ALRMA%rptfnnum%.BAT
if %prg%==0 if exist %TMPO%ALRMA%rptfnnum%.BAT del %TMPO%ALRMA%rptfnnum%.BAT
goto :ga
:fa
call :q r
if %bad%==1 set ermsg=Missing "/Rm" m{inutes} interval&set er=13&goto :w
for /F "delims=0123456789" %%A in ("%ret%") do if "%%A" NEQ "" set ermsg=Non-numeric "/Rm" m{inutes} interval "%ret%"&set er=14&goto :w
set rptltr=R&set rptmins=%ret%&set rptfnnum=%fncnt%&set wake=1&set repeat= /R%rptmins%
if "%t%"=="+0" if %wake%==1 goto :v
if %rptmins%==0 set ermsg=/R0 does not Repeat&set er=15&goto :w
::Taskschd minutes over 9999 must be divisible by 60
set dummy2=0
if %rptmins% GTR 9999 set /a dummy2=%rptmins%%%60
if %rptmins% GTR 9999 if %dummy2% GTR 0 set /a rptmins=%rptmins%+(60-%dummy2%)
if %rptmins% LSS 2 (goto :ga) else set rptintvl=%rptmins%
if %rptmins% GTR 40320 set ermsg=Out of bounds: /R value range=1-40320 minutes (Repeat every month)&set er=16&goto :w
set rptfrq=ONCE
if %rptintvl%==1440 set rptfrq=DAILY
if %rptintvl% GTR 1440 set rptfrq=WEEKLY
if %rptintvl% GTR 10080 set rptfrq=MONTHLY
:ga
set rptA= /RR%rptfnnum%-%rptmins%
if "%rptltr%#" NEQ "A#" goto :ha
if not exist %TMPO%ALRME%rptfnnum%.txt goto :ja
for /F "tokens=1 delims=#" %%A in (%TMPO%ALRME%rptfnnum%.txt) do set /a dummy4=%%A-%rptmins%
if %dummy4% LSS 1 (set rptexp=0) else set rptexp=%dummy4%
goto :ia
:ha
if "%dummy4%"=="%dummy4:/e=%" goto :ja
call :q e
if %bad%==1 set ermsg=Missing "/Em" m{inutes} expiration&set er=17&goto :w
for /F "delims=0123456789" %%A in ("%ret%") do if "%%A" NEQ "" set ermsg=Non-numeric "/Em" m{inutes} expiration "%ret%"&set er=18&goto :w
if %ret% LSS %rptmins% set ermsg=Expiration "/E%ret%" precedes repeat interval "/R%rptmins%"&set er=19&goto :w
set /a rptexp=%ret%+1
:ia
if %rptexp% GTR 0 echo %rptexp%#>%TMPO%ALRME%rptfnnum%.txt
:ja
if %spk% GTR 0 set rptA= /S%rptA%
:ka
if "%ffn%" NEQ "" if %spk%==1 set prg=2&set spk=2&if "%bel%"=="" set bel= /QQ
::GetMessage
if %clip%==1 goto :ma
if "%ffn%" NEQ "" goto :ma
if %prg%==2 goto :ma
:la
if "%~2#"=="#" goto :ma
set dummy4=%2
set dummy4=%dummy4:"=%
if "%dummy4:~0,1%#"=="/#" shift /2&goto :la
set dummy=%cml:"=%
for /F "tokens=2 delims=" %%A in ("!dummy:%dummy4%=%dummy4%!") do set msg=%%A
set msg=%msg:=%
if "%msg%" NEQ "%msg:`pct`=%" set pct=1
set dummy4=%msg%�
for %%A in (4096 2048 1024 512 256 128 64 32 16 8 4 2 1) do @if "!dummy4:~%%A,1!" NEQ "" set /a "len+=%%A"&set "dummy4=!dummy4:~%%A!"
if %prg%==0 if %len% GTR 0 set prg=1
:ma
set ret=0
if /I "%bel%"==" /Q" if %wake%==0 if %clip%==0 if "%ffn%"=="" if %prg%==0 if %len%==0 set ret=1
if %spk% GTR 0 (
	if %wake%==0 if %clip%==0 if "%ffn%"=="" if %prg%==1 if %len%==0 set ret=1
	if /I "%bel%"==" /Q" set ret=1
)
if %ret%==1 set ermsg=Nonsensical, incompatible, or inconsequential command&set er=20&goto :w
if %len%==0 goto :na
if %prg%==2 goto :na
if %len% GTR 100 (set tmg=: %ae%%msg:~0,100% ...%af%) else set tmg=: %ae%%msg%%af%
::Now time
:na
if "%msg%" NEQ "" set allargs=%msg%
::Alarm time
set dummy=%t::=%
set t=
:oa
if "%dummy:~-1%"=="" goto :pa
set t=%dummy:~-1%%t%
set dummy=%dummy:~0,-1%
goto :oa
:pa
if "%t%"=="%t:+=%" goto :qa
set "plus=%t:~1%"
for /F "delims=0123456789" %%A in ("%plus%X") do if "%%A" NEQ "X" set ermsg=BAD TIME: "%~1"&set er=21&goto :w
goto :ra
:qa
if "%t:~0,1%"=="0" if %t% NEQ 0 set t=%t:~1%&goto :qa
set ap=%t:~-1%
if /I %ap%==M set ap=%t:~-2,1%&set t=%t:~0,-1%
if /I %ap%==A set t=%t:~0,-1%
if /I %ap%==P set t=%t:~0,-1%
for /L %%A in (1,1,3) do if "!t:~3!x"=="x" set t=0!t!
if "%t:~3%x"=="x" set t=
for /F "delims=0123456789" %%A in ("%t%X") do if "%%A" NEQ "X" set ermsg=BAD TIME: "%~1"&set er=22&goto :w
set tm=%t:~-2,2%
call :e %tm% tm
set th=%t:~0,-2%
call :e %th% th
if /I %ap%==A if %th%==12 set th=0
if /I %ap%==A if %th%==24 set th=0
if /I %ap%==A if %th% LEQ %nh% if %tm% LEQ %nm% set /a th+=24
if /I %ap%==P if %th%==24 set th=0
set /a thmod=%th%%%24
if /I %ap%==P if %thmod% LSS 12 set /a th+=12
if /I %ap%==A if %thmod% GTR 11 set ermsg=BAD TIME: "AM" alarm after 11:59 hours&set er=23&goto :w
if /I %ap%==P if %th% LEQ %nh% if %tm% LEQ %nm% set /a th+=24
::Differential in seconds
:ra
if %rptltr%==A set /a plus+=%rptmins%
if %plus%==-3 set /a th=%th%+%dhm% &set plus=-1
if %plus% GTR -1 set /a th=%nh%,tm=%nm%+%plus%&goto :sa
if %th% LSS %nh% set /a th+=24
if %th%==%nh% if %tm% LEQ %nm% set /a th+=24
if %tm% LSS %nm% set /a tm+=60,th-=1
:sa
set /a th=(%tm%*60+%th%*60*60)/3600,tm=%tm%%%60
set /a h=%th%-%nh%,m=%tm%-%nm%
::Timeout
if %plus% GTR -1 (set /a s=%t:~1%*60) else set /a s=(%h%*60+%m%)*60-%ns%
::Info
if %m% LSS 0 set /a m+=60,h-=1
set /a mod=%s%%%60
if %mod% NEQ 0 if %mod% LSS 30 set /a m-=1
if %s% LSS 60 set m=0
if %plus% GTR -1 set m=%t:~1%
if %tm%==60 set /a th+=1,tm=0
set days=0
:ta
if %th% GTR 23 (
	set /a th-=24,days+=1
	goto :ta
)
set ah=%th%
if %tm% LSS 10 set tm=0%tm%
set /a s1=%s%,m1=%m%,h1=%h%
if %wake%==0 goto :wa
::Wake code
for /F "tokens=3" %%A in ('%reg% sDate 2^>NUL') do set dtsep=%%A
if "%dtsep%"=="" set dtsep=/
for /F "tokens=3" %%A in ('%reg% iDate 2^>NUL') do set iDate=%%A
call :k
set waketh=%ah%
if %days% GTR 0 set /a waketh=%ah%+24*%days%
if %waketh% LSS 10 set waketh=0%waketh%
set waketh=%waketh%%tm%
if %plus% GTR -1 set /a secs=%orgsecs%+(%plus%*60)&goto :ua
call :e %ah% dummy1
call :e %tm% dummy2
if %waketh% GTR 2359 (set /a uyy=%nwy%,umm=%nwn%,udd=%nwd%,uhh=23,unn=59,uss=59) else set /a uyy=%nwy%,umm=%nwn%,udd=%nwd%,uhh=%dummy1%,unn=%dummy2%,uss=0
call :b
if %waketh% LSS 2400 goto :ua
set /a dummy=%waketh%%%2400
set /a dummy2=(%dummy%/100)*3600
set /a dummy3=%dummy%%%100*60+%dummy2%
set /a secs=%dummy3%+%secs%+1,dummy2=%waketh%/2400
if %dummy2% GTR 1 set /a secs+=(%dummy2%-1)*86400
:ua
call :e %secs% secs1
call :c
set orgtime=%uyy%-%umm%-%udd%T%uhh%:%unn%:%uss%
call :e %uss% orguss
set /a secs=%secs1%+120-%orguss%
call :c
set strtact1=%uhh%:%unn%:%uss%
call :l strtdt
set strtact2=%uyy%-%umm%-%udd%T%uhh%:%unn%:00
set /a secs=%secs1%+180-%orguss%+%rptmins%*60
call :c
set endact1=%uhh%:%unn%:00
set /a dur=%rptmins%+1
if %dur% LSS 10 set dur=00:0%dur%&goto :va
if %dur% LSS 60 set dur=00:%dur%&goto :va
set /a dummy=%dur%/60,dummy2=%dur%%%60
if %dummy% LSS 10 set dummy=0%dummy%
if %dummy2% LSS 10 set dummy2=0%dummy2%
set dur=%dummy%:%dummy2%
:va
set endact2=%uyy%-%umm%-%udd%T%uhh%:%unn%:00
set /a secs=%secs1%+%Delay%
call :c
set endact3=%uyy%-%umm%-%udd%T%uhh%:%unn%:%uss%
if %rptexp%==-1 goto :wa
set /a secs=%secs1%+%Delay%+60*(%rptexp%-1)
call :c
set endact3=%uyy%-%umm%-%udd%T%uhh%:%unn%:%uss%
:wa
if %th% LSS 10 set th=0%th%
for %%A in (hours minutes) do call :t %%A
if %h1% GTR 0 set hours=%h1% hour
if %h1% GTR 1 set hours=%hours%s
if %plus% GTR -1 if %h1% GTR 0 if %m1% GTR 59 set /a m1=%m1%%%(%h1%*60)
if %m1% GTR 0 set minutes=%m1% minute
if %h1% GTR 0 if %m1% GTR 0 set minutes= %minutes%
if %m1% GTR 1 set minutes=%minutes%s
if "%fdt%"=="%nowd%" if %th%%tm%%otm% LSS %nowt% goto :f
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
if %dummy3%==1 if %mod%==0 (set msg=%msg%, %hours%%minutes%) else set msg=%msg%, �%hours%%minutes%
set msg=%msg%^^^)
if /I "%UnMute%"=="On" if not exist %TMPO%ALRM.ps1 call :gc
if %wake%==0 goto :write
::Wake
@for /F "tokens=1,4 delims= " %%A in ('%win%sc.exe query "Schedule"') do @if /I "%%A"=="STATE" if /I "%%B" NEQ "RUNNING" %win%sc.exe start "Schedule"
@for /F "tokens=4" %%A in ('%win%powercfg.exe /getactivescheme') do set GUID=%%A
for /F "delims=" %%A in ('%win%powercfg.exe -q %GUID% ^|%win%findstr.exe /c:"(Sleep)"') do for /F "tokens=3 delims= " %%B in ("%%A") do set SleepGUID=%%B
for /F "delims=" %%A in ('%win%powercfg.exe -q %GUID% ^|%win%findstr.exe /c:"(Allow wake timers)"') do for /F "tokens=4 delims= " %%B in ("%%A") do set WakeGUID=%%B
for %%A in (ac dc) do %win%powercfg.exe -set%%Avalueindex %GUID% %SleepGUID% %WakeGUID% 001
if not exist %TMPO%ALRM.exe call :ic
if %er% GTR 0 goto :w
::ALRMW
set dummy=
set k=%TMPO%ALRMW%fncnt%.bat
echo @echo off>%k%
echo setlocal>>%k%
if %rptltr% NEQ N if "%repeat:~0,3%#"==" /R#" set dummy=%repeat:~3%
echo %TMPO%ALRM.exe>>%k%
if %rptltr% NEQ N goto :ya
call :m "%tmg%" dummy4
echo for /F "tokens=1 delims= " %%%%A in ^('%tsk% %ex%" /FI "WINDOWTITLE eq %tmg%"'^) do if "%%%%A"=="Image" for /F "skip=3 tokens=2 delims= " %%%%B in ^('%tsk% %ex%" /FI "WINDOWTITLE eq %tmg%"'^) do if "%%%%B" NEQ "" %wm% "processid=%%%%B" delete^>NUL 2^>^&1 >>%k%
if %prg%==0 echo call %~fs0 +0%bel% %allargs% >>%k%
if %prg% NEQ 1 goto :xa
if %spk%==0 if %clip%==0 echo call %~fs0 +0%bel% %allargs% >>%k%
if %spk%==1 if "%ffn%" NEQ "" echo call %~fs0 +0%bel% %allargs% >>%k%
if %spk%==1 if "%ffn%"=="" if %clip%==0 echo %~fs0 +0%bel% /S %allargs% >>%k%
if %clip%==1 echo call %~fs0 +0%bel% %allargs%>>%k%
:xa
if %prg%==2 if %spk% LSS 2 echo call %~fs0 +0%bel% %allargs:="% >>%k%
if %prg%==2 if "%bel%" NEQ "" if %spk%==2 echo call %~fs0 +0%bel% /S %allargs:="% >>%k%
echo ^(goto^) 2^>NUL^&if exist %TMPO%ALRMA%fncnt%.BAT del /F %TMPO%ALRMA%fncnt%.BAT>>%k%
goto :za
:ya
if "%allargs%"=="" (set dummy3=) else set dummy3=%allargs:="%
if "%bel%"=="" echo start /MIN %win%cmd.exe /c %~fs0 +0%rptA% %dummy3% >>%k%
if "%bel%"=="" goto :za
echo start "Wake/Repeat-%fncnt%" /MIN %exe% /c %~fs0 +0%rptA%%bel% %dummy3% >>%k%
:za
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
"%win%schtasks.exe" /query /tn ALRMW%fncnt% /xml >%TMPO%ALRMW%fncnt%.xml
set w="%TMPO%ALRMW%fncnt%.vbs"
echo Dim fn,txt,pos1,pos2,pos3 >%w%
echo fn="%TMPO%ALRMW%fncnt%.xml">>%w%
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
if %rptfrq%==WEEKLY call :d %uyy% %umm% %udd%
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
if %rptltr%==N call :m "%tmg%" dummy3
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
"%win%schtasks.exe" /create /tn ALRMW%fncnt% /xml "%TMPO%ALRMW%fncnt%.xml" /f >NUL
del /F %w%
del /F "%TMPO%ALRMW%fncnt%.xml"
:Write
setlocal disableDelayedExpansion
echo @echo off >%fn%
echo REM %tmg%>>%fn%
echo rem %tmg%>>%fn%
if %wake%==1 if "%rptltr%" NEQ "A" (
	echo pause^>NUL>>%fn%
	echo ^(goto^) 2^>NUL^&if exist %fn% del /F %fn%>>%fn%
	goto :fb
)
echo setlocal>>%fn%
if %rptltr%==N (
	echo set t=%s% >>%fn%
	if %s% GTR 99999 (
		if %s% GTR 199998 echo :aaa>>%fn%
		echo %to% 99999 ^>NUL>>%fn%
		echo set /a t-=99999 >>%fn%
		if %s% GTR 199998 echo if %%t%% GTR 99999 goto :aaa>>%fn%
	)
	echo %to% %%t%% ^>NUL>>%fn%
)
if /I "%bel%"==" /QQ" set bel= /Q&echo %pw% -file "%TMPO%ALRM.ps1" -snd 1 -vol %vol%>>%fn%
set ps=0
if /I %UnMute%==On if /I "%bel%" NEQ " /Q" (
	set ps=1
	echo %pw% -file "%TMPO%ALRM.ps1" -snd 1 -vol %vol%>>%fn%
	if %spk%==0 echo set e=%%errorlevel%% >>%fn%
)
::Can't set dummy2 for spk=1 because shuts off sound before speech is finished
if /I "%bel%" NEQ " /Q" if %ps%==1 if %spk%==0 (
	echo if %%e:~0,1%%==1 set dummy2=^&goto :xxx>>%fn%
	echo set s=%%e:~1%% >>%fn%
	echo if %%s%%==0 set vol=0 >>%fn%
	echo if %%s%% GTR 0 if %%s%% LSS 100 set vol=0.%%s%%>>%fn%
	echo if %%s%%==100 set vol=1.00>>%fn%
	echo set dummy2=%pw% -file "%TMPO%ALRM.ps1" -snd %%e:~0,1%% -vol %%vol%%>>%fn%
	echo :xxx>>%fn%
)
if %prg%==0 if "%rptltr%" NEQ "N" @echo start "%rmsg%" /MIN %exe% /c %to% %Delay% /NOBREAK ^^^>NUL>>%fn%
:: Convert �� in Title to ANSI; reset "Alarm " to "Repeat"
if "%rmk%"=="" (set dummy3=%tmg%) else set dummy3=%rmk%
call :m "%dummy3%" dummy4
if "%rmk%" NEQ "%prevrmk%" call :m "%prevrmk%" dummy5
if %spk%==0 if %prg%==1 for /F "usebackq" %%A in (`%wm% "caption='more.com' and commandline like '%%%%ALRMC%fncnt%.txt%%%%'" get processid 2^>^&1`) do @for /F "delims=0123456789" %%D in ("%%AX") do @if "%%D"=="X" %kill%
if %pct%==1 call :s
if %spk%==0 if %prg%==1 if %rptltr%==N (
	if %clip%==1 (
		echo start "%tmg%" %exe% /c %cs% %fncnt% "C"^^^&echo/^^^&echo/^^^&%ANSI%^^^&%mr% "%TMPO%ALRMC%fncnt%.txt"^^^&pause^^^>NUL>>%fn%
	) else (
		if "%ffn%" NEQ "" (
			echo start "%tmg%" %exe% /c echo/^^^&echo/^^^&%ANSI%^^^&%mr% "%ffn:=%"^^^&echo/^^^&echo 			    ^^^^^^^< Hit any key to Dismiss ^^^^^^^>^^^&pause^^^>NUL>>%fn%
		) else (
			if %wake%==0 echo start "%tmg%" %exe% /c echo/^^^&echo/^^^&%ANSI%^^^&%cs% "%allargs%" "M" %fncnt%^^^&%mr% "%TMPO%ALRMC%fncnt%.txt"^^^&pause^^^>NUL>>%fn%
			if %wake%==1 echo start "%dummy4%" %exe% /c echo/^^^&echo/^^^&%ANSI%^^^&%cs% "%allargs%" "M" %fncnt%^^^&%mr% "%TMPO%ALRMC%fncnt%.txt"^^^&pause^^^>NUL>>%fn%
		)
	)
)
if %spk%==0 if %prg%==1 if %rptltr% NEQ N (
	if %clip%==0 (
		if "%ffn%"=="" (
			echo start "%dummy3%" %exe% /c echo/^^^&echo/^^^&%ANSI%^^^&%cs% "%allargs%" "M" %fncnt%^^^&%mr% "%TMPO%ALRMC%fncnt%.txt"^^^&pause^^^>NUL^^^&exit>>%fn%
		) else (
			echo start "%tmg%" %exe% /c echo/^^^&echo/^^^&%ANSI%^^^&%mr% "%ffn:=%"^^^&echo/^^^&echo 			    ^^^^^^^< Hit any key to Dismiss ^^^^^^^>^^^&pause^^^>NUL>>%fn%
		)
	) else echo start "%dummy3%" %exe% /c echo/^^^&echo/^^^&%ANSI%^^^&%cs% %fncnt% "C"^^^&%mr% "%TMPO%ALRMC%fncnt%.txt"^^^&pause^^^>NUL^^^&exit>>%fn%
	
)
set dummy6="%TMPO%ALRMR%rptfnnum%.BAT"
if %rptltr%==A (
	if exist %dummy6% del /F %dummy6%
	call :r "%rmk%"
	call :r "%prevrmk%"
	if %prg%==1 call :r "%dummy4%"
	if defined dummy5 call :r "%dummy5%"
)
if exist %dummy6% del /F %dummy6%
if %rptltr% NEQ A goto :cb
echo @echo off>%dummy6%
if %rptexp%==0 goto :ab
echo start "%tmg%" /MIN %exe% /c echo/^^^&echo/^^^&pause^^^>NUL>>%dummy6%
echo echo @echo off^>"%TMPO%ALRMA%rptfnnum%.BAT">>%dummy6%
echo @echo REM %tmg%^>^>"%TMPO%ALRMA%rptfnnum%.BAT">>%dummy6%
echo @echo rem %rmk%^>^>"%TMPO%ALRMA%rptfnnum%.BAT">>%dummy6%
echo @echo pause^>NUL^>^>"%TMPO%ALRMA%rptfnnum%.BAT">>%dummy6%
echo @echo ^^^(goto^^^) 2^^^>NUL^^^&if exist "%TMPO%ALRMA%rptfnnum%.BAT" del /F "%TMPO%ALRMA%rptfnnum%.BAT"^>^>"%TMPO%ALRMA%rptfnnum%.BAT">>%dummy6%
if %rptexp%==-1 goto :cb
if %rptexp% GTR 0 goto :bb
::If %rptexp%=0: NOT called if not ALRMR
:ab
echo if exist "%TMPO%ALRME%rptfnnum%.txt" del /F "%TMPO%ALRME%rptfnnum%.txt">>%dummy6%
set /a dummy4=30-%Delay%*2
echo %to% %dummy4% /NOBREAK^>NUL>>%dummy6%
echo %win%schtasks.exe /delete /tn ALRMW%rptfnnum% /F>>%dummy6%
echo if exist "%TMPO%ALRMC%fncnt%.txt" del /F "%TMPO%ALRMC%fncnt%.txt">>%dummy6%
echo if exist "%TMPO%ALRMW%rptfnnum%.bat" del /F "%TMPO%ALRMW%rptfnnum%.bat">>%dummy6%
echo start /MIN %exe% /c %~fs0 /X%rptfnnum% >>%dummy6%
:bb
echo exit>>%dummy6%
:cb
if %spk%==1 if /I "%bel%" NEQ " /QQQ" goto :db
if /I "%bel%"==" /Q" goto :db
if /I "%bel%"==" /QQ" goto :db
for %%A in (2 1 2) do echo echo >>%fn%&echo %to% %%A /NOBREAK^>NUL>>%fn%
:db
if %prg% NEQ 2 goto :eb
if %spk%==2 goto :eb
if "%allargs%" NEQ "" set allargs=%allargs:/P=%
if "%allargs%" NEQ "" set allargs=%allargs:="%
if %ps%==0 echo start "%dummy%" %allargs% >>%fn%
if %ps%==1 echo start "%dummy%" /WAIT %allargs%^&%%dummy2%% >>%fn%
echo ^(goto^) 2^>NUL^&if exist "%%~dpsnx0" del /F "%%~dpsnx0">>%fn%
goto :fb
:eb
if %spk%==1 echo %to% 1 /NOBREAK^>NUL>>%fn%
if %spk%==1 if %rptltr% NEQ R echo start /MIN %cs% "%allargs%" "S" "%voice%">>%fn%
if %clip%==0 if %spk%==2 if %rptltr% NEQ R echo start /MIN %pw% -c "Add-Type -AssemblyName System.Speech;$words=(Get-Content '%ffn:=%');$speak=(New-Object System.Speech.Synthesis.SpeechSynthesizer);%Voice%$speak.Speak($words);">>%fn%
if %clip%==2 if %rptltr% NEQ R echo start /MIN %pw% -c "Add-Type -AssemblyName System.Speech;$words=(Get-Clipboard);$speak=(New-Object System.Speech.Synthesis.SpeechSynthesizer);%Voice%$speak.Speak($words);">>%fn%
if %ps%==1 if %spk%==0 echo %%dummy2%% >>%fn%
echo ^(goto^) 2^>NUL^&if exist %fn% del /F %fn%>>%fn%
::Execute
:fb
if %rptltr%==N if %spk% GTR 0 (
	start "Launcher" /MIN %exe% /c start "%tmg%" /MIN /WAIT %exe% /c %fn%
	%to% %Delay% /NOBREAK>NUL
	call :r Launcher
)
if %spk%==0 start "%tmg%" /MIN %exe% /c %fn%
if %rptltr%==R if %spk% GTR 0 start "%tmg%" /MIN %exe% /c "%TMPO%ALRMA%rptfnnum%.BAT"
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
	if %wake%==0 @%cp%&echo   %msg%&exit /B 0
	if %wake%==1 set msg=Wake%msg:~5%
)
if %rptltr% NEQ R goto :hb
for %%A in (dummy2 dummy3) do call :t %%A
if %rptmins%==1 (set dummy=minute) else set dummy=%rptmins% minutes
if %rptmins% GTR 1439 set /a dummy2=(%rptmins%*100)/1440
if "%dummy2%" NEQ "" if "%dummy2%"=="2800" set dummy=%dummy% (1 month)
if "%dummy2%" NEQ "" if "%dummy2%" NEQ "2800" set dummy=%dummy% (%dummy2:~0,-2%.%dummy2:~-2% days)
if "%dummy2%"=="" if %rptmins% GTR 59 set /a dummy3=%rptmins%/60
if "%dummy3%" NEQ "" set /a dummy2=%rptmins%%%60
if "%dummy3%" NEQ "" set dummy=%dummy% (%dummy3% hours %dummy2% mins)
set dummy2=Wake [and Repeat every %dummy% thereafter
if %rptexp%==-1 goto :gb
set /a dummy=%rptexp%-1
if %dummy%==1 (set dummy3=minute) else set dummy3=minutes
set dummy2=%dummy2%, for %dummy% %dummy3%
:gb
set msg=%dummy2%]%msg:~6%
:hb
echo   %msg%
if %rptltr%==A @%cp%&exit /B 0
if %wake%==1 if %rptltr%==N if "%torg%"=="+0" (goto) 2>NUL &if exist %TMPO%ALRM?%fncnt%.BAT del /F %TMPO%ALRM?%fncnt%.BAT
@%cp%&exit /B 0
-------------
:ib
set just1=1
set dmsg=%~1
set dmsg=%dmsg:~4%
goto :eof
:jb
set res=%~1
if "%res:~-1,1%" NEQ " " goto :eof
set res=%res:~0,-1%
goto :eof
:kb
set num=%~1
call :jb "%num:~5,3%"
set num=%res%
if not exist %TMPO%ALRMW%num%.bat goto :eof
set validnums=%validnums%g%num%g
if "%validnums%"=="g%num%g" echo/&echo Wake number^(s^):
set k=%num%
call :tb
echo   #%num%	%dmsg%
goto :eof
:lb
set just1=1
set wmsg=%*
set wmsg=%wmsg:~4%
goto :eof
:mb
set num=%~n1
set num=%num:~5%
set wmsg=
if exist %TMPO%ALRMW%num%.bat set /a wcnt+=1&goto :eof


set /a acnt+=1
if %acnt%==1 echo/&echo Alarm number^(s^):
set just1=0
for /F "skip=1 tokens=*" %%A in (%TMPO%ALRMA%num%.BAT) do if !just1!==1 (goto :nb) else call :lb %%A 
:nb
if defined wmsg echo   #%num%	%wmsg%
goto :eof
:ob
call :r "%~1"
goto :eof
:pb
set dummy3=%dmsg:~4%&set dummy=1
if "%dmsg:~4,1%" NEQ " " set dummy3=%dmsg:~5%&set dummy=0
if "%dmsg:~5,1%" NEQ " " set dummy3=%dmsg:~6%&set dummy=2
if %dummy%==0 call :ob "Alarm%dummy3%"
if %dummy%==1 call :ob "Wake%dummy3%"
if %dummy%==2 call :ob "Repeat%dummy3%"
goto :eof
:qb
set validnums=
set /a wcnt=0,acnt=0,kil=0
if exist %TMPO%ALRMA*.BAT for /F %%A in ('dir /B %TMPO%ALRMA*.BAT') do call :mb %%A
for /F "tokens=1-4 delims= " %%A in ('%win%schtasks.exe /query^|%win%findstr.exe /c:ALRMW') do call :kb %%A %%B %%C %%D
set /a cnt=%wcnt%+%acnt%
if %cnt%==0 echo/&echo   No Alarms&echo   No Wakes^|Repeats&@%cp%&exit /B 0
if %vw%==1 for /F %%A in ('%pw% "Get-Date -Format 'yyyyMMddHHmmss'"') do set dt=%%A
if %vw%==1 echo/&echo 	^( Now:	  %dt:~8,4%.%dt:~12,2% hours ^)&echo ^( Cancel one[all] Alarm^|Wake/Repeat^(s^):  %~nx0 /X[A] ^)&@%cp%&exit /B 0
set kil=1
echo/
if %cnt%==1 if %num% LEQ 25 set k=%num%&set autokil=-2&goto :wb
set k=-1
set /p k=Number to Kill (or "All"):  
set k=%k: =%&set k=!k:#=!&set k=!k:"=!
if "%k%"=="-1" set ermsg=No number&set er=24&goto :w
if /I "%k%"=="ALL" echo/&goto :wb
:rb
for /F "delims=0123456789" %%A in ("%k%X") do if "%%A" NEQ "X" set ermsg="%k%" is not a number&set er=25&goto :w
if not exist %TMPO%ALRMW%k%.bat (
	if exist %TMPO%ALRMA%k%.BAT echo/&goto :tb
	set ermsg=Non-existent task "ALRMA%k%"&set er=26&goto :w
)
echo/
for /F "tokens=3 delims= " %%A in ('%win%schtasks.exe /query^|%win%findstr.exe /c:ALRMW%k%') do set tm=%%A
%win%schtasks.exe /delete /tn ALRMW%k% /f >NUL
if %autokil%==-1 goto :tb
if exist %TMPO%ALRME%autokil%.txt del /F %TMPO%ALRME%autokil%.txt
set just1=0
if exist %TMPO%ALRMA%autokil%.bat for /F "skip=2 tokens=*" %%A in (%TMPO%ALRMA%autokil%.BAT) do if !just1!==1 (goto :sb) else call :ib "%%A"
:sb
if exist %TMPO%ALRMA%autokil%.bat call :pb
:tb
set just1=0
if exist %TMPO%ALRMA%k%.BAT for /F "skip=1 tokens=*" %%A in (%TMPO%ALRMA%k%.BAT) do if !just1!==1 (goto :ub) else call :ib "%%A"
:ub
if %kil%==0 goto :eof
call :pb
if exist %TMPO%ALRM?%k%.BAT del /F %TMPO%ALRM?%k%.BAT
if %autokil%==-1 echo Killed #%k%:&if defined dmsg echo 	%dmsg%
@%cp%&exit /B 0
:vb
set dummy=1
::Assume bell and timeout always deleteable, cmd not unless ...
if %3==0 if "%~2" NEQ "Alarm" if "%~2" NEQ "Wake" if "%~2" NEQ "Repeat" set dummy=0
if %dummy%==1 %wm% "processid=%~1" delete>NUL 2>&1
goto :eof 
::Kill ALL
:wb
if /I %ex%==bell.exe for /F "skip=3 tokens=2,10 delims= " %%A in ('%tskv% %ex%"') do if "%%A" NEQ "" call :vb "%%A" "%%B" 1
for /F "skip=3 tokens=2,10 delims= " %%A in ('%tskv% timeout.exe"') do if "%%A" NEQ "" call :vb "%%A" "%%B" 1
set cspec=%ComSpec%
:xb
if "%cspec%" NEQ "%cspec:\=%" for /F "tokens=1* delims=\" %%A in ("%cspec%") do set cspec=%%B&goto :xb
for /F "skip=3 tokens=2,10 delims= " %%A in ('%tskv% %cspec%"') do if "%%A" NEQ "" call :vb "%%A" "%%B" 0
::26 iterations
for /L %%A in (0,1,26) do @%win%schtasks.exe /delete /tn ALRMW%%A /F >NUL 2>&1
if exist %TMPO%ALRM*.BAT del /F %TMPO%ALRM*.BAT
if exist %TMPO%ALRM*.TXT del /F %TMPO%ALRM*.TXT
if %autokil%==-2 (set ret= ^(including Alarm #%num%^)) else set ret=
if /I "%cml:~3,1%" NEQ "A" echo Alarms #0 to #25 canceled%ret%&@%cp%&exit /B 0
@echo Working ^(canceling Alarms #0 to #1000^) ...
::1001 iterations
for /L %%A in (0,1,1001) do @%win%schtasks.exe /delete /tn ALRMW%%A /F >NUL 2>&1
if exist %TMPO%ALRM* del /F %TMPO%ALRM*
if exist %win%Tasks\ALRMW* del /F %win%Tasks\ALRMW*
if exist "%~dpsn0.txt" del /F "%~dpsn0.txt"
@echo/
if "%cml:~4,1%" NEQ "N" (@echo %~nx0 system cleaned) else @echo New %~nx0 version: system cleaned.&call %~dpsnx0 %dummy3%
@%cp%&exit /B 0
:yb
if not exist %TMPO%ALRM.ps1 call :gc
set pw2=%pw% -file "%TMPO%ALRM.ps1" -snd
if /I %UnMute%==On (%pw2% 1 -vol %vol%) else %pw2% 0
set e=%errorlevel%
set s=%e:~1%
if %s%==0 set vol=0
if %s%==100 set vol=1.00
if %s% GTR 0 if %s% LSS 100 set vol=0.%s%
if %s% NEQ 0 if %s:~0,1%==0 set s=%s:~1%
set s=%s%%%
if %e:~0,1% NEQ 1 if %e:~0,1% NEQ 3 set s=%s%, Muted
echo UnMute On^|Off:		%UnMute%
if /I %UnMute%==On echo Volume Threshold: 	%Volume%%%
echo System sound level:	%s%
for /F "tokens=4 delims=. " %%A in ('ver') do if %%A GEQ 10 (
	if not exist %TMPO%ALRM2.ps1 call :hc
	%pw% -file "%TMPO%ALRM2.ps1"
)
%to% %Delay% >NUL
@echo 
%to% %Delay% >NUL
if /I %UnMute%==On if "%e:~0,1%#" NEQ "1#" %pw% -file "%TMPO%ALRM.ps1" -snd %e:~0,1% -vol %vol%
@%cp%&exit /B 0
:zb
@echo/&@echo 	Testing connectivity ...
for /F %%A in ('%pw% -c "Test-Connection -ComputerName holmgren.org -Quiet -Count 1"') do if %%A==False set ermsg=No Internet connectivity&set er=1&goto :w
%cp%
%pw% -c "(New-Object Net.WebClient).DownloadFile('https://holmgren.org/ALRMV.txt','%~dps0ALRMV.txt')"
for /F %%A in (%~dps0ALRMV.txt) do set dummy=%%A
if exist %~dps0ALRMV.txt del /F %~dps0ALRMV.txt
if %dummy%==%Version% @echo You have the latest version (v%Version%)&@%cp%&exit /B 0
set /p dummy2=Download version "%dummy%"? (you have v%Version%) [Y^|N]: 
if /I "%dummy2%" NEQ "Y" exit /B 0
%pw% -c "(New-Object Net.WebClient).DownloadFile('https://holmgren.org/AlarmBat.zip','%~dps0AlarmBat.zip')"
if exist %~dps0AlarmBat_ReadMe.txt del /F %~dps0AlarmBat_ReadMe.txt
@echo Latest "AlarmBat.zip" v%dummy% downloaded to "%~dps0"
@echo/
set /p dummy2=Install "Alarm.bat" and "AlarmBat_ReadMe.txt" (replace 2 files)? [Y^|n]: 
if /I "%dummy2%" NEQ "N" %pw% -c "$shell=New-Object -ComObject shell.application;$zip=$shell.NameSpace('%~dps0AlarmBat.zip');foreach($item in $zip.items()){if($item.Name -like 'Alarm*'){$shell.Namespace('%~dps0').CopyHere($item,0x14)}}"&@echo Done&exit /B 0

exit /B 0
:ac
if "%2"=="cscript" set cs=%1 //Nologo %TMPO%ALRM.vbs&goto :eof
if "%2"=="reg" set reg=%1 query "HKCU\Control Panel\International" /v&goto :eof
if "%2"=="timeout" set to=%1 /T&goto :eof
set tsk=%1 /FI ^"IMAGENAME eq
set tskv=%1 /V /FI ^"IMAGENAME eq
goto :eof
:bc
if "%2"=="chcp" set cp=%1&goto :eof
if "%2"=="more" set mr=%1 /E /S
goto :eof
:cc
set /a bad+=1
set "dummy2=%dummy2%	%~1&echo/"
goto :eof
:dc
if "%dummy%#"=="#" call :cc "%2.exe"&goto :eof
call :a "%dummy%" dummy
set %1=%dummy% %~3
set dummy=
goto :eof
:ec
if "%TEMP%"=="" if "%TMP%" NEQ "" (set TEMP=%TMP%) else @echo=No "%%TMP%%"^^^|"%%TEMP%%" directory exists for User "%USERNAME%" -- Aborting&set er=5&goto :eof
if not exist "%TEMP%\ALRM\" md "%TEMP%\ALRM\"
call :a "%TEMP%\ALRM\" TMPO
if exist %TMPO%ALRMG.bat del /F %TMPO%ALRMG.bat
call :a "%SystemRoot%\System32\" win
set dummy=&set dummy2=&set bad=0
for %%A in (cmd findstr forfiles powercfg sc schtasks xcopy) do if not exist "%win%%%A.exe" call :cc "%%A.exe"
for %%A in (cscript reg timeout tasklist) do if exist "%win%%%A.exe" (call :ac %win%%%A.exe %%A) else call :cc "%%A.exe"
for %%A in (chcp more) do if exist "%win%%%A.com" (call :bc %win%%%A.com %%A) else call :cc "%%A.com"
for /F "tokens=4 delims=. " %%A in ('ver') do set ver=%%A
for /R "%SystemRoot%\Microsoft.NET\Framework\" %%A in ("*csc.exe") do set dummy=%%A
call :dc csc csc ""
for /R "%win%" %%A in ("*WMIC.exe") do if exist "%%A" set dummy=%%A
call :dc wm WMIC "process where"
for /R "%win%WindowsPowershell\" %%A in ("*powershell.exe") do set dummy=%%A
call :dc pw powershell "-ExecutionPolicy Bypass"
if %bad% GTR 0 @echo/&@echo %~n0 cannot continue^^^! Install or otherwise acquire *%bad%* missing file^(s^):&echo %dummy2%&set er=5&goto :eof
set ret=%~dps0
for %%A in (a0 ae af ab bb) do @for /F %%B in ('%win%forfiles.exe /P "%ret:~0,-1%" /M "%~nx0" /C "%win%cmd.exe /c echo 0x%%A"') do set %%A=%%B
for %%A in (a0 ab ae af bb cp cs csc mr pw reg TMPO to tsk tskv ver win wm) do @echo set %%A=!%%A!>>%TMPO%ALRMG.bat
set dummy=&set bad=0
goto :eof
:fc
@echo Dim txt,cms,fncnt,ret,lenm,spc,cl,voice,wsh,fso,wdth>%w%
@echo txt=WScript.Arguments(0)>>%w%
@echo cms=WScript.Arguments(1)>>%w%
@echo Set wsh=WScript.CreateObject("WScript.Shell")>>%w%
@echo If cms^<^>"S" Then>>%w%
@echo 	If cms="M" Then fncnt=WScript.Arguments(2)>>%w%
@echo 	Set ret=wsh.Exec("%pw% Write-Host $host.UI.RawUI.WindowSize.Width")>>%w%
@echo 	ret.StdIn.Close>>%w%
@echo 	wdth=Trim(ret.StdOut.ReadAll())>>%w%
@echo 	cl=CInt(wdth)*1 >>%w%
@echo 	If cms="C" Then>>%w%
@echo 		fncnt=txt>>%w%
@echo 		txt=CreateObject("htmlfile").ParentWindow.ClipboardData.GetData("text")>>%w%
@echo 	End If>>%w%
@echo End If>>%w%
@echo If InStr(1,Mid(txt,1),"`",1)^>0 Then>>%w%
@echo 	If InStr(1,txt,"`pct`",1)^>0 Then>>%w%
@echo 		txt=Replace(txt,"`pct`","%%",1,-1,1)>>%w%
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
@echo 	txt=Replace(txt,"`amp`","&",1,-1,1)>>%w%
@echo 	txt=Replace(txt,"`bar`","|",1,-1,1)>>%w%
@echo 	txt=Replace(txt,"`gt`",">",1,-1,1)>>%w%
@echo 	txt=Replace(txt,"`lt`","<",1,-1,1)>>%w%
@echo 	txt=Replace(txt,"`xcl`","^!",1,-1,1)>>%w%
@echo 	txt=Replace(txt,"`crt`","^",1,-1,1)>>%w%
@echo 	txt=Replace(txt,"`rp`",")",1,-1,1)>>%w%
@echo 	txt=Replace(txt,"`lp`","(",1,-1,1)>>%w%
@echo 	txt=Replace(txt,"`sl`","/",1,-1,1)>>%w%
@echo 	txt=Replace(txt,"`bq`","`",1,-1,1)>>%w%
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
@echo 		txt=txt ^& vbCrLf ^& vbCrLf ^& Space(spc) ^& "< Hit any key to Dismiss >" ^& vbCrLf ^& vbCrLf>>%w%
@echo 	End If>>%w%
@echo 	Set fso=CreateObject("Scripting.FileSystemObject").OpenTextFile("%TMPO%ALRMC" ^& fncnt ^& ".txt",2,true,0)>>%w%
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
:gc
set k=%TMPO%ALRM.ps1
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
:hc
set k=%TMPO%ALRM2.ps1
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
:ic
set fnb=%TMPO%ALRMakeMouseMove.bat
@echo // 2^>nul^|^|@goto :aaa>%fnb%
@echo /*>>%fnb%
@echo :aaa>>%fnb%
@echo @echo off>>%fnb%
@echo setlocal>>%fnb%
@echo call %%csc%% /nologo /warn:0 /out:"%%TMPO%%ALRM.exe" "%fnb%" ^|^| (exit /B 27)>>%fnb%
@echo endlocal^& exit /B 0 >>%fnb%
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
set er=%ERRORLEVEL%
if exist %fnb% del /F %fnb%
if %er%==27 set ermsg=Error creating "%TMPO%ALRM.exe"
goto :eof
:jc
setlocal disableDelayedExpansion
if not exist %exe% (
	@echo/
	@echo !!!!!		FATAL ERROR: "%exe%" DOES NOT EXIST!	!!!!!
	if /I %exe:~-8%==bell.exe @echo  UnZIP "bell.exe" from AlarmBat.zip and locate it in the same "%~dps0" directory as %~nx0&@echo/&pause&@echo/
)
if /I "%~1x" NEQ "/Hx" if exist "%~dpsn0.txt" goto :kc
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
@echo   Action. DEFAULT: Three alarm Bells {override with /Q}. Supplementary arguments:%hlp%
@echo 1)	/P[START_command_switches ]["][d:\path\]PROGRAM["] [arguments] {implies /QQ; override with /Q ^| /QQQ}%hlp%
@echo      Messages {displayed in Foreground window; hit any key to Dismiss; imply Bells unless /S[poken], override with /Q}:%hlp%
@echo 2)	TYPED text {max chars �8170}%hlp%
@echo 3)	/C {CLIPBOARD text, any length}%hlp%
@echo 4)	/F["][d:\path\]textfile_name["] {FILE text, any length}%hlp%
@echo/%hlp%
@echo/%hlp%
@echo INFO Usage: %~dpsn0.bat /H /T /U /V /X[A[A]] /?^|-h^|--help^|{no_arguments}%hlp%
@echo ====		Five alternatives:%hlp%
@echo 	/H {Print Help ^(THIS^) to file "%~dpsn0.txt"}%hlp%
@echo 	/T {Test bell audibility ^& volume}%hlp%
@echo 	/U {Check for Alarm.bat update}%hlp%
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
@echo		7:00am tomorrow = 3100 ^(700+2400^) {any time today}%hlp%
@echo		7:00am tomorrow =  700 /D+1 {ditto; any time today, simpler}%hlp%
@echo		7:00am in 9 days=22300 {command "set /a 700+9*2400" returns "22300"}%hlp%
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
@echo 	%~n0 810 /R3 /E36 /S It's `pct`TIME:~0,2`pct`:`pct`TIME:~3,2`pct`. Train leaves at 9 {Speak "nag"%hlp%
@echo 	  every 3 minutes; Repeat expires in 36 minutes}%hlp%
@echo 	%~n0 510a /D+3 Taxi to airport%hlp%
@echo 	%~n0 510p /d15-6 Conference with Lawyer {15th of June}%hlp%
@echo 	%~n0 +0 /S /F"C:\Texts\Moby Dick.txt" {Speak a text file.}%hlp%
@echo   START a Program instead of sounding alarm ^(/P switch^):%hlp%
@echo 	%~n0 +60 /P"Do Something.bat"%hlp%
@echo 	%~n0 900pm /Phttps://www.msnbc.com/live%hlp%
@echo 	%~n0 +180 /Q /Pcmd.exe /k @echo ^^%%DATE^^%% ^^%%TIME^^%% %hlp%
@echo 	%~n0 7:15a /D+1 /R1440 /PFamous_for_Nothing-DanielleMiraglia.mp4 {requires an external player%hlp%
@echo 	  ASSOCiated with .MP4, and a sound file residing in the %%PATH%% ^(cf. ASSOC and FTYPE commands^)}%hlp%
@echo   Fully-qualified /P{rogram} commands, with optional START arguments:%hlp%
@echo 	%~n0 645a /w /p/MAX F:\VLC\vlc.exe -f --play-and-exit "J:\Video\Glenn_Gould\BWV 1080 Contrapunctus XIV Da Capo I.mp4"%hlp%
@echo 	%~n0 +0 /P/MIN %pw% -c "Add-Type -AssemblyName System.Speech;$words=(Get-Clipboard);$speak=New-Object System.Speech.Synthesis.SpeechSynthesizer;$speak.SelectVoice('Microsoft Zira Desktop');$speak.Speak($words)"%hlp%
@echo 	%~n0 +0 /S /C {ditto: Speak Clipboard content, but a /C shortcut instead of a fully-described /Program as above}%hlp%
@echo 	%~n0 1200 /R60 /E540 /P/MIN %pw% -c (New-Object Media.SoundPlayer "%~dps0Auxiliaries\BigBen.wav").PlaySync() {Chimes hourly}%hlp%
@echo 		Each morning for 5 days, a child instance of %~n0 announces the Time every minute for 5 minutes, starting at 7:30am:%hlp%
@echo 	%~n0 729 /R1440 /E5760 /P/MIN cmd.exe /c %~nx0 +1 /R1 /E5 /P/MIN %~dps0Auxiliaries\TimeOfDay.bat%hlp%
@echo/%hlp%
@echo Cancel Alarm^|Wake/Repeat:  %~nx0 /X[A[A]] {/X selects one alarm among several; a single%hlp%
@echo	  pending Alarm is canceled automatically/hands-off ^| /XA or "All" cancels all pending%hlp%
@echo	  alarms #0-25 ^| /XAA cancels all pending alarms #0-1000.%hlp%
@echo	  Terminate PowerShell manually to kill e.g. Speech.%hlp%
@echo/%hlp%
@echo 	Notes:%hlp%
@echo Configure User Variables on lines 4-27 of "%~dpsn0.bat"%hlp%
@echo External file "%~dps0bell.exe" ^(bundled herewith^) is used by default instead of cmd.exe. Bell.exe is Cmd.exe%hlp%
@echo   with a bell icon, to distinguish Alarms from ordinary CMD sessions in the Taskbar. For a "pure" standalone%hlp%
@echo   BATch with no external dependencies, replace bell.exe with cmd.exe ^(erase "REM " on line 7 of %~nx0^).%hlp%
@echo Message Content: Single-byte characters ^"^|^&^<^> are DISALLOWED. ^"^|^&^<^> may be displayed using%hlp%
@echo   substitute strings, most commonly ^`q^` ^(with backquotes ^`^) to display quotes.%hlp%
@echo   See "%~dps0AlarmBat_ReadMe.txt" for the complete substitution list.%hlp%
@echo Default Alarm Sound: In recent Windows versions, the .WAVfile equivalent of DOS Ascii-07^|Ctrl-G "bell" is%hlp%
@echo   specified ^(and may be changed^) in MMSYS.CPL -^> Sounds -^> "Critical Stop".%hlp%
@echo If at alarm time Sound is Muted or below %Volume%^%% ^(and no /Q{uiet} command^), %~n0 UnMutes the system and/or%hlp%
@echo   raises the sound level to %Volume%^%%, then on exit ^(*unless /S{poken}*^) restores original Mute^|Volume%hlp%
@echo   settings. To disable this function, change the "UnMute" variable from "On" to "Off" ^(line 10%hlp%
@echo   of %~nx0^). Change the threshold Volume level from %Volume%^%% to another value on line 14.%hlp%
@echo If your ^(uncommon^) Windows system disallows "short" ^(8.3^) filenames, locate %~nx0 in a directory%hlp%
@echo   tree with NO spaces! Find out: execute "TestForShortDirectoryNames.bat" ^(bundled herewith^).%hlp%
@echo Do not locate "%~nx0" and "bell.exe" in a Windows-protected directory ^(e.g. "%win%"^).%hlp%
@echo All files in the %%TEMP%%\ALRM\ directory are RESERVED.%hlp%
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
@echo /R{epeat}: adjust the CPU-dependent "Delay" variable as necessary ^(see comments at line 23 of %~nx0^).%hlp%
@echo Task Scheduler is a temperamental program. See further comments in "%~dps0AlarmBat_ReadMe.txt"%hlp%
@echo/%hlp%
@echo				Robert Holmgren  https://github.com/Rajah01/Alarm.bat/releases/ %hlp%
if /I "%~1x"=="/Hx" @%cp%&exit /B 2
:kc
@cls
%mr% %~dpsn0.txt
@%cp%&exit /B 1
