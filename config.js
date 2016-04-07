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
  reset  : 0,                    // modem RESET connected to Rpi GPIO0 IO
  tx_en  : 2,                    // modem TX_EN connected to Rpi GPIO2 IO27 - only for NiceRF
  rx_en  : 3                     // modem RX_EN connected to Rpi GPIO3 IO22 - only for NiceRF
}
