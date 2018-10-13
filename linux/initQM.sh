#!/bin/bash
# build initial qmgr for test
#

QMGR='QMA'

crtmqm ${QMGR}
strmqm ${QMGR}
echo "def ql(Q1)" | runmqsc ${QMGR}
echo "def lstr(LS) trptype(TCP) port(14140) control(QMGR)" | runmqsc ${QMGR}
echo "start lstr(LS)" | runmqsc ${QMGR}
echo "def chl(SCON) chltype(SVRCONN) trptype(TCP) mcauser('mqm')" | runmqsc ${QMGR}
echo "alt qmgr chlauth(disabled) connauth('')" | runmqsc ${QMGR}
echo "refresh security" | runmqsc ${QMGR}

# MQSERVER=
# amqsput
# endmqm
# dltmqm

