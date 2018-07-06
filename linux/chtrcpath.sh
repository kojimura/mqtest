#!/bin/bash 
#
# 2018/7/6
# test script
# change mq trace path 
# usage: . ./chtrcpath.sh &> o.txt 
#
# tested on CenOS7 MQ905
# result:
#   trace directory was changed, files were generated in modified place,
#   but no file generated in error directory
#

set -x

. setmqenv -s

export MQTRACEPATH='/home/mqm/mytrace'
export MQERRORPATH='/home/mqm/myerror'

QMGR='SES'
OUT='chtrcpath.out'

date "+%Y/%m/%d %H:%M:%S" > ${OUT}
rm -f /home/mqm/mytrace/*
strmqtrc -e >> ${OUT} 2>&1
strmqm ${QMGR} &>> ${OUT}
dmpmqcfg -t all -m ${QMGR} > dmpmqcfg.out
endmqm ${QMGR} &>> ${OUT}
endmqtrc -e &>> ${OUT}
pushd ${MQTRACEPATH}
dspmqtrc *.TRC
popd
ls -l /home/mqm/mytrace &>> ${OUT}
ls -l /home/mqm/myerror &>> ${OUT}
date "+%Y/%m/%d %H:%M:%S" &>> ${OUT}

set +x

