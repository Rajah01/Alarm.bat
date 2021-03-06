
	  AlarmBat.zip 	 Notification program for the Windows command line
	Alarm.bat is freeware and open source. No warranties are expressed or implied.

Command "Alarm.bat" without arguments for a command summary and other information.

Issue an unlimited number of Alarm commands; each Alarm is uniquely numbered, starting
	at 0 and generally incrementing in the order issued.
NOTE that two alarms scheduled for exactly the same time may collide, and one may fail.

Alarm.bat commands fall into 3 categories:
	Alarm Time (required; first argument)
	Switches (optional; relaxed order)
	Action (optional; last argument)
	  The Action, if a text message, should not contain a literal "/" slash
	  followed by certain Switch-letters ("DPQRSW")! It may be misinterpreted.
	  (Use the substitute string `sl` instead.)

Alarm.bat has been tested under Windows 7 Ultimate | Professional and Windows 10 Home | Pro ONLY,
	from an elevated (Administrator) command prompt, with UAC disabled and a minimal
	Firewall. Your mileage may vary.
Bell.exe is a copy of cmd.exe from Windows XP SP3 (32-bit Version 6.2.9200; runs under 64-bit),
	modified to display a bell icon. Earlier versions of cmd.exe (tested: Win95|2000) are unreliable,
	while later versions (Win7|10) are not downwardly compatible with prior Windows versions.

------------------------

	REQUISITES:
Your computer MUST know the correct local time and time zone. It should be synchronizing with an
	external time server such as 0.pool.ntp.org or time.nist.gov. See the Date and Time settings.
/W{akes} and /R{epeats} execute as Scheduled Tasks in the current user account: you MUST be signed in!
If your (uncommon) Windows system disallows "short" (8.3) filenames, locate "Alarm.bat" in a directory
	tree with NO spaces! Find out: execute "TestForShortDirectoryNames.bat" (bundled herewith).
Do not locate "Alarm.bat" and "bell.exe" in a Windows-protected directory (e.g. "System32").
All files in the {Alarm.bat directory}\ALRM\ subdirectory are RESERVED.
Alarm assumes the existence of system files chcp.com, cmd.exe, csc.exe, cscript.exe, findstr.exe, forfiles.exe,
	more.com, powercfg.exe, powershell.exe, reg.exe, sc.exe, schtasks.exe, sort.exe, tasklist.exe, timeout.exe,
	WMIC.exe, and xcopy.exe. If any of these built-in executables are absent in your system, Alarm will abort.
	Alarm expects built-in executables to exist in the "%SystemRoot%\System32\" directory
	(usually "C:\Windows\System32\") EXCEPT:
		csc.exe, which is part of the Windows .NET Framework (install NET!)
		powershell.exe, usually in a subdirectory of "%SystemRoot%\System32\WindowsPowerShell\"
		WMIC.exe, usually in "%SystemRoot%\System32\wbem\"

------------------------

Test whether Alarm's "Wake" (/W) function works correctly on your computer.
NOTE WELL:
If your computer requires a sign-in after sleep or hibernation, it will frustrate the purpose of Wake!
Solution (Win10):
 1) Settings > Accounts > Sign-in options > Require sign-in > Never
 2) Command "netplwiz" and UNcheck "Users must enter a user name and password ..."
If insufficient:
 3) Command "regedit", goto HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows. Click on
 "Personalization" (if Personalization key doesn't exist, right-click and create a new DWORD).
 Create new DWORD "NoLockScreen", value=1
BIOS settings may also inhibit Wake, e.g. Power Management -> Block Sleep | USB Wake Support | Wake on LAN/WLAN | PLL Overvoltage ...

	Command: (include the ^ carets)
		Alarm.bat +1 /W /Pcmd.exe /k echo ^%DATE^% ^%TIME^%
	then Hibernate:
		shutdown.exe /H
	or Sleep: (https://www.nirsoft.net/utils/nircmd[-x64].zip)
		nircmdc.exe standby
The computer should Wake in 60 seconds and display precise date/time in a new window.

------------------------

There is NO ERROR CHECKING for /P{rogram} commands (existence of files, validity of commands, etc.)
There is no filtering or interpretation, e.g. for `v` Variables or other Substitution strings (q.v. further below),
  e.g. instead of `v`DATE`v`, write ^%DATE^%
/P{rogram} is an open-ended facility by design, and you are on your own.

/P{rogram} commands may be tested in the present moment with "Alarm.bat +0 [/Q|/S] /P..."
If an Alarm command works in the present (+0), it will work in the future as an Alarm, Wake, or Repeat.

If Alarm crashes due to faulty commands or untrapped errors, issue:
  Alarm.bat /XAA
to clean the first 1001 Scheduled Tasks created by Alarm (including orphans), and remove all Alarm
programming, for a fresh start.

Each Alarm error generates an explanatory message and a unique %ERRORLEVEL% upon EXIT (established
in the code at "set er=[%ERRORLEVEL%]", returned on CLI as "echo %ERRORLEVEL%"). Note that a /Program
may generate its own %ERRORLEVEL%.

N.B.: If Alarm detects files in the {Alarm.bat directory}\ALRM subfolder that pertain to an earlier
version of Alarm, it will autonomously wipe the Alarm system (clean it) before executing any command.

IMPORTANT: If you ALTER any variable in User Configuration, or change your CodePage or Power Configuration,
you MUST execute "Alarm.bat /B", to rewrite the variable file ("{Alarm dir}\ALRM\ALRG.bat") before next use!

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
Almost all US-ASCII (CP437) accented alphabetics in range 128-159, and Windows-ANSI characters in range 160-255,
	display in Messages, either correctly (if the equivalent representation exists in CP437) or as an unaccented version of
	the character. YMMV -- test individual characters to ascertain that they print.
	Select the ANSI codepage for your locale in User Configuration, line 17 (default=1252).

 ------------------------

Substitution strings may be used to print (or, if sensible, speak) messages containing control characters (listed below)
	that have special meaning to Windows/DOS, or to the Batch processor, in contexts particular to each character.
	Many control characters cannot be directly manipulated by BATch files. Mileage WILL vary; the only way to know
	for sure whether you may use a particular character directly in a given context is to test it (clean up
	failure by issuing "Alarm.bat /X[A]" and/or restarting the CMD session if the environment is corrupted).
	Note that Alarm temporarily changes the CodePage during execution to CP437, then restores your original CP
	on exit. A crashed Alarm session could leave you with the wrong CodePage, so a CMD restart is prudent.
  In contrast, substitution strings are reliable alternatives that always work. Note the systematic
	use of backquote "`". Full list (the "hottest" characters are asterisked; they almost always
	require substitution):
		`q`|`quo`	=	"	*
		`a`|`amp`	=	&	*
		`x`|`xcl`	=	!
		`bar`		=	|	*
		`lt`		=	<	*
		`gt`		=	 >	*
		`lp`		=	(
		`rp`		=	 )
		`sl`		=	/
		`bq`		=	`
		`crt`		=	^
		`v`|`var`	=	% (bracket an environmental or user %VARIABLE% {e.g. `var`USERPROFILE`var`},
						and convert at alarm time to the value it represents)
		`pct`		=	% (as string literal)

	Example:
	-------
			An !!INCORRECT!! /S{poken} source command:
alarm.bat +1 /S /R5 /E30 The time is %TIME:~0,2% hours, %TIME:~3,2% minutes, and %TIME:~6,2% seconds
		The above command executes, but it hard-codes the TIME at the moment of issue, and repeats that static time at
		each of seven alarms. It _does_ suffice if you only execute the command ONCE.
			SUBSTITUTED [CORRECT]:
alarm.bat +1 /S /R5 /E30 The time is `var`TIME:~0,2`var` hours, `var`TIME:~3,2`var` minutes, and `var`TIME:~6,2`var` seconds
		This command reports the CORRECT current time at each of seven alarms.

	Try it!  Alarm.bat +0 The time is `var`TIME:~0,2`var` hours, `var`TIME:~3,2`var` minutes, and `var`TIME:~6,2`var` seconds

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
	QQ	Quit (Q twice)
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

List Text-to-Speech (TTS) Voices installed on your computer (default Voice is listed first):
	powershell.exe -ExecutionPolicy Bypass -Command "Add-Type -AssemblyName System.Speech;$speak=New-Object System.Speech.Synthesis.SpeechSynthesizer;$speak.GetInstalledVoices()|Select-Object -ExpandProperty VoiceInfo|Select-Object -Property Name,Gender,Description"
		*OR*
	Alarm.bat /E

Tip: If you find David, Hazel, or Zira wooden & artificial, try Sean (IE), George (GB), or Heera (IN)

How To:	Add, then Activate, "Foreign" Voices in Windows 10:
--- --
Add Languages: Settings > Time & Language > Language > Add a preferred language
Only add language packs that have an associated TTS (Text-To-Speech) capability.
List installed languages:
	powershell -ExecutionPolicy Bypass -c "(Get-WinUserLanguageList).LocalizedName"
List of languages and TTS-capable voices:
https://support.office.com/en-us/article/how-to-download-text-to-speech-languages-for-windows-10-d5a6b612-b3ae-423f-afa5-4f6caf1ec5d3
  N.B.: ADDITIONAL voices are available with Cortana, e.g. Koyal ["Mobile"] (IN)

Activate Voices: Edit exported Registry files
https://www.ghacks.net/2018/08/11/unlock-all-windows-10-tts-voices-system-wide-to-get-more-of-them/
  A compendium of *some* Windows 10+ TTS REG files is available on the Web:
	http://xywrite.org/xywwweb/Voices.reg.zip
  BACKUP YOUR EXISTING REGISTRY FIRST! No warranties/guarantees! N.B.: WINDOWS 11 NOT YET TESTED!
  Do NOT run a REG file unless the corresponding Language pack is downloaded and installed!
  Do NOT run a REG file for a Voice that is ALREADY INSTALLED, either in regular or "Desktop" versions! Check first with Alarm /E
  ZIPfile contents include Cortana and Mobile voices. Try ONE voice first:
Dutch Frank
English (Australia) James, Catherine, Matilda
English (Canada) Richard, Linda, Eva
English (Great Britain)	George, Hazel, Susan, Sarah
English (India)	Ravi, Heera, Koyal
English (Ireland) Sean
English (United States)	Mark, Eva
French Paul, Hortense, Julie
Indonesian Andika
Italian Cosimo, Elsa
Spanish Pablo, Helena, Laura

Select one activated voice as default:
  Control Panel [control.exe] > Speech Recognition > Text to Speech > Voice selection (and "Apply")

------------------------

CAUTION: Edit Alarm.bat in an environment that uses 8-bit (single byte) character encodings ONLY!
	Do NOT edit with a word processor! Notepad may be used to adjust the User Configuration;
	Notepad++ (https://notepad-plus-plus.org/) is recommended for broader edit.

------------------------

	Author: Robert Holmgren
	Download:  https://github.com/Rajah01/Alarm.bat/releases/

  	Credits:
	-------
	Vasil Arnaudov (https://github.com/npocmaka/batch.scripts/blob/master/hybrids/.net/c/mouse.bat and http://ss64.org/viewtopic.php?id=1687)
	Carl Distefano (http://xywwweb.ammaze.net/dls/TalkTock.zip)
	Alexandre Jasmin and Anchmerama (https://stackoverflow.com/questions/255419/how-can-i-mute-unmute-my-sound-from-powershell)
	Ritchie Lawrence (https://github.com/ritchielawrence/batchfunctionlibrary/tree/master/Date%20and%20Time%20Functions)
	https://docs.microsoft.com/en-us/windows/win32/menurc/wm-syscommand

