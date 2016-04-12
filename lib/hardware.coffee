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

  info : ->
    @Bus.emit 'Logger', 'Hardware: Init...', @config
    mraa.setLogLevel(7) if @config.debug
    console.log """
-------------------------------------------------
hw: MRAA Version  : #{mraa.getVersion()}
hw: Board name    : #{mraa.getPlatformName()}
hw: Platform type : #{mraa.getPlatformType()}
hw: Pin count     : #{mraa.getPinCount()}
hw: I2C bus count : #{mraa.getI2cBusCount()}
-------------------------------------------------
    """
    @config.RF.forEach ( p, i) ->
      console.log """
RF frontend #{i} pinmaps
hw: RESET  : #{ mraa.getPinName p.reset }
hw: SPI CS : #{ mraa.getPinName p.spi_cs }
hw: DIO0   : #{ mraa.getPinName p.dio0 }
hw: TX_EN  : #{ mraa.getPinName p.tx_en }
hw: RX_EN  : #{ mraa.getPinName p.rx_en }
-------------------------------------------------
SPI bus mapping for this board:
      """
    p = 0
    while p < mraa.getPinCount()
      try
        pName = mraa.getPinName p
        if /SPI/i.test(pName)
          console.log "hw: pin: " + pName + " " + p
      catch e
        console.log e
      p++
    console.log '-------------------------------------------------'
    @


module.exports = Hardware
