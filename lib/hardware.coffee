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
    pins = @config.RF_frontend


    @


module.exports = Hardware
