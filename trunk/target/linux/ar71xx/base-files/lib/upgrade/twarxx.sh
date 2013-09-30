#!/bin/sh
#
# Copyright (C) 2012-2013 Hiwifi Wireless <eric.zhong@ikwcn.com>
#

platform_do_upgrade_twarxx() {
	local board=$(ar71xx_board_name)
	sync

	sleep 2
	setled timer green system 500 2500
	sleep 1
	setled timer green internet 500 2500
	sleep 1
	setled timer green wlan-2p4 500 2500

	if [ "$SAVE_CONFIG" -eq 1 -a -z "$USE_REFRESH" ]; then
		get_image "$1" | mtd -j "$CONF_TAR" write - "${PART_NAME:-image}"
	else
		get_image "$1" | mtd write - "${PART_NAME:-image}"
	fi
}
