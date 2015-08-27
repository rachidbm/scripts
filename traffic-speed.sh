#!/bin/bash
#
# displays download / upload speed by checking the /proc/net/dev with
# 1 second delay
#

if [ -z "${1}" ]; then
    echo "Give a network interface"
    exit 1
fi

link=${1}

/sbin/ifconfig ${link} >/dev/null 2>&1
if [ $? -ne 0 ]; then
    echo "no network interface named $link"
    exit 1
fi

old_state=$(cat /proc/net/dev | grep ${link})
sleep 1
new_state=$(cat /proc/net/dev | grep ${link})

# while [ "${old_state}" = "${new_state}" ]; do
#     sleep 0.1
#     new_state=$(cat /proc/net/dev | grep ${link})
# done

old_dn=`echo ${old_state/*:/} | awk -F " " '{ print $1 }'`
new_dn=`echo ${new_state/*:/} | awk -F " " '{ print $1 }'`
dnload=$((${new_dn} - ${old_dn}))

old_up=`echo ${old_state/*:/} | awk -F " " '{ print $9 }'`
new_up=`echo ${new_state/*:/} | awk -F " " '{ print $9 }'`
upload=$((${new_up} - ${old_up}))

d_speed=$(echo "scale=0;${dnload}/1024" | bc -lq)
u_speed=$(echo "scale=0;${upload}/1024" | bc -lq)

echo +${d_speed}k/s -${u_speed}k/s
