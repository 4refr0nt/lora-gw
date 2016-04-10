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
    type         : 'SPI_SX1276',
    enabled      : true,
    brand        : 'NiceRF',             // NiceRF or HopeRF
    spi_bus      : 0,                    // bus: SPI bus number (for Raspberry Pi: 0 or 1)
    freq         : 868.1,                // freq/1000000
    spi_cs       : 24,                   // modem NSS connected to 24 SPI CHIP_SELECT_0 (CS0)
    reset        : 11,                   // modem RESET connected to WiringPi GPIO0 BCM IO17 (real pin 11)
    dio0         : 16,                   // modem DIO0  connected to pin 16 (BCM 23)
    tx_en        : 13,                   // modem TX_EN connected to WiringPi GPIO2 BCM IO27 (real pin 13) - only for NiceRF
    rx_en        : 15,                   // modem RX_EN connected to WiringPi GPIO3 BCM IO22 (real pin 15) - only for NiceRF
    bandwidth    : 125000,               // for LoRa available values: [125 kHz, 250 kHz, 500 kHz] * 1000
    datarate     : 7,                    // for LoRa available values: [6: 64, 7: 128, 8: 256, 9: 512, 10: 1024, 11: 2048, 12: 4096 chips]
    coderate     : 1,                    // for LoRa available values: [1: 4/5, 2: 4/6, 3: 4/7, 4: 4/8]
    bandwidthAfc : 0,                    // for LoRa always zero
    preambleLen  : 8,                    // for LoRa: Length in symbols (the hardware adds 4 more symbols)
    symbTimeout  : 5,                    // for LoRa: timeout in symbols
    fixLen       : false,                // Fixed length packets [false: variable, true: fixed]
    payloadLen   : 0,                    // Sets payload length when fixed lenght is used or 0 for variable packets length
    crcOn        : true,                 // Enables/Disables the CRC [false: OFF, true: ON]
    freqHopOn    : false,                // Freq hop not yet supported
    hopPeriod    : 0,                    // Freq hop not yet supported
    iqInverted   : false,                // for LoRa: [false: not inverted, true: inverted]
    rxContinuous : true                  // Sets the reception in continuous mode [false: single mode, true: continuous mode]
  }],
  lcd : {
    type: 'I2C_LCD_SSD1306',
    enabled : true,
    i2c_bus : 0,     // bus: I2C bus number
    i2c_addr: 0x3C,  // I2C address
  },
  // TODO choose name
  stdout : {
    enabled : true
  },
  debug: true,
  board_info: true, // print board info at startup
  // TODO more options?
}
