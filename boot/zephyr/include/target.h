/*
 *  Copyright (C) 2017, Linaro Ltd
 *  Copyright (c) 2019, Arm Limited
 *
 *  SPDX-License-Identifier: Apache-2.0
 */

#ifndef H_TARGETS_TARGET_
#define H_TARGETS_TARGET_

#if defined(MCUBOOT_TARGET_CONFIG)
/*
 * Target-specific definitions are permitted in legacy cases that
 * don't provide the information via DTS, etc.
 */
#include MCUBOOT_TARGET_CONFIG
#else
/*
 * Otherwise, the Zephyr SoC header and the DTS provide most
 * everything we need.
 */
#include <zephyr/devicetree.h>
#include <soc.h>
#include <zephyr/storage/flash_map.h>

#define FLASH_ALIGN FLASH_WRITE_BLOCK_SIZE

#endif /* !defined(MCUBOOT_TARGET_CONFIG) */

/*
 * Sanity check the target support. Split to pinpoint missing prerequisites.
 */
#if !defined(CONFIG_XTENSA) && !defined(CONFIG_SOC_SERIES_NRF54HX) && !DT_HAS_CHOSEN(zephyr_flash_controller)
#error "Missing zephyr_flash_controller chosen node; set DT chosen or enable appropriate SoC series."
#endif

#if defined(CONFIG_XTENSA) && !DT_NODE_EXISTS(DT_INST(0, jedec_spi_nor)) && !defined(CONFIG_SOC_FAMILY_ESPRESSIF_ESP32)
#error "Xtensa target missing JEDEC SPI NOR instance or ESP32 family config."
#endif

#if defined(CONFIG_SOC_SERIES_NRF54HX) && !DT_HAS_CHOSEN(zephyr_flash)
#error "nRF54HX target missing zephyr_flash chosen node."
#endif

#if !defined(FLASH_ALIGN)
#error "Missing FLASH_ALIGN definition."
#endif

#if !FIXED_PARTITION_EXISTS(slot0_partition)
#error "Missing slot0_partition definition."
#endif

#if !(FIXED_PARTITION_EXISTS(slot1_partition) || CONFIG_SINGLE_APPLICATION_SLOT)
#error "Missing slot1_partition and CONFIG_SINGLE_APPLICATION_SLOT is not set."
#endif

#if defined(CONFIG_BOOT_SWAP_USING_SCRATCH) && !FIXED_PARTITION_EXISTS(scratch_partition)
#error "Scratch swap requires scratch_partition definition."
#endif

#if (MCUBOOT_IMAGE_NUMBER == 2) && (!(FIXED_PARTITION_EXISTS(slot2_partition)) || \
                                     !(FIXED_PARTITION_EXISTS(slot3_partition)))
#error "Target support is incomplete; cannot build mcuboot."
#endif

#endif /* H_TARGETS_TARGET_ */
