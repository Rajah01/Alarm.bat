
	Alarm.bat v20210716	Notification program for the Windows command line 
 
NOTIFY Usage: F:\Putty\Alarm.bat AlarmTime [Switches] [Action] (in order) 
======  Syntax: F:\Putty\Alarm[.bat] HH[:]MM[A|P[M]] | +m ...			Alarm_Time 
	... [/D[d]d[-[m]m[-yy]] | /D+n] [/Q[Q[Q]]] [/Rm [/Em]] [/S] [/W ] ...	Switches 
	... [Message] | [/C{lipboard}] | [/F{ile}] | [/P{rogram} [arguments]]	Action 
 
  AlarmTime (REQUIRED; first argument). Two forms: 
	[[[H]H[:]]M]M {24-hour time|12-hour time with A|P[M] suffix; may omit leading zeroes, e.g. Midnight: "0000"="0"} 
	+m {precise minutes from NOW, e.g. "+30"; not valid with /D switch} 
 
  Switches (optional; relaxed order): 
	/D {HHMM=trigger time on alarm day; implies /W}. Two forms: 
		/Ddd-mm-yy {date of alarm, in [d]d[-[m]m[-yy]] form; d is minimally required} 
		/D+n {n=number of days in future until alarm, e.g. /D+2} 
	/Q[Q[Q]] {/Q Quiet, Mute Audio+Bells; /QQ UnMute Audio; /QQQ UnMute Audio+Bells} 
	/Rm {Repeat alarm every m minutes (minimum=1); initial instance occurs at HHMM; implies /W}. Repeats until: 
		/Em {m=Expiration in minutes after HHMM (explicit duration)}; or 
		{manual cancellation with "Alarm /X" (indefinite duration)} 
	/S {Speak (instead of display) TYPED | CLIPBOARD | FILE text; implies /QQ} 
	/W {Wake computer from future Sleep | Hibernation, and persist through Restarts} 
 
  Action. DEFAULT: Three alarm Bells {override with /Q}. Supplementary arguments: 
1)	/P[START command switches ]["][d:\path\]PROGRAM["] [arguments] {implies /QQ; override with /Q | /QQQ} 
     Messages {displayed in Foreground window; hit any key to Dismiss; imply Bells unless /S[poken], override with /Q}: 
2)	TYPED text {max chars ñ8170} 
3)	/C {CLIPBOARD text, any length} 
4)	/F["][d:\path\]textfile_name["] {FILE text, any length} 
 
 
INFO Usage: F:\Putty\Alarm.bat /H /T /U /V /X[A[A]] /?|-h|--help|{no_arguments} 
====		Five alternatives: 
	/H {Print Help (THIS) to file "F:\Putty\Alarm.txt"} 
	/T {Test bell audibility & volume} 
	/U {Check for Alarm.bat update} 
	/V {View pending Alarms|/W{akes}|/R{epeats} by number} 
	/X {Cancel one Alarm|Wake|Repeat by number, or type "ALL" when prompted} 
		/XA	{Cancel Alarms 0-25} 
		/XAA	{Cancel Alarms 0-1000; Reset (wipe) system} 
	/?|-h|--help|no_arguments {Display THIS} 
 
Time Declaration: 0050 :50 50a 1250AM 12:50a... 0150 150 1:50 1:50am... 1350 13:50 150p 1:50PM... +90... 
	  {For each future day, add 2400 to HHMM time: "time+(days*2400)"} 	
	7:00am today    =  700 {if time today earlier than 7:00am} 
	7:00am tomorrow =  700 {if time today later than 7:00am}, *OR* 
	7:00am tomorrow = 3100 (700+2400) {any time today}, *OR* 
	7:00am tomorrow =  700 /D+1 {any time today, simpler} 
	7:00am in 9 days=22300 {command "set /a 700+9*2400" returns "22300"}, *OR* 
	7:00am in 9 days= 7:00a /D+9 {simpler} 
	  N.B.: "7am" = [000]7 = 12:07am, not 0700|7:00am!  
 
Examples: 
	F:\Putty\Alarm.bat 530p {TIME is the only required argument; default alarm is 3 audible bells} 
	Alarm.bat 1730 Call home 
	Alarm 300pm /Q Baby still napping? 
	Alarm 5515 /W Wake up - big day ahead {7:15am day after tomorrow (715+2400*2)} 
	Alarm 715a /D+2 Wake up - big day ahead {ditto} 
	Alarm +1 /R1 {bell nag starts in one minute, and repeats every minute} 
	Alarm 715 /R1440 Daily reminder to wake {at 7:15a every 24 hours=1440 minutes} 
	Alarm 715 /R1440 /Pcmd.exe /c F:\Putty\Alarm.bat +1 /R1 /S Get going`xcl` {at 7:15a every 
	  morning, /S{peaks} reminder every minute until terminated with "Alarm /X"} 
	Alarm 810 /R3 /E36 /S It's `pct`TIME:~0,2`pct`:`pct`TIME:~3,2`pct`. Train leaves at 9 {Speak "nag" 
	  every 3 minutes; Repeat expires in 36 minutes} 
	Alarm 510a /D+3 Taxi to airport 
	Alarm 510p /d15-6 Conference with Lawyer {15th of June} 
	Alarm +0 /S /F"C:\Texts\Moby Dick.txt" {Speak a text file.} 
  START a Program instead of sounding alarm (/P switch): 
	Alarm +60 /P"Do Something.bat" 
	Alarm 900pm /Phttps://www.msnbc.com/live 
	Alarm +180 /Q /Pcmd.exe /k @echo ^%DATE^% ^%TIME^%  
	Alarm 7:15a /D+1 /R1440 /PFamous_for_Nothing-DanielleMiraglia.mp4 {requires an external player 
	  ASSOCiated with .MP4, and a sound file residing in the %PATH% (cf. ASSOC and FTYPE commands)} 
  Fully-qualified /P{rogram} commands, with optional START arguments: 
	Alarm 645a /w /p/MAX F:\VLC\vlc.exe -f --play-and-exit "J:\Video\Glenn_Gould\BWV 1080 Contrapunctus XIV Da Capo I.mp4" 
	Alarm +0 /P/MIN C:\Windows\System32\WindowsPowerShell\v1.0\powershell.exe -ExecutionPolicy Bypass -c "Add-Type -AssemblyName System.Speech;$words=(Get-Clipboard);$speak=New-Object System.Speech.Synthesis.SpeechSynthesizer;$speak.SelectVoice('Microsoft Zira Desktop');$speak.Speak($words)" 
	Alarm +0 /S /C {ditto: Speak Clipboard content, but a /C shortcut instead of a fully-described /Program as above} 
	Alarm 1200 /R60 /E540 /P/MIN C:\Windows\System32\WindowsPowerShell\v1.0\powershell.exe -ExecutionPolicy Bypass -c (New-Object Media.SoundPlayer "F:\Putty\Auxiliaries\BigBen.wav").PlaySync() {Chimes hourly} 
		Each morning for 5 days, a child instance of Alarm announces the Time every minute for 5 minutes, starting at 7:30am: 
	Alarm 729 /R1440 /E5760 /P/MIN cmd.exe /c Alarm.bat +1 /R1 /E5 /P/MIN F:\Putty\Auxiliaries\TimeOfDay.bat 
 
Cancel Alarm|Wake/Repeat:  Alarm.bat /X[A[A]] {/X selects one alarm among several | /XA or "All" cancels all pending alarms 
  #0-25 | /XAA cancels all pending alarms #0-1000 | a single pending Alarm is canceled automatically/hands-off (=/XA}. 
  Terminate PowerShell manually to kill Speech. 
 
	Notes: 
Configure User Variables on lines 4-27 of "F:\Putty\Alarm.bat" 
Message Content: Single-byte characters "|&<>«» are DISALLOWED. "|&<> may be printed using substitute strings, most 
  commonly `quo` (with backquotes `) to print quotes. For a complete substitution list, see "F:\Putty\AlarmBat_ReadMe.txt" 
Default Alarm Sound: In recent Windows versions, the equivalent .WAVfile for DOS Ascii-07|Ctrl-G "bell" is specified 
  in MMSYS.CPL -> Sounds -> "Critical Stop" 
External file "F:\Putty\bell.exe" (bundled herewith) is used by default instead of cmd.exe. Bell.exe is Cmd.exe 
  with a bell icon, to distinguish Alarms from ordinary CMD sessions in the Taskbar. For a "pure" standalone 
  BATch with no external dependencies, replace bell.exe with cmd.exe (erase "REM " on line 7 of Alarm.bat). 
If at alarm time Sound is Muted or below 80% (and no /Q{uiet} command), Alarm UnMutes the system and/or 
  raises the sound level to 80%, then on exit (*unless /S{poken}*) restores original Mute|Volume 
  settings. To disable this function, change the "UnMute" variable from "On" to "Off" (line 14 
  of Alarm.bat). Change the threshold Volume level from 80% to another value on line 18. 
If your (uncommon) Windows system disallows "short" (8.3) filenames, locate Alarm.bat in a directory 
  tree with NO spaces! Find out: execute "TestForShortDirectoryNames.bat" (bundled herewith). 
Do not locate "Alarm.bat" and "bell.exe" in a Windows-protected directory (e.g. "C:\Windows\System32\"). 
Filenames "ALRM*.bat|exe|ps1|txt|vbs|xml" in the %TEMP%\ALRM directory are RESERVED. 
 
	Wake/Repeat: 
Enables Task Scheduler service "Schedule" (if not running). 
Sets "Control Panel > Power Options > Change advanced power settings > Sleep > Allow wake timers" to 
  "Enable" for *both* AC and BATTERY power. 
Executes as a Scheduled Task in the Local User account:  you MUST be signed in! 
/R{epeat} command examples: Every 30 mins=/R30 | day=/R1440 | week=/R10080 | 28+ days {"Monthly"}=/R40320 {max} 
  Calculate repeat interval in minutes: e.g. "set /a 60*6" returns 6 hours; "set /a 60*24*28" returns 28 days 
  For long intervals, click a Bell icon in the Taskbar and hit any key, to remove a persistent icon without 
  removing the Task (verify with "Alarm /V"). "Alarm /X" destroys both the icon window and the Task. 
/R{epeat}: adjust the CPU-dependent "Delay" variable as necessary (see comments at line 9 of Alarm.bat). 
Task Scheduler is a temperamental program. See further comments in "F:\Putty\AlarmBat_ReadMe.txt" 
 
 ------------------------

	Alarm.bat is freeware and open source. No warranties are expressed or implied.

Command "Alarm.bat" without arguments for a command summary and other information.

Issue an unlimited number of Alarm commands; each Alarm is uniquely numbered, starting
	at 0 and generally incrementing in the order issued.
NOTE that two alarms scheduled for exactly the same time may collide, and one may fail.

Alarm.bat commands fall into 3 categories:
	Alarm Time (required; first argument)
	Switches (optional; relaxed order)
	Action (optional; last argument)
	  The Action (e.g. a text message, a /P{rogram} command) should not contain a "/" slash
	  followed by certain Switch-letters ("DPQRSW")! It may be misinterpreted.

Alarm.bat has been tested under Windows 7 Ultimate | Professional and Windows 10 Home | Pro ONLY,
	from an elevated (Administrator) command prompt, with UAC disabled and a minimal
	Firewall. Your mileage may vary.
Bell.exe is a copy of cmd.exe from Windows XP SP3 (32-bit Version 6.2.9200; runs under 64-bit),
	modified to display a bell icon. Earlier versions of cmd.exe (tested: Win95|2000) are unreliable,
	while later versions (Win7|10) are not downwardly compatible with earlier Windows versions.

------------------------

	REQUISITES:
Your computer MUST know the correct local time and time zone. It should be synchronizing with an
	external time server such as 0.pool.ntp.org or time.nist.gov. See the Date and Time settings.
/W{akes} and /R{epeats} execute as Scheduled Tasks in the current user account: you MUST be signed in!
The Windows %TEMP% (or %TMP%) directory must exist for the current user account. In the (highly unusual!)
	circumstance that it does not exist, or is not identified by variables %TEMP% | %TMP%, Alarm.bat aborts.
If your (uncommon) Windows system disallows "short" (8.3) filenames, locate "Alarm.bat" in a directory
	tree with NO spaces! Find out: execute "TestForShortDirectoryNames.bat" (bundled herewith).
Do not locate "Alarm.bat" and "bell.exe" in a Windows-protected directory (e.g. "System32").
Filenames "ALRM*.bat|exe|ps1|txt|vbs|xml" in the %TEMP%\ALRM directory are RESERVED.
Alarm assumes the existence of system files chcp.com, cmd.exe, csc.exe, cscript.exe, findstr.exe,
	more.com, powercfg.exe, powershell.exe, reg.exe, sc.exe, schtasks.exe, tasklist.exe, timeout.exe, WMIC.exe,
	and xcopy.exe. If any of these built-in executables are absent in your system, Alarm will abort.
	Alarm expects all files to exist in the "%SystemRoot%\System32\" directory (usually "C:\Windows\System32\") EXCEPT:
		csc.exe, which is part of the Windows .NET Framework (install NET!)
		powershell.exe, usually in a subdirectory of "%SystemRoot%\System32\WindowsPowerShell\"
		WMIC.exe, usually in "%SystemRoot%\System32\wbem\"

------------------------

Test whether Alarm's "Wake" (/W) function works correctly on your computer.
	Command: (include the ^ carets)
		Alarm.bat +1 /W /Pcmd.exe /k echo ^%DATE^% ^%TIME^%
	then Hibernate:
		shutdown.exe /H
	or Sleep: (https://www.nirsoft.net/utils/nircmd[-x64].zip)
		nircmdc.exe standby
The computer should Wake in 60 seconds and display precise date/time in a new window.

------------------------

There is NO ERROR CHECKING for /P{rogram} commands (existence of files, validity of commands, etc.)
/P{rogram} is an open-ended facility by design, and you are on your own.

/P{rogram} commands may be tested in the present moment with "Alarm.bat +0 [/Q|/S] /P..."
If an Alarm command works in the present (+0), it will work in the future as an Alarm, Wake, or Repeat.

If Alarm crashes due to faulty commands or untrapped errors, issue:
  Alarm.bat /XAA
to clean the first 1001 Scheduled Tasks created by Alarm (including orphans), and remove all Alarm
programming, for a fresh start.

N.B.: If Alarm detects files in the %TEMP%\ALRM folder that pertain to an earlier version of Alarm, it will
autonomously wipe the Alarm system (clean it) before executing any command.

------------------------

Differences between Alarms and Wakes|Repeats
-----------------------------
  Alarms may be canceled by issuing Alarm /X (or by deleting the bell icon in the Taskbar). In contrast, Wakes
	execute at the scheduled time regardless of whether a bell icon exists. Unlike regular Alarms, which require
	that the computer be awake and running, Wakes and Repeats will waken a computer from Screensaver, Sleep, and
	Hibernation states. Wakes and Repeats survive Shutdowns and Restarts -- alarms occur as scheduled if the
	computer is running, although bell icons in the Taskbar do not survive Shutdown|Restart. Wakes and Repeats
	will NOT start a computer that is in a Shutdown state at alarm time (use an external facility, e.g. a DD-WRT
	router with Wake-On-LAN programming, another computer on the LAN or WAN with WOL capability, TeamViewer, etc.).

Further Comments about Repeat (and Wake)
-----------------------------
  Repeats are a reiterative form of Wake.
  Repeats have an optional /E{xpiration}, stated as the total duration of the repeat in minutes
  The Task Scheduler has many quirks. For example, a repeat interval greater than 9999 minutes must be
	evenly divisible by 60 (thus, "Hourly"). Alarm manages this inexplicable requirement by raising an
	uneven interval over 9999 to the next-higher hourly value.
  Relative to the Task Scheduler, Alarm is simple. If you request monthly notification, Alarm notifies
	EVERY month. If you want notification in January, April, July, and October (quarterly), or the
	1st and 15th of each month, or every Friday in the third week ... then use TASKSCHD.MSC
  Bearing Alarm's *relative* simplicity in mind, for:
	Daily scheduling, use a Repeat interval of 1440 minutes (/R1440)
	Weekly, use a Repeat interval of 10080 (/R10080) and schedule the initial instance for the DAY of
		the week and time of day that you want Alarm to fire: if every Monday, schedule the initial instance
		for next Monday
	Monthly, similar to Weekly: Repeat interval = /R40320, but schedule the initial instance for the DATE
		within each month that you want Alarm to trigger: e.g. schedule the initial instance for the 1st
		of next month; for the last day of each month, schedule the initial instance for the 28th
		or higher
	Example: Alarm 9:00am /D15-6-21 /R40320 It's the 15th -- Payday -- and banks are OPEN
  Recursive Repeats are implemented using the /P{rogram} command to launch secondary instance(s) of Alarm.
	The following example starts a Daily repeat next Monday (the 20th of current month), which in turn launches a
	/S{poken} Repeat every 2 minutes for a duration of 10 minutes:
	Example: Alarm 6:59am /D20 /R1440 /Pcmd.exe /c Alarm.bat +1 /R2 /E10 /S Get out of bed
	N.B.: Because Repeats must be scheduled in the FUTURE, the Daily starts at 6:59, and the Spoken starts 1 minute later.
	Note too that a 10 minute duration (/E10) at 2-minute intervals (/R2) will yield 6 (not 5) alarms, at minutes 0-2-4-6-8-10.
	Approximately 30 seconds after Expiration, any lingering Taskbar icons will be removed, but the last-issued
		Text message (if any) will remain until manually Dismissed.
	Repeats with no /Expiry are canceled manually, using Alarm /X. Cancel only the Nag (with the Message!), not the Daily.
  Modify imperfect or inadequate Wake or Repeat commands with TASKSCHD.MSC. For example, you have three options to
	create a Repeat on weekdays only:
	1) create 5 different WEEKLY Repeats, starting Monday through Friday
	2) create one WEEKLY Repeat on Mondays, with two nested CMD /C instances of Alarm (/P switches within /P switches).
		This Example starts on Monday the 22nd at 7:28am and thereafter runs Weekly; at 7:29 it launches an each-morning Alarm for 5 days,
		which in turn launches an Alarm that nags every minute for 5 minutes, starting at 7:30. CMD's /C switch ensures
		that windows close when each iteration of Alarm exits:
		  Alarm 728am /D22 /R10080 /P/MIN cmd.exe /c Alarm.bat +1 /R1440 /E5760 /P/MIN cmd.exe /c Alarm.bat +1 /R1 /E5 /S HEY YOU. Get out of bed.
	3) create one WEEKLY Repeat starting Monday, then go to TASKSCHD.MSC ==> Task Scheduler Library ==> Refresh ==> double-click ALRMW{#}
		==> Triggers ==> Edit ==> checkmark Monday through Friday ==> confirm with OK ==> confirm OK.

 ------------------------

High-order single-byte characters (128-255):
Almost all US-ASCII (CP437) accented alphabetics in range 128-159, and Windows-ANSI characters in range 160-255, display correctly in Messages.
	Select the ANSI codepage for your locale in User Configuration, line 21 (default=1252). YMMV -- test individual characters to ascertain
	that they print.

 ------------------------

Substitution strings may be used to print (and, if sensible, speak) messages containing control characters
	which have special meaning to Windows/DOS, or to the Batch processor, in contexts particular to each character.
	Many control characters cannot be directly manipulated by BATch files. Mileage WILL vary; the only way to know
	for sure whether you may use a particular character directly in a given context is to test it (clean up
	failure by issuing "Alarm.bat /X[A]" and/or restarting the CMD session if the environment is corrupted).
	Note that Alarm temporarily changes the CodePage during execution to CP437, then restores your original CP
	on exit. A crashed Alarm session could leave you with the wrong CodePage, so a cmd restart is advised.
  In contrast, substitution strings are reliable alternatives that always work. Note the systematic
	use of backquote "`". Full list (the "hottest" characters are asterisked; they almost always
	require substitution):
		`quo`		=	"	*
		`amp`		=	&	*
		`xcl`		=	!
		`bar`		=	|	*
		`lt`		=	<	*
		`gt`		=	 >	*
		`lp`		=	(
		`rp`		=	 )
		`crt`		=	^
		`pct`		=	% (assumed to bracket an environmental or user %VARIABLE% {e.g. `pct`VARIABLE`pct`},
						and converted at alarm time to the value it represents)
		`pct``pct`	=	% (as string literal)

	Example:
	-------
		An !!INCORRECT!! /S{poken} source command:
alarm.bat +1 /S /R5 /E30 The time is %TIME:~0,2% hours, %TIME:~3,2% minutes, and %TIME:~6,2% seconds
		The above command executes, but it hard-codes the TIME at the moment of issue, and repeats that static time at each of seven alarms.
		SUBSTITUTED [CORRECT]:
alarm.bat +1 /S /R5 /E30 The time is `pct`TIME:~0,2`pct` hours, `pct`TIME:~3,2`pct` minutes, and `pct`TIME:~6,2`pct` seconds
		This command reports the CORRECT current time at each of seven alarms.

	Try it!  Alarm.bat +0 The time is `pct`TIME:~0,2`pct` hours, `pct`TIME:~3,2`pct` minutes, and `pct`TIME:~6,2`pct` seconds

------------------------

The Auxiliaries directory contains optional programs that operate in conjunction with Alarm and offer specific services.
ADJUST the "d:\path\" to the programs!

	CountDwn: verbal countdown to (and beyond) a specific time (e.g. start at 9:00am, for total duration of 20 minutes)
		Example: Alarm.bat +1 /R1 /E20 /P/MIN d:\path\CountDwn.bat 0900
	TimeOfDay {"TalkTock"}: e.g. starting at 4:30am, announce the current Time every 15 minutes, until terminated (Alarm /X)
		Example: Alarm.bat 4:30a /R15 /P/MIN d:\path\TimeOfDay.bat
	BigBen.wav: e.g. chime hourly from 12 Noon until 9:00pm
		Alarm.bat 1200 /R60 /E540 /P/MIN powershell.exe -c (New-Object Media.SoundPlayer "d:\path\BigBen.wav").PlaySync()

------------------------

Messages (whether typed, extracted from the Clipboard, or from a file) are filtered through MORE.COM, with the following extended features enabled:
	Q	Quit
	<space>	Display next page
	<Enter>	Display next line
	P n	Display next n lines
	S n	Skip next n lines
	=	Show line number
Multiple blank lines are reduced to a single line.

------------------------

Speak or Display PDF Text: Convert PDF to text first!
Try a port of the Unix public-domain "pdftotext" executable, e.g. Xpdf (https://www.xpdfreader.com/download.html).
	Tip: Use the "-layout" switch.
N.B.: This strategy may or may not work, depending on the integrity of the underlying PDF text.

------------------------

List Text-to-Speech (TTS) Voices installed on your computer:
	powershell.exe -ExecutionPolicy Bypass -Command "Add-Type -AssemblyName System.Speech;$speak=New-Object System.Speech.Synthesis.SpeechSynthesizer;$speak.GetInstalledVoices()|Select-Object -ExpandProperty VoiceInfo|Select-Object -Property Name,Gender,Description"

------------------------

CAUTION: Edit Alarm.bat in an environment that uses 8-bit (single byte) character encodings ONLY!
	Do NOT edit with a word processor! Notepad may be used to adjust the User Configuration, ONLY!
	Alarm.bat was written in CodePage 437 (a.k.a. "US-ASCII", "OEM-US").
	Low-order characters 28-30 are used for certain functions, and may not display correctly in some editors!
	Multiple-byte editors using UTF (Unicode) will corrupt the file. Caveat emptor.
	Notepad++ (https://notepad-plus-plus.org/) is recommended (set Encoding -> Character sets -> Western European -> OEM-US).

------------------------

	Author: Robert Holmgren
	Download:  https://holmgren.org/AlarmBat.zip

  	Credits:
	-------
	Vasil Arnaudov (https://github.com/npocmaka/batch.scripts/blob/master/hybrids/.net/c/mouse.bat and http://ss64.org/viewtopic.php?id=1687)
	Alexandre Jasmin and Anchmerama (https://stackoverflow.com/questions/255419/how-can-i-mute-unmute-my-sound-from-powershell)
	Ritchie Lawrence (https://github.com/ritchielawrence/batchfunctionlibrary/tree/master/Date%20and%20Time%20Functions)
