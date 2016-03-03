#!/bin/sh

# tbd
# check for existence first, deal with mac addresses for real, error handling
# ap should use true device mac address, sta can use a locally administered mac address
# device name should be passed in by udev $name

NAME=${1}

iw dev ${NAME} interface add ${NAME}_sta type station
ip link set dev ${NAME}_sta address 12:34:56:78:ab:cd

iw dev wlan0 interface add ${NAME}_ap  type __ap
ip link set dev ${NAME}_ap address 12:34:56:78:ab:ce
ip link set dev ${NAME}_ap up
