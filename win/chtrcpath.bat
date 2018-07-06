rem @echo off

rem Windows batch file
rem change mq trace path 

rem 2018/7/6
rem usage: . ./chtrcpath.bat > o.txt 
rem
rem tested on win10 MQ905
rem result:
rem   trace directory was changed, files were generated in modified place,
rem   but no file generated in error directory

rem setmqenv -s

set MQTRACEPATH="C:\home\temp\mytrace"
set MQERRORPATH="C:\home\temp\myerror"

set QMGR="QM1"
set OUTFILE="chtrcpath.out"

echo %MQTRACEPATH%
echo %QMGR%
echo %OUTFILE%
echo %date% %time%

pause

del %MQTRACEPATH%\*.*

strmqtrc -e 
strmqm %QMGR% 
dmpmqcfg -t all -m %QMGR% > %OUTFILE%
endmqm %QMGR%
endmqtrc -a
dir %MQTRACEPATH%
dir %MQERRORPATH%
echo %date% %time%

