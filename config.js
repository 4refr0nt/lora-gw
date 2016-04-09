/*
 *                  __ _
 *                 / _(_)
 *  ___ ___  _ __ | |_ _  __ _
 * / __/ _ \| '_ \|  _| |/ _` |
 *| (_| (_) | | | | | | | (_| |
 * \___\___/|_| |_|_| |_|\__, |
 *                        __/ |
 *                       |___/
 * User defined section
 */

module.exports = {
  host    : 'croft.thethings.girovito.nl', // Network Server TTN:croft.thethings.girovito.nl
  host2   : 'localhost',          // second host for debug with UDP listener
  port    : 1700,                 // UDP data port on Network Server
  gwID    : 0x0001,               // gwID will be added to MAC address
  dev     : 'NiceRF',             // NiceRF or HopeRF
  lcd     : 0x3C,                 // 0x00 - no LCD or I2C address
  i2c_bus : 6,                    // bus: I2C bus number
  freq    : 868.1,                // freq
  spi_bus : 0,                    // bus: SPI bus number (for Raspberry Pi: 0 or 1)
  chip_sel: 22,                   // modem CS (NSS) connected to 22 (BCM IO25, WiringPi GPIO6)
  reset   : 11,                   // modem RESET connected to WiringPi GPIO0 BCM IO17 (real pin 11)
  dio0    : 7,                    // modem DIO0  connected to
  tx_en   : 13,                   // modem TX_EN connected to WiringPi GPIO2 BCM IO27 (real pin 13) - only for NiceRF
  rx_en   : 15                    // modem RX_EN connected to WiringPi GPIO3 BCM IO22 (real pin 15) - only for NiceRF
}
