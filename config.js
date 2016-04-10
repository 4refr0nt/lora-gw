/*                  __ _
 *                 / _(_)
 *  ___ ___  _ __ | |_ _  __ _
 * / __/ _ \| '_ \|  _| |/ _` |
 *| (_| (_) | | | | | | | (_| |
 * \___\___/|_| |_|_| |_|\__, |
 *                        __/ |
 *                       |___/
 * User defined section
 * Copy ./config-distr.js to ./config.js and edit settings
 */
module.exports = {
  NetworkServer : {
    enabled : false,
    host    : 'croft.thethings.girovito.nl', // Network Server TTN:croft.thethings.girovito.nl
    port    : 1700,                          // UDP data port on Network Server
    gwID    : 0x0001,                        // gwID will be added to MAC address
  },
  DebugServer : {
    enabled : true,
    host    : 'localhost',                   // debug host with UDP listener
    port    : 1700,                          // UDP data port on DebugServer
  },
  MQTTserver : {
    enabled : false,
    host    : 'mqtt.42do.ru',
    port    : 20000,
    user    : 'test',
    pass    : 'test',
  },
  RF_frontend : [{
    type    : 'SPI_SX1276',
    enabled : true,
    brand   : 'NiceRF',             // NiceRF or HopeRF
    spi_bus : 0,                    // bus: SPI bus number (for Raspberry Pi: 0 or 1)
    freq    : 868.1,                // freq
    chip_sel: 22,                   // modem CS (NSS) connected to 22 (BCM IO25, WiringPi GPIO6)
    reset   : 11,                   // modem RESET connected to WiringPi GPIO0 BCM IO17 (real pin 11)
    dio0    : 7,                    // modem DIO0  connected to
    tx_en   : 13,                   // modem TX_EN connected to WiringPi GPIO2 BCM IO27 (real pin 13) - only for NiceRF
    rx_en   : 15                    // modem RX_EN connected to WiringPi GPIO3 BCM IO22 (real pin 15) - only for NiceRF
  }],
  lcd : {
    type: 'I2C_LCD_SSD1306',
    enabled : true,
    i2c_bus : 0,                    // bus: I2C bus number
    i2c_addr: 0x3C,                 // I2C address
  },
  // TODO choose name
  stdout : {
    enabled : true
  },
  debug: true,
  // TODO more options?
}
