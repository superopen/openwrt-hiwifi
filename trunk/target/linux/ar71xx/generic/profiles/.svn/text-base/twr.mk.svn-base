#
# Copyright (C) 2012-2013 Hiwifi Wireless
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

define Profile/TW150V1
	NAME:=Hiwifi Wireless TW150V1 Board (AR9331)
	PACKAGES:= kmod-usb-core kmod-usb2 kmod-usb-storage kmod-usb-storage-extras \
				ppp-mod-pppol2tp ppp-mod-pptp \
				kmod-crypto-deflate kmod-fs-ext4 kmod-fs-msdos kmod-fs-ntfs kmod-fs-vfat \
				kmod-ledtrig-gpio kmod-ledtrig-usbdev \
				kmod-nls-cp437 kmod-nls-iso8859-1 kmod-nls-utf8 \
				e2fsprogs
endef

define Profile/TW150V1/description
	Package set optimized for the Hiwifi Wireless AR9331 New Board.
endef
$(eval $(call Profile,TW150V1))
