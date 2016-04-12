###*
  **     **    ***    ********  ********  **      **    ***    ********
  **     **   ** **   **     ** **     ** **  **  **   ** **   **     **
  **     **  **   **  **     ** **     ** **  **  **  **   **  **     **
  ********* **     ** ********  **     ** **  **  ** **     ** ********
  **     ** ********* **   **   **     ** **  **  ** ********* **   **
  **     ** **     ** **    **  **     ** **  **  ** **     ** **    **
  **     ** **     ** **     ** ********   ***  ***  **     ** **     **
 *
 * @author Victor Brutskiy <4refr0nt@gmail.com>
 * @author Alex Suslov <suslov@me.com>
 * @copyright 2016
 * @license MIT
###

'use restrict'

Proto = require './proto'
mraa  = require 'mraa'

class Hardware extends Proto
  initialize: (@config)-> @
  dropLine: -> [0..50].map(->'-').join ''

  info : ->
    @Bus.emit 'Logger', 'Hardware: Init...', @config
    mraa.setLogLevel(7) if @config.debug
    console.log """
hw: #{@dropLine()}
hw: MRAA Version  : \t #{mraa.getVersion()}
hw: Board name    : \t #{mraa.getPlatformName()}
hw: Platform type : \t #{mraa.getPlatformType()}
hw: Pin count     : \t #{mraa.getPinCount()}
hw: I2C bus count : \t #{mraa.getI2cBusCount()}
hw: #{@dropLine()}
    """
    @config.RF.forEach ( p, i) =>
      console.log """
hw: RF frontend #{i} pinmaps
hw: RESET  : \t #{ mraa.getPinName p.reset }
hw: SPI CS : \t #{ mraa.getPinName p.spi_cs }
hw: DIO0   : \t #{ mraa.getPinName p.dio0 }
hw: TX_EN  : \t #{ mraa.getPinName p.tx_en }
hw: RX_EN  : \t #{ mraa.getPinName p.rx_en }
hw: #{@dropLine()}
hw: SPI bus mapping for this board:
      """
    p = 0
    while p < mraa.getPinCount()
      try
        pName = mraa.getPinName p
        if /SPI/i.test(pName)
          console.log "hw: pin: \t" + pName + " \t" + p
      catch e
        console.log e
      p++
    console.log """
hw: #{@dropLine()}
    """
    @


module.exports = Hardware
