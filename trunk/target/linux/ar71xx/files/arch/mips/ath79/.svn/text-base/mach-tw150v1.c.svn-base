/*
 *  Hiwifi Wireless AR9331 Dreamboard (HORNET SoC) support
 *
 *  Copyright (C) 2012-2013 eric
 *
 *  This program is free software; you can redistribute it and/or modify it
 *  under the terms of the GNU General Public License version 2 as published
 *  by the Free Software Foundation.
 */

#include <linux/gpio.h>
#include <linux/proc_fs.h>

#include <asm/mach-ath79/ath79.h>
#include <asm/mach-ath79/ar71xx_regs.h>

#include "common.h"
#include "dev-eth.h"
#include "dev-gpio-buttons.h"
#include "dev-leds-gpio.h"
#include "dev-m25p80.h"
#include "dev-usb.h"
#include "dev-wmac.h"
#include "machtypes.h"
#include "bdinfo.h"


#define TW150V1_GPIO_LED_WLAN_2P4	0	/* 2.4G wlan led */
#define TW150V1_GPIO_LED_USBFLAG	6	/* usb flag */
#define	TW150V1_GPIO_LED_SYSTEM		1	/* system led */
#define TW150V1_GPIO_LED_INTERNET	27	/* internet led */

#define TW150V1_GPIO_USBPOWER		20	/* usb power control */
#define	TW150V1_GPIO_BTN_RST		11	/* reset and wps button */

#define TW150V1_GPIO_LED_LAN1	13
#define TW150V1_GPIO_LED_LAN2	14
#define TW150V1_GPIO_LED_LAN3	15
#define TW150V1_GPIO_LED_LAN4	16
#define TW150V1_GPIO_LED_WAN	17

#define TW150V1_KEYS_POLL_INTERVAL	20	/* msecs */
#define TW150V1_KEYS_DEBOUNCE_INTERVAL	(3 * TW150V1_KEYS_POLL_INTERVAL)

extern void ar933x_eth_leds_on(void);
extern void ar933x_eth_leds_off(void);

static struct gpio_led tw150v1_leds_gpio[] __initdata = {
	{
		.name		= "tw150v1:green:wlan-2p4",
		.gpio		= TW150V1_GPIO_LED_WLAN_2P4,
		.active_low	= 1,
	}, {
		.name		= "tw150v1:green:system",
		.gpio		= TW150V1_GPIO_LED_SYSTEM,
		.active_low	= 1,
	}, {
		.name		= "tw150v1:green:internet",
		.gpio		= TW150V1_GPIO_LED_INTERNET,
		.active_low	= 1,
	}
};

static struct gpio_keys_button tw150v1_gpio_keys[] __initdata = {
	{
		.desc		= "reset",
		.type		= EV_KEY,
		.code		= KEY_RESTART,
		.debounce_interval = TW150V1_KEYS_DEBOUNCE_INTERVAL,
		.gpio		= TW150V1_GPIO_BTN_RST,
		.active_low	= 1,
	}
};

static void __init tw150v1_setup(void)
{
	u8 mac[6];
	//u8 *mac = (u8 *) KSEG1ADDR(0x1f010000);
	u8 *ee = (u8 *) KSEG1ADDR(0x1fff1000);

	u8 no_cal_pattern[12];
	u8 cal_test_data[12];

	ath79_setup_ar933x_phy4_switch(false, false);

	ath79_gpio_function_enable(
					AR933X_GPIO_FUNC_ETH_SWITCH_LED0_EN |
				    AR933X_GPIO_FUNC_ETH_SWITCH_LED1_EN |
				    AR933X_GPIO_FUNC_ETH_SWITCH_LED2_EN |
				    AR933X_GPIO_FUNC_ETH_SWITCH_LED3_EN |
				    AR933X_GPIO_FUNC_ETH_SWITCH_LED4_EN);

	ath79_register_m25p80(NULL);

	/* check board radio is calibrated or not */
	memset(no_cal_pattern, 0xff, sizeof(no_cal_pattern));

	memcpy(cal_test_data, ee, 4);
	memcpy(cal_test_data + 4, ee + 0x140, 4);
	memcpy(cal_test_data + 8, ee + 0x1e0, 4);

	if (0 == memcmp(no_cal_pattern, cal_test_data, sizeof(cal_test_data)))
	{
		printk(KERN_WARNING "TW150-v1: MISS RADIO CAL DATA!\n");
	}

	ath79_register_leds_gpio(-1, ARRAY_SIZE(tw150v1_leds_gpio),
				 tw150v1_leds_gpio);
	ath79_register_gpio_keys_polled(-1, TW150V1_KEYS_POLL_INTERVAL,
					ARRAY_SIZE(tw150v1_gpio_keys),
					tw150v1_gpio_keys);

	ath79_set_usb_power_gpio(TW150V1_GPIO_USBPOWER, GPIOF_OUT_INIT_HIGH,
				"USB power");
	ath79_register_usb();

	macstr_to_hex(mac, bdinfo_get_fac_mac());
	ath79_init_mac(ath79_eth0_data.mac_addr, mac, 1);
	ath79_init_mac(ath79_eth1_data.mac_addr, mac, 0);	/* eth0(GE1) and wifi0 use same mac_addr */

	ath79_register_mdio(0, 0x0);

	ath79_register_eth(1);
	ath79_register_eth(0);

	ath79_register_wmac(ee, mac);	
}

MIPS_MACHINE(ATH79_MACH_TW150V1, "HC6361", "Hiwifi Wireless HC6361 Board", tw150v1_setup);
