rem @echo off

rem Windows batch file
rem MQ Client connects MQ server 

rem 2018/7/7
rem usage: mqclient.bat > o.txt 
rem
rem tested on win10 MQ905
rem result:
rem   messages were put into Q
rem   the messages were got from Q

set MQSERVER=SCON/TCP/localhost
set QNAME=Q1
set QMGR=QM1
set INFILE="..\dataIn\testmsg.in"

echo %MQSERVER%
echo %QMGR%
echo %INFILE%
echo %date% %time%

pause

rem strmqm %QMGR% 

amqsputc %QNAME% %QMGR% < %INFILE%

pause

amqsbcgc %QNAME% %QMGR%

pause

amqsgetc %QNAME% %QMGR%


