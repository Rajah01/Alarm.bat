<!DOCTYPE html>
<html><pre>
 &nbsp; &nbsp; &nbsp; &nbsp;Alarm.bat v20210807 &nbsp; &nbsp; &nbsp; &nbsp;Notification program for the Windows command line

<b>NOTIFY Usage</b>: &nbsp;Alarm.bat AlarmTime [Switches] [Action] (in order)
====== Syntax: Alarm[.bat] HH[:]MM[A|P[M]] | +m ...&nbsp; &nbsp; &nbsp;&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;Alarm_Time
 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; ... [/D[d]d[-[m]m[-yy]] | /D+n] [/Q[Q[Q]]] [/Rm [/Em]] [/S] [/W ] ...&nbsp;&nbsp; &nbsp; &nbsp; &nbsp;Switches
 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; ... [Typed Message] | [/C{lipboard}] | [/F{ile}] | [/P{rogram} [arguments]] &nbsp;Action

 &nbsp;AlarmTime (REQUIRED; first argument). Two forms:
 &nbsp; &nbsp; &nbsp; &nbsp;[[[H]H[:]]M]M {24-hour time|12-hour time with A|P[M] suffix; may omit leading zeroes,
 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;e.g. Midnight: &#34;0000&#34;=&#34;0&#34;}
 &nbsp; &nbsp; &nbsp; &nbsp;+m {precise minutes from NOW, e.g. &#34;+30&#34;; not valid with /D switch}

 &nbsp;Switches (optional; relaxed order):
 &nbsp; &nbsp; &nbsp; &nbsp;/D {HHMM=trigger time on alarm day; implies /W}. Two forms:
 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;/Ddd-mm-yy {date of alarm, in [d]d[-[m]m[-yy]] form; d is minimally required}
 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;/D+n {n=number of days in future until alarm, e.g. /D+2}
 &nbsp; &nbsp; &nbsp; &nbsp;/Q[Q[Q]] {/Q Quiet, Mute Audio+Bells; /QQ UnMute Audio; /QQQ UnMute Audio+Bells}
 &nbsp; &nbsp; &nbsp; &nbsp;/Rm {Repeat alarm every m minutes (minimum=1); initial instance occurs at HHMM; implies /W}.
 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;Repeats until:
 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;/Em {m=Expiration in minutes after HHMM (explicit duration)}; <i><b>or</b></i>
 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;{manual cancellation with &#34;Alarm /X&#34; (indefinite duration)}
 &nbsp; &nbsp; &nbsp; &nbsp;/S {Speak (instead of display) TYPED | CLIPBOARD | FILE text; implies /QQ}
 &nbsp; &nbsp; &nbsp; &nbsp;/W {Wake computer from future Sleep | Hibernation, and persist through Restarts}

 &nbsp;Action. DEFAULT: Three alarm Bells {override with /Q}. Supplementary arguments:
1&#41; &nbsp; &nbsp; &nbsp;/P[START&#95;command&#95;switches ][&#34;][d:\path\]PROGRAM[&#34;] [arguments] {implies /QQ;
 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;override with /Q | /QQQ}
 &nbsp; &nbsp; Messages {displayed in Foreground window; hit any key to Dismiss; imply Bells unless /S[poken],
 &nbsp; &nbsp; override with /Q}:
2&#41; &nbsp; &nbsp; &nbsp;TYPED text {max chars &#177;8170}
3&#41; &nbsp; &nbsp; &nbsp;/C {CLIPBOARD text, any length}
4&#41; &nbsp; &nbsp; &nbsp;/F[&#34;][d:\path\]textfile_name[&#34;] {FILE text, any length}

<b>INFO Usage</b>: Alarm.bat /B /H /T /U /V /X[A[A]] /?|-h|--help|{no_arguments}
==== &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;Seven alternatives:
 &nbsp; &nbsp; &nbsp; &nbsp;/B {(re)Build Alarm system variables}
 &nbsp; &nbsp; &nbsp; &nbsp;/H {Print Help (<b>THIS</b>) to file &#34;.\Alarm.txt&#34;}
 &nbsp; &nbsp; &nbsp; &nbsp;/T {Test bell audibility & volume}
 &nbsp; &nbsp; &nbsp; &nbsp;/U {Check for Alarm.bat update}
 &nbsp; &nbsp; &nbsp; &nbsp;/V {View pending Alarms|/W{akes}|/R{epeats} by number}
 &nbsp; &nbsp; &nbsp; &nbsp;/X {Cancel one Alarm|Wake|Repeat by number, or type &#34;ALL&#34; when prompted}
 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;/XA &nbsp; &nbsp; &nbsp; &nbsp;{Cancel Alarms 0-25}
 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;/XAA &nbsp; &nbsp; &nbsp; {Cancel Alarms 0-1000; Reset (wipe) system}
 &nbsp; &nbsp; &nbsp; &nbsp;/?|-h|--help|no_arguments {Display <b>THIS</b>}

Time Declaration: 0050 :50 50a 1250AM 12:50a &nbsp; 0150 150 1:50 1:50am &nbsp; 1350 13:50 150p 1:50PM &nbsp; +90 &nbsp; 
 &nbsp; &nbsp; &nbsp;{For each future day, add 2400 to HHMM time: &#34;time+(days&#42;2400)&#34;} &nbsp;&nbsp; &nbsp; &nbsp; &nbsp;
 &nbsp; &nbsp;7:00am today &nbsp; &nbsp;= &nbsp;700 {if time today earlier than 7:00am}
 &nbsp; &nbsp;7:00am tomorrow = &nbsp;700 {if time today later than 7:00am}
 &nbsp; &nbsp;7:00am tomorrow = 3100 (700+2400) {<b>ditto</b>; any time today}
 &nbsp; &nbsp;7:00am tomorrow = &nbsp;700 /D+1 {<b>ditto</b>; any time today, simpler}
 &nbsp; &nbsp;7:00am in 9 days=22300 {command &#34;set /a 700+(9&#42;2400)&#34; returns &#34;22300&#34;}
 &nbsp; &nbsp;7:00am in 9 days= 7:00a /D+9 {<b>ditto</b>; simpler}
 &nbsp; &nbsp; &nbsp;N.B.: &#34;7am&#34; = [000]7 = 12:07am, not 0700|7:00am! 

<b>Examples</b>:
 &nbsp; &nbsp;Alarm.bat 530p {TIME is the only required argument; default alarm is 3 audible bells}
 &nbsp; &nbsp;Alarm.bat 1730 Call home
 &nbsp; &nbsp;Alarm 300pm /Q Baby still napping?
 &nbsp; &nbsp;Alarm 5515 /W Wake up - big day ahead {7:15am day after tomorrow (715+(2400&#42;2))}
 &nbsp; &nbsp;Alarm 715a /D+2 Wake up - big day ahead {<b>ditto</b>}
 &nbsp; &nbsp;Alarm +1 /R1 {bell nag starts in one minute, and repeats every minute}
 &nbsp; &nbsp;Alarm 715 /R1440 Daily reminder to wake {at 7:15a every 24 hours=1440 minutes}
 &nbsp; &nbsp;Alarm 715 /R1440 /Pcmd.exe /c Alarm.bat +1 /R1 /S Get going&#96;xcl&#96; {at 7:15a every
 &nbsp; &nbsp; &nbsp;morning, /S{peaks} reminder every minute until terminated with &#34;Alarm /X&#34;}
 &nbsp; &nbsp;Alarm 810 /R3 /E36 /S It's &#96;var&#96;TIME:~0,2&#96;var&#96;:&#96;var&#96;TIME:~3,2&#96;var&#96;. Train leaves at 9 {Speak &#34;nag&#34;
 &nbsp; &nbsp; &nbsp;every 3 minutes; Repeat expires in 36 minutes}
 &nbsp; &nbsp;Alarm 510a /D+3 Taxi to airport
 &nbsp; &nbsp;Alarm 510p /d15-6 Conference with Lawyer {15th of June}
 &nbsp; &nbsp;Alarm +0 /S /F&#34;C:\Texts\Moby Dick.txt&#34; {Speak a text file.}
 &nbsp;START a Program instead of sounding alarm (/P switch):
 &nbsp; &nbsp;Alarm +60 /P&#34;Do Something.bat&#34;
 &nbsp; &nbsp;Alarm 900pm /Phttps://www.msnbc.com/live
 &nbsp; &nbsp;Alarm +180 /Q /Pcmd.exe /k @echo ^%DATE^% ^%TIME^% 
 &nbsp; &nbsp;Alarm 7:15a /D+1 /R1440 /PFamous_for_Nothing-DanielleMiraglia.mp4 {requires an external player
 &nbsp; &nbsp; &nbsp;ASSOCiated with .MP4, and a sound file residing in the %PATH% (cf. ASSOC and FTYPE commands)}
 &nbsp;Fully-qualified /P{rogram} commands, with optional START arguments:
 &nbsp; &nbsp;Alarm 645a /w /p/MAX F:\VLC\vlc.exe -f --play-and-exit &#34;J:\Video\Glenn_Gould\BWV 1080 Contrapunctus XIV Da Capo I.mp4&#34;
 &nbsp; &nbsp;Alarm +0 /P/MIN C:\Windows\System32\WindowsPowerShell\v1.0\powershell.exe -ExecutionPolicy Bypass -c &#34;Add-Type -AssemblyName System.Speech;$words=(Get-Clipboard);$speak=New-Object System.Speech.Synthesis.SpeechSynthesizer;$speak.SelectVoice('Microsoft Zira Desktop');$speak.Speak($words)&#34;
 &nbsp; &nbsp;Alarm +0 /S /C {<b>ditto</b>: Speak Clipboard content, but a /C shortcut instead of
 &nbsp; &nbsp; &nbsp;a fully-described /Program as above}
 &nbsp; &nbsp;Alarm 1200 /R60 /E540 /P/MIN C:\Windows\System32\WindowsPowerShell\v1.0\powershell.exe -ExecutionPolicy Bypass -c (New-Object Media.SoundPlayer &#34;.\Auxiliaries\BigBen.wav&#34;).PlaySync()
 &nbsp; &nbsp; &nbsp;{Chimes hourly}
 &nbsp; &nbsp; &nbsp; &nbsp;Each morning for 5 days, a child instance of Alarm announces the Time every minute for
 &nbsp; &nbsp; &nbsp; &nbsp;5 minutes, starting at 7:30am:
 &nbsp; &nbsp;Alarm 729 /R1440 /E5760 /P/MIN cmd.exe /c Alarm.bat +1 /R1 /E5 /P/MIN .\Auxiliaries\TimeOfDay.bat

Cancel Alarm|Wake/Repeat: &nbsp;Alarm.bat /X[A[A]] {/X selects one alarm among several; a single
 &nbsp;pending Alarm is canceled automatically/hands-off | /XA or &#34;All&#34; cancels all pending
 &nbsp;alarms #0-25 | /XAA cancels all pending alarms #0-1000.
 &nbsp;Terminate PowerShell manually to kill Speech.

 &nbsp; &nbsp; &nbsp; &nbsp;Notes:
Configure User Variables on lines 4-26 of &#34;Alarm.bat&#34;
Reset the Alarm system after changes to Power Config, Locale, or CodePage: &#34;Alarm.bat /B&#34;
External file &#34;bell.exe&#34; (bundled herewith) is used by default instead of cmd.exe. Bell.exe is Cmd.exe
 &nbsp;with a bell icon, to distinguish Alarms from ordinary CMD sessions in the Taskbar. For a &#34;pure&#34;
 &nbsp;standalone BATch with no external dependencies, replace bell.exe with cmd.exe (erase &#34;REM &#34;
 &nbsp;on line 9 of Alarm.bat).
Message Content: Single-byte characters &#34;|&`<> are DISALLOWED. Chars &"|&`%/!^()<> may be displayed
 &nbsp;using backquoted substitute strings, most commonly &#96;q&#96; to display quotes. See &#34;AlarmBat_ReadMe.txt&#34;
 &nbsp;for the substitution string list.
Default Alarm Sound: In recent Windows versions, the .WAVfile equivalent of DOS Ascii-07|Ctrl-G (^G) &#34;bell&#34;
 &nbsp;is specified (and may be changed) in MMSYS.CPL -> Sounds -> &#34;Critical Stop&#34;
If at alarm time Sound is Muted or below 80% (and no /Q{uiet} command), Alarm UnMutes the system and/or
 &nbsp;raises the sound level to 80%, then on exit (&#42;unless /S{poken}&#42;) restores original Mute|Volume
 &nbsp;settings. To disable this function, change the &#34;UnMute&#34; variable from &#34;On&#34; to &#34;Off&#34; (line 12
 &nbsp;of Alarm.bat). Change the threshold Volume level from 80% to another value on line 16.
If your (uncommon) Windows system disallows &#34;short&#34; (8.3) filenames, locate Alarm.bat in a directory
 &nbsp;tree with NO spaces! Find out: execute &#34;TestForShortDirectoryNames.bat&#34; (bundled herewith).
Do not locate &#34;Alarm.bat&#34; and &#34;bell.exe&#34; in a Windows-protected directory
 &nbsp;(e.g. &#34;C:\Windows\System32&#92;&#34;).
Recommended: Situate Alarm.bat in the %PATH%, or append ";D:\PATH\" to the %PATH%, to obviate
  specifying "{D:\PATH\}Alarm[.bat]" in commands. Use Powershell (<b>not SETX</b>) to append:
  powershell -c "[Environment]::SetEnvironmentVariable('Path', $env:Path + ';D:\PATH', 'User')"
All files in the {Alarm.bat directory}\ALRM\ subdirectory are RESERVED.

 &nbsp; &nbsp; &nbsp; &nbsp;Wake/Repeat:
Enables Task Scheduler service &#34;Schedule&#34; (if not running).
Sets &#34;Control Panel > Power Options > Change advanced power settings > Sleep > Allow wake timers&#34; to
 &nbsp;&#34;Enable&#34; for &#42;both&#42; AC and BATTERY power.
Executes as a Scheduled Task in the Local User account: &nbsp;you MUST be signed in!
/R{epeat} command examples: Every 30 mins=/R30 | day=/R1440 | week=/R10080 | 28+ days
 &nbsp;{&#34;Monthly&#34;}=/R40320 {max}
 &nbsp;Calculate repeat interval in minutes: e.g. &#34;set /a 60&#42;6&#34; returns 6 hours; &#34;set /a 60&#42;24&#42;28&#34; returns
 &nbsp;28 days. For long intervals, click a Bell icon in the Taskbar and hit any key, to remove a persistent
 &nbsp;icon without removing the Task (verify with &#34;Alarm /V&#34;). &#34;Alarm /X&#34; destroys both the icon window
 &nbsp;and the Task.
/R{epeat}: adjust the CPU-dependent &#34;Delay&#34; variable as necessary (see comments at line 22 of Alarm.bat).
Task Scheduler is a temperamental program. See further comments below.

 ------------------------

 &nbsp; &nbsp;Alarm.bat is freeware and open source. No warranties are expressed or implied.

Command &#34;Alarm.bat&#34; without arguments for a command summary and other information.

Issue an unlimited number of Alarm commands; each Alarm is uniquely numbered, starting
 &nbsp; &nbsp;at 0 and generally incrementing in the order issued.
NOTE that two alarms scheduled for exactly the same time may collide, and one may fail.

Alarm.bat commands fall into 3 categories:
 &nbsp; &nbsp;Alarm Time (required; first argument)
 &nbsp; &nbsp;Switches (optional; relaxed order)
 &nbsp; &nbsp;Action (optional; last argument)
 &nbsp; &nbsp; &nbsp;The Action, if a Text message, should not contain a literal &#34;/&#34; slash
 &nbsp; &nbsp; &nbsp;followed by certain Switch-letters (&#34;DPQRSW&#34;)! It may be misinterpreted.
 &nbsp; &nbsp; &nbsp;(Use the substitute string &#96;sl&#96; instead. See <b>Substitution strings</b>, below.)

Alarm.bat has been tested under Windows 7 Ultimate | Professional and Windows 10 Home | Pro ONLY,
 &nbsp; &nbsp;from an elevated (Administrator) command prompt, with UAC disabled and a minimal
 &nbsp; &nbsp;Firewall. Your mileage may vary.
Bell.exe is a copy of cmd.exe from Windows XP SP3 (32-bit Version 6.2.9200; runs under 64-bit),
 &nbsp; &nbsp;modified to display a bell icon. Earlier versions of cmd.exe (tested: Win95|2000) are unreliable,
 &nbsp; &nbsp;while later versions (Win7|10) are not downwardly compatible with earlier Windows versions.

------------------------

 &nbsp; &nbsp;REQUISITES:
Your computer MUST know the correct local time and time zone. It should be synchronizing with an
 &nbsp; &nbsp;external time server such as 0.pool.ntp.org or time.nist.gov. See the Date and Time settings.
/W{akes} and /R{epeats} execute as Scheduled Tasks in the current user account: you MUST be signed in!
If your (uncommon) Windows system disallows &#34;short&#34; (8.3) filenames, locate &#34;Alarm.bat&#34; in a directory
 &nbsp; &nbsp;tree with NO spaces! Find out: execute &#34;TestForShortDirectoryNames.bat&#34; (bundled herewith).
Do not locate &#34;Alarm.bat&#34; and &#34;bell.exe&#34; in a Windows-protected directory (e.g. &#34;System32&#34;).
All files in the {Alarm.bat directory}\ALRM\ subdirectory are RESERVED.
Alarm assumes the existence of system files <b>chcp.com, cmd.exe, csc.exe, cscript.exe, findstr.exe,
 &nbsp; &nbsp;forfiles.exe, more.com, powercfg.exe, powershell.exe, reg.exe, sc.exe, schtasks.exe, tasklist.exe,
 &nbsp; &nbsp;timeout.exe, WMIC.exe, and xcopy.exe</b>. If any of these built-in executables are absent in your
 &nbsp; &nbsp;system, Alarm will abort. Alarm expects built-in executables to exist in the
 &nbsp; &nbsp;&#34;%SystemRoot%\System32&#92;&#34; directory (usually &#34;C:\Windows\System32&#92;&#34;) EXCEPT:
 &nbsp; &nbsp; &nbsp; &nbsp;csc.exe, which is part of the Windows .NET Framework (install NET!)
 &nbsp; &nbsp; &nbsp; &nbsp;powershell.exe, usually in a subdirectory of &#34;%SystemRoot%\System32\WindowsPowerShell&#92;&#34;
 &nbsp; &nbsp; &nbsp; &nbsp;WMIC.exe, usually in &#34;%SystemRoot%\System32\wbem&#92;&#34;

------------------------

Test whether Alarm's &#34;Wake&#34; (/W) function works correctly on your computer.
 &nbsp; &nbsp;<b>Command</b>: (include the ^ carets)
 &nbsp; &nbsp; &nbsp; &nbsp;Alarm.bat +1 /W /Pcmd.exe /k echo ^%DATE^% ^%TIME^%
 &nbsp; &nbsp;then Hibernate:
 &nbsp; &nbsp; &nbsp; &nbsp;shutdown.exe /H
 &nbsp; &nbsp;or Sleep: (<a target="_blank" href="https://www.nirsoft.net/utils/nircmd-x64.zip">https://www.nirsoft.net/utils/nircmd[-x64].zip</a>)
 &nbsp; &nbsp; &nbsp; &nbsp;nircmdc.exe standby
The computer should Wake in 60 seconds and display precise date/time in a new window.

------------------------

There is NO ERROR CHECKING for /P{rogram} commands (existence of files, validity of commands, etc.)
/P{rogram} is an open-ended facility by design, and you are on your own.

/P{rogram} commands may be tested in the present moment with &#34;Alarm.bat +0 [/Q|/S] /P{command}&#34;
If an Alarm command works in the present (+0), it will work in the future as an Alarm, Wake, or Repeat.

If Alarm crashes due to faulty commands or untrapped errors, <b>issue</b>:
 &nbsp;Alarm.bat /XAA
to clean the first 1001 Scheduled Tasks created by Alarm (including orphans), and remove all Alarm
programming, for a fresh start.

Each Alarm error generates an explanatory message and a unique %ERRORLEVEL% (established in the code
at "set er=[ERRORLEVEL]") upon EXIT. Note that /Programs may generate their own %ERRORLEVEL%s.

N.B.: If Alarm detects files in the {Alarm.bat directory}\ALRM\ subfolder that pertain to an earlier
version of Alarm, it will autonomously wipe the Alarm system (clean it) before executing any command.

IMPORTANT: If you ALTER any variable in User Configuration, or change your CodePage or Power
Configuration, you MUST execute "Alarm.bat /XAA", to clean the system before next use!

------------------------

Differences between Alarms and Wakes|Repeats
-----------------------------
 &nbsp;Alarms may be canceled by issuing Alarm /X (or by deleting the bell icon in the Taskbar). In
 &nbsp; &nbsp;contrast, Wakes execute at the scheduled time regardless of whether a bell icon exists.
 &nbsp; &nbsp;Unlike regular Alarms, which require that the computer be awake and running, Wakes and
 &nbsp; &nbsp;Repeats will waken a computer from Screensaver, Sleep, and Hibernation states. Wakes and
 &nbsp; &nbsp;Repeats survive Shutdowns and Restarts -- alarms occur as scheduled if the computer is
 &nbsp; &nbsp;running, although bell icons in the Taskbar do not survive Shutdown|Restart. Wakes and Repeats
 &nbsp; &nbsp;will NOT start a computer that is in a Shutdown state at alarm time (use an external facility,
 &nbsp; &nbsp;e.g. a DD-WRT router with Wake-On-LAN programming, another computer on the LAN or WAN with WOL
 &nbsp; &nbsp;capability, TeamViewer, etc.).

Further Comments about Repeat (and Wake)
-----------------------------
 &nbsp;Repeats are a reiterative form of Wake.
 &nbsp;Repeats have an optional /E{xpiration}, stated as the total duration of the repeat in minutes.
 &nbsp;The Task Scheduler has many quirks. For example, a repeat interval greater than 9999 minutes must be
 &nbsp; &nbsp;evenly divisible by 60 (thus, &#34;Hourly&#34;). Alarm manages this inexplicable requirement
 &nbsp; &nbsp;by raising an uneven interval over 9999 to the next-higher hourly value.
 &nbsp;Relative to the Task Scheduler, Alarm is simple. If you request monthly notification, Alarm notifies
 &nbsp; &nbsp;EVERY month. If you want notification in January, April, July, and October (quarterly), or the
 &nbsp; &nbsp;1st and 15th of each month, or every Friday in the third week, then use TASKSCHD.MSC.
 &nbsp;Bearing Alarm's &#42;relative&#42; simplicity in mind, for:
 &nbsp; &nbsp;<b>Daily</b> scheduling, use a Repeat interval of 1440 minutes (/R1440).
 &nbsp; &nbsp;<b>Weekly</b>, use a Repeat interval of 10080 (/R10080) and schedule the initial instance for the DAY of
 &nbsp; &nbsp;the week and time of day that you want Alarm to fire: if every Monday, schedule the initial
 &nbsp; &nbsp;instance for next Monday.
 &nbsp; &nbsp;<b>Monthly</b>, similar to Weekly: Repeat interval = /R40320, but schedule the initial instance for the
 &nbsp; &nbsp;DATE within each month that you want Alarm to trigger: e.g. schedule the initial instance for the
 &nbsp; &nbsp;1st of next month; for the last day of each month, schedule the initial instance for the 28th
 &nbsp; &nbsp;or higher.
 &nbsp; &nbsp;<b>Example</b>: Alarm 9:00am /D15-6-21 /R40320 It's the 15th -- Payday -- and banks are OPEN
 &nbsp;Recursive Repeats are implemented using the /P{rogram} command to launch secondary instance(s) of
 &nbsp; &nbsp;Alarm. The following example starts a Daily repeat next Monday (the 20th of current month),
 &nbsp; &nbsp;which in turn launches a /S{poken} Repeat every 2 minutes for a duration of 10 minutes:
 &nbsp; &nbsp;<b>Example</b>: Alarm 6:59am /D20 /R1440 /Pcmd.exe /c Alarm.bat +1 /R2 /E10 /S Get out of bed
 &nbsp; &nbsp;N.B.: Because Repeats must be scheduled in the FUTURE, the Daily starts at 6:59, and the Spoken
 &nbsp; &nbsp;starts 1 minute later. Note too that a 10 minute duration (/E10) at 2-minute intervals (/R2) will
 &nbsp; &nbsp;yield 6 (not 5) alarms, at minutes 0-2-4-6-8-10.
 &nbsp; &nbsp;Approximately 30 seconds after Expiration, any lingering Taskbar icons will be removed, but the
 &nbsp; &nbsp;last-issued Text message (if any) will remain until manually Dismissed.
 &nbsp; &nbsp;Repeats with no /Expiry are canceled manually, using Alarm /X. Cancel only the Nag (with
 &nbsp; &nbsp;the Message!), not the Daily.
 &nbsp;Modify imperfect or inadequate Wake or Repeat commands with TASKSCHD.MSC. For example, you have
 &nbsp; &nbsp;three options to create a Repeat on weekdays only:
 &nbsp; &nbsp;1) create 5 different WEEKLY Repeats, starting Monday through Friday
 &nbsp; &nbsp;2) create one WEEKLY Repeat on Mondays, with two nested CMD /C instances of Alarm
 &nbsp; &nbsp;(/P switches within /P switches).
 &nbsp; &nbsp;The following example starts on Monday the 22nd at 7:28am and thereafter runs Weekly; at 7:29 it
 &nbsp; &nbsp;launches an each-morning Alarm for 5 days, which in turn launches an Alarm that nags every minute
 &nbsp; &nbsp;for 5 minutes, starting at 7:30. CMD's /C switch ensures that windows close when each iteration of
 &nbsp; &nbsp;Alarm exits. <b>Example</b>:
 &nbsp; &nbsp; &nbsp;Alarm 728am /D22 /R10080 /P/MIN cmd.exe /c Alarm.bat +1 /R1440 /E5760 /P/MIN cmd.exe /c Alarm.bat +1 /R1 /E5 /S HEY YOU. Get out of bed.
 &nbsp; &nbsp;3) create one WEEKLY Repeat starting Monday, then go to TASKSCHD.MSC ==> Task Scheduler Library ==>
 &nbsp; &nbsp; &nbsp; Triggers ==> Edit ==> checkmark Monday through Friday ==> confirm with OK ==> confirm OK.

 ------------------------

High-order single-byte characters (128-255):
Almost all US-ASCII (CP437) accented alphabetics in range 128-159, and Windows-ANSI characters in
 &nbsp; &nbsp;range 160-255, display correctly in Messages. Unicode messages in range 32-255 also display
 &nbsp; &nbsp;correctly with /C <i>if Clipboarded as Unicode</i>. Select the ANSI codepage for your locale
 &nbsp; &nbsp;in User Configuration, line 17 (default=1252). YMMV -- test individual characters to
 &nbsp; &nbsp;ascertain that they display.

 ------------------------

<b>Substitution strings</b> may be used to display (or, if sensible, speak) messages containing control
 &nbsp; &nbsp;characters (listed below) that have special meaning to Windows/DOS, or to the Batch processor,
 &nbsp; &nbsp;in contexts particular to each character. Many control characters cannot be directly
 &nbsp; &nbsp;manipulated by BATch files. Mileage WILL vary; the only way to know for sure whether
 &nbsp; &nbsp;you may use a particular character directly in a given context is to test it (clean up
 &nbsp; &nbsp;failure by issuing &#34;Alarm.bat /X[A]&#34; and/or restarting the CMD session if the
 &nbsp; &nbsp;environment is corrupted).
 &nbsp; &nbsp;Note that Alarm temporarily changes the CodePage during execution to CP437, then restores
 &nbsp; &nbsp;your original CP on exit. A crashed Alarm session could leave you with the wrong CodePage, so
 &nbsp; &nbsp;a CMD restart is prudent.
In contrast, substitution strings are reliable alternatives that always work. Note the systematic
 &nbsp; &nbsp;use of backquote &#34;&#96;&#34;. Full list (the &#34;hottest&#34; characters are asterisked;
 &nbsp; &nbsp;they almost always require substitution):
 
 &nbsp; &nbsp; &nbsp;&#96;q&#96;|&#96;quo&#96; = &nbsp; &nbsp;&#34; &nbsp; &nbsp;&#42;
 &nbsp; &nbsp; &nbsp;&#96;a&#96;|&#96;amp&#96; = &nbsp; &nbsp;& &nbsp; &nbsp;&#42;
 &nbsp; &nbsp; &nbsp;&#96;x&#96;|&#96;xcl&#96; = &nbsp; &nbsp;!
 &nbsp; &nbsp; &nbsp;&#96;bar&#96; &nbsp; &nbsp; = &nbsp; &nbsp;| &nbsp; &nbsp;&#42;
 &nbsp; &nbsp; &nbsp;&#96;lt&#96; &nbsp; &nbsp; &nbsp;= &nbsp; &nbsp;< &nbsp; &nbsp;&#42;
 &nbsp; &nbsp; &nbsp;&#96;gt&#96; &nbsp; &nbsp; &nbsp;= &nbsp; &nbsp; > &nbsp; &#42;
 &nbsp; &nbsp; &nbsp;&#96;lp&#96; &nbsp; &nbsp; &nbsp;= &nbsp; &nbsp;(
 &nbsp; &nbsp; &nbsp;&#96;rp&#96; &nbsp; &nbsp; &nbsp;= &nbsp; &nbsp; )
 &nbsp; &nbsp; &nbsp;&#96;bq&#96; &nbsp; &nbsp; &nbsp;= &nbsp; &nbsp;`
 &nbsp; &nbsp; &nbsp;&#96;sl&#96; &nbsp; &nbsp; &nbsp;= &nbsp; &nbsp;/
 &nbsp; &nbsp; &nbsp;&#96;crt&#96; &nbsp; &nbsp; = &nbsp; &nbsp;^ 
 &nbsp; &nbsp; &nbsp;&#96;v&#96;|&#96;var&#96; = &nbsp; &nbsp;% (bracket an environmental or user %VARIABLE%, e.g. &#96;var&#96;USERPROFILE&#96;var&#96;,
 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;and convert at alarm time to the value it represents)
 &nbsp; &nbsp; &nbsp;&#96;pct&#96; &nbsp; &nbsp; = &nbsp; &nbsp;% (as string literal)

Example:
-------
 &nbsp;An !!<i>INCORRECT</i>!! /S{poken} source command:
alarm.bat +1 /S /R5 /E30 The time is %TIME:~0,2% hours, %TIME:~3,2% minutes, and %TIME:~6,2% seconds
 &nbsp;The above command executes, but it hard-codes the TIME at the moment of issue, and repeats
 &nbsp; &nbsp;that static time at each of seven alarms. It <b>does</b> suffice if you only execute the command ONCE.
 &nbsp;SUBSTITUTED [<i>CORRECT</i>] <b>Example</b>:
alarm.bat +1 /S /R5 /E30 The time is &#96;var&#96;TIME:~0,2&#96;var&#96; hours, &#96;var&#96;TIME:~3,2&#96;var&#96; minutes, and &#96;var&#96;TIME:~6,2&#96;var&#96; seconds
 &nbsp;The above command reports the CORRECT current %TIME% at each of seven alarms.

 &nbsp;Try it! (<b>Example</b>):
 &nbsp; &nbsp;Alarm.bat +0 The time is &#96;var&#96;TIME:~0,2&#96;var&#96; hours, &#96;var&#96;TIME:~3,2&#96;var&#96; minutes, and &#96;var&#96;TIME:~6,2&#96;var&#96; seconds

------------------------

The Auxiliaries directory contains optional programs that operate in conjunction with Alarm and
offer specific services. ADJUST the &#34;d:\path&#92;&#34; to the programs!

 &nbsp;<b>CountDwn.bat</b>: verbal countdown to (and beyond) a specific time (e.g. start at 9:00am, for
 &nbsp; &nbsp;a total duration of 20 minutes)
 &nbsp; &nbsp;<b>Example</b>: Alarm.bat +1 /R1 /E20 /P/MIN d:\path\CountDwn.bat 0900
 &nbsp;<b>TimeOfDay.bat</b> {&#34;TalkTock&#34;}: e.g. starting at 4:30am, announce the current Time every
 &nbsp; &nbsp;15 minutes, until terminated (Alarm /X)
 &nbsp; &nbsp;<b>Example</b>: Alarm.bat 4:30a /R15 /P/MIN d:\path\TimeOfDay.bat
 &nbsp;<b>BigBen.wav</b>: e.g. chime hourly from 12 Noon until 9:00pm
 &nbsp; &nbsp;<b>Example</b>: Alarm.bat 1200 /R60 /E540 /P/MIN powershell.exe -c (New-Object Media.SoundPlayer &#34;d:\path\BigBen.wav&#34;).PlaySync()

------------------------

Messages (whether typed, extracted from the Clipboard, or from a file) are piped
 &nbsp;through MORE.COM, with the following extended features enabled:
 &nbsp; &nbsp;Q&nbsp; &nbsp; &nbsp; &nbsp;Quit
 &nbsp; &nbsp;&#60;space&#62; Display next page
 &nbsp; &nbsp;&#60;Enter&#62; Display next line
 &nbsp; &nbsp;P n &nbsp; &nbsp; Display next n lines
 &nbsp; &nbsp;S n &nbsp; &nbsp; Skip next n lines
 &nbsp; &nbsp;=&nbsp; &nbsp; &nbsp; &nbsp;Show line number
Multiple blank lines are reduced to a single line.

------------------------

Speak or Display PDF Text: Convert PDF to text first!
Try a port of the Unix public-domain &#34;pdftotext&#34; executable,
 &nbsp;e.g. Xpdf (<a target="_blank" href="https://www.xpdfreader.com/download.html">https://www.xpdfreader.com/download.html</a>).
 &nbsp; &nbsp;Tip: Use the &#34;-layout&#34; switch.
N.B.: This strategy may or may not work, depending on the integrity of the underlying PDF text.

------------------------

List Text-to-Speech (TTS) Voices installed on your computer (default Voice is listed first):
 &nbsp; &nbsp;powershell.exe -ExecutionPolicy Bypass -Command &#34;Add-Type -AssemblyName System.Speech;$speak=New-Object System.Speech.Synthesis.SpeechSynthesizer;$speak.GetInstalledVoices()|Select-Object -ExpandProperty VoiceInfo|Select-Object -Property Name,Gender,Description&#34;

Tip: If you find David, Hazel, Zira, Mark wooden or artificial, try Sean (IE), George (GB),
 &nbsp;or Heera (IN)

<b>How To</b>: &nbsp; &nbsp;Add, then Activate, "Foreign" Voices in Windows 10:

Add Languages: Settings > Time & Language > Language > Add a preferred language
Only add language packs that have an associated TTS (Text-To-Speech) capability (look for
 &nbsp;a little TTS icon).
 &nbsp; &nbsp; &nbsp; &nbsp;List of languages and TTS-capable voices:
<a target="_blank" href="https://support.office.com/en-us/article/how-to-download-text-to-speech-languages-for-windows-10-d5a6b612-b3ae-423f-afa5-4f6caf1ec5d3">https://support.office.com/en-us/article/how-to-download-text-to-speech-languages-for-windows-10-d5a6b612-b3ae-423f-afa5-4f6caf1ec5d3</a>
 &nbsp; &nbsp;N.B.: MORE voices are available with Cortana, e.g. Koyal (IN)

Activate Voices: Edit exported Registry files
<a target="_blank" href="https://www.ghacks.net/2018/08/11/unlock-all-windows-10-tts-voices-system-wide-to-get-more-of-them/">https://www.ghacks.net/2018/08/11/unlock-all-windows-10-tts-voices-system-wide-to-get-more-of-them/</a>
 &nbsp; &nbsp;A compendium of some Windows 10 TTS REG files is available on the Web.
 &nbsp; &nbsp;<b>BACKUP YOUR EXISTING REGISTRY FIRST!</b> No warranties! No guarantees!
 &nbsp; &nbsp;Do NOT run a REG file unless the corresponding Language pack is installed!
 &nbsp; &nbsp;Contents include Cortana and Mobile voices - try ONE first:
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
 &nbsp; &nbsp; &nbsp; &nbsp;<a target="_blank" href="http://xywrite.org/xywwweb/Voices.reg.zip">Voices.reg.zip</a>

Select one activated voice as default:
 &nbsp; &nbsp;Control Panel (control.exe) > Speech Recognition > Text to Speech > Voice selection (and "Apply")

------------------------

<b>CAUTION</b>: Edit Alarm.bat in an environment that uses 8-bit (single byte) character encodings ONLY!
 &nbsp; &nbsp; Do NOT edit with a word processor! Notepad may be used to adjust the User Configuration, ONLY!
 &nbsp; &nbsp; Alarm.bat was written in CodePage 437 (a.k.a. &#34;US-ASCII&#34;, &#34;OEM-US&#34;).
 &nbsp; &nbsp; Multiple-byte editors using UTF (Unicode) could corrupt the file. Caveat emptor.
 &nbsp; &nbsp; Notepad++ (<a target="_blank" href="https://notepad-plus-plus.org/">https://notepad-plus-plus.org/</a>) is recommended (set Encoding -> Character sets
  &nbsp; &nbsp; -> Western European -> OEM-US).

------------------------

 &nbsp; &nbsp;Author: Robert Holmgren
 &nbsp; &nbsp;Download: &nbsp;<a target="_blank" href="https://github.com/Rajah01/Alarm.bat/releases/">https://github.com/Rajah01/Alarm.bat/releases/</a>

 &nbsp; &nbsp; &nbsp;Credits:
 &nbsp; &nbsp; &nbsp;-------
 &nbsp; &nbsp;Vasil Arnaudov (<a target="_blank" href="https://github.com/npocmaka/batch.scripts/blob/master/hybrids/.net/c/mouse.bat">https://github.com/npocmaka/batch.scripts/blob/master/hybrids/.net/c/mouse.bat</a> and <a target="_blank" href="http://ss64.org/viewtopic.php?id=1687">http://ss64.org/viewtopic.php?id=1687</a>)
 &nbsp; &nbsp;Carl Distefano (<a target="_blank" href="http://xywwweb.ammaze.net/dls/TalkTock.zip">http://xywwweb.ammaze.net/dls/TalkTock.zip</a>)
 &nbsp; &nbsp;Alexandre Jasmin and Anchmerama (<a target="_blank" href="https://stackoverflow.com/questions/255419/how-can-i-mute-unmute-my-sound-from-powershell">https://stackoverflow.com/questions/255419/how-can-i-mute-unmute-my-sound-from-powershell</a>)
 &nbsp; &nbsp;Ritchie Lawrence (<a target="_blank" href="https://github.com/ritchielawrence/batchfunctionlibrary/tree/master/Date%20and%20Time%20Functions">https://github.com/ritchielawrence/batchfunctionlibrary/tree/master/Date%20and%20Time%20Functions</a>)
</pre></html>