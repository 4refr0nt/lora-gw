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
  host   : 'croft.thethings.girovito.nl', // Network Server TTN:croft.thethings.girovito.nl
  port   : 1700,                 // UDP data port on Network Server
  dev    : 'NiceRF',             // NiceRF or HopeRF
  lcd    : 1,                    // lcd: 1 - i2c, 0 - no LCD
  freq   : 868.1,                // freq
  gwID   : 0x0001,               // gwID will be added to MAC address
  reset  : 11,                   // modem RESET connected to WiringPi GPIO0 BCM IO17(real pin 11)
  tx_en  : 13,                   // modem TX_EN connected to WiringPi GPIO2 BCM IO27(real pin 13) - only for NiceRF
  rx_en  : 15                    // modem RX_EN connected to WiringPi GPIO3 BCM IO22(real pin 15) - only for NiceRF
}
