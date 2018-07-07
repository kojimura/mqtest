rem @echo off

rem Windows batch file
rem test dmpmqmsg unloads q message to a file
rem
rem 2018/7/7
rem usage: dmpmqmsg.bat > o.txt 
rem
rem tested on win10 MQ905
rem result:
rem   messages were put into Q
rem   the messages were got from Q

set MQSERVER=SCON/TCP/localhost
set QNAME=Q1
set QMGR=QM1
set INFILE="..\dataIn\testmsg.in"
set OUTFILE="..\dataOut\dmpmqmsg.out"
set MSGFILE="..\dataOut\msg.out"

echo %MQSERVER%
echo %QMGR%
echo %INFILE%
echo %OUTFILE%
echo %MSGFILE%
echo %date% %time%

rem strmqm %QMGR% 
amqsput %QNAME% %QMGR% < %INFILE%
echo "COPY messges from queue into the file specified"
pause
dmpmqmsg -m %QMGR% -i %QNAME% -f %OUTFILE%

echo "After COPY check if there are messges left in the queue"
pause
amqsbcg %QNAME% %QMGR%
echo dis q(%QNAME%) curdepth|runmqsc %QMGR%

findstr "^X" %OUTFILE% > %MSGFILE%

echo "messges were left in the queue"
echo "UNLOAD a queue to series of files"
pause
dmpmqmsg -m %QMGR% -I %QNAME% -f %OUTFILE%%%n

echo "After UNLOAD check if there are messges left in the queue"
pause
amqsbcg %QNAME% %QMGR%
echo dis q(%QNAME%) curdepth|runmqsc %QMGR%

echo "RELOAD a queue to series of files"
pause
dmpmqmsg -m %QMGR% -o %QNAME% -f %OUTFILE%%%n

echo "After RELOAD check if there are messges left in the queue"
pause
amqsbcg %QNAME% %QMGR%
echo dis q(%QNAME%) curdepth|runmqsc %QMGR%


