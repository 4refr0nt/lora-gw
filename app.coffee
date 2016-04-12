###*
 **        *******  ********     ***    **      **    ***    **    **
 **       **     ** **     **   ** **   **  **  **   ** **   ***   **
 **       **     ** **     **  **   **  **  **  **  **   **  ****  **
 **       **     ** ********  **     ** **  **  ** **     ** ** ** **
 **       **     ** **   **   ********* **  **  ** ********* **  ****
 **       **     ** **    **  **     ** **  **  ** **     ** **   ***
 ********  *******  **     ** **     **  ***  ***  **     ** **    **
 * Lorawan Gateway
 * @authors:
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
# modem = require('./lib/modem')
# lcd = require './lib/lcd'



app = new Proto
  debug: 10
  version: pack.version

  events:
    Logger: 'log'
    exit: 'exit'
    SIGINT: 'exit'

  log:( msg, level)->
    console.log msg if level <= @debug
    @


  exit:->
    # @todo destroy
    process.exit 0
    @

  checkConfig:(cfg)->
    unless cfg
      @Bus 'Exit', 'Config data not found in config.js. Exiting...'
      return
    RF_frontend_count = 0

    config.RF_frontend.forEach (element) =>
      if element.enabled
        if element.type is 'SPI_SX1276'
          if element.brand is 'NiceRF' or element.brand is 'HopeRF'
            RF_frontend_count++
          else
            @Bus.emit 'Exit', "Unknown RF frontend brand #{element.brand}  in config.js. Exiting...", true
        else
          @Bus.emit 'Exit', "Unknown RF frontend type  #{element.type}  in config.js. Exiting...", true
    unless RF_frontend_count
      @Bus.emit 'Exit', 'No configured RF frontend device found in config.js. Exiting...', true
    @
  main:(@config)->
    @Bus.emit 'Logger', "LoRa Gateway Version:  #{@version}  started."
    @checkConfig @config

    @


app.main config

