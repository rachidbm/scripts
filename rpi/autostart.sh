#!/bin/sh
(sleep 30; \
/usr/sbin/ntpdate pool.ntp.org; \
)&
