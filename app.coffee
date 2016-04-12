###*
 **        *******  ********     ***    **      **    ***    **    **
 **       **     ** **     **   ** **   **  **  **   ** **   ***   **
 **       **     ** **     **  **   **  **  **  **  **   **  ****  **
 **       **     ** ********  **     ** **  **  ** **     ** ** ** **
 **       **     ** **   **   ********* **  **  ** ********* **  ****
 **       **     ** **    **  **     ** **  **  ** **     ** **   ***
 ********  *******  **     ** **     **  ***  ***  **     ** **    **
 * Lorawan Gateway
 *
 * @author Victor Brutskiy <4refr0nt@gmail.com>
 * @author Alex Suslov <suslov@me.com>
 * @copyright 2016
 * @license MIT
###
'use restrict'

config  = require './config'
Proto   = require './lib/proto'
pack    = require './package.json'

# hardware = require './lib/hardware'
Modem = require './lib/modem'
Lcd = require './lib/lcd'
Hardware = require './lib/hardware'

class App extends Proto
  debug: 10
  version: pack.version

  events:
    Logger  : 'log'
    exit    : 'exit'
    SIGINT  : 'exit'
  log:(msg, level)->
    console.log level, msg
    @

  exit:->
    # @todo destroy
    process.exit 0
    @


  ###*
   * [checkConfig description]
   * @param  {Object} cfg
   * @return @
  ###
  checkConfig:(cfg)->
    unless cfg
      @Bus 'Exit', 'Config data not found in config.js. Exiting...'
      return
    RF_frontend_count = 0

    config.RF.forEach (element) =>
      if element.enabled
        if element.type is 'SPI_SX1276'
          if element.brand is 'NiceRF' or element.brand is 'HopeRF'
            RF_frontend_count++
          else

            @Bus.emit 'Exit'
            , "Unknown RF frontend brand #{element.brand} in config.js. Exiting...", true
        else
          @Bus.emit 'Exit', "Unknown RF frontend type #{element.type} in config.js. Exiting...", true
    unless RF_frontend_count
      @Bus.emit 'Exit', 'No configured RF frontend device found in config.js. Exiting...', true
    @


  ###*
   * [main description]
   * @param  {Object} @config
   * @return @
  ###
  initialize: (@config)->
    @Bus.emit 'Logger', "LoRa Gateway Version:  #{@version}  started.", 0
    @checkConfig @config
    # modem
    # @modem = new Modem @config
    # @modem.Bus.on 'Logger', @log
    # Lcd
    # @lcd = new Lcd @config.lcd
    # @lcd.Bus.on 'Logger', @log
    #
    # Hardware
    @hardware = new Hardware @config
    @hardware.Bus.on 'Logger', @log
    @hardware.info()

    @

app = new App config
