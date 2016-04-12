###*
  **        ******  ********
  **       **    ** **     **
  **       **       **     **
  **       **       **     **
  **       **       **     **
  **       **    ** **     **
  ********  ******  ********
 * @author Victor Brutskiy <4refr0nt@gmail.com>
 * @author Alex Suslov <suslov@me.com>
 * @copyright 2016
 * @license MIT
###
'use restrict'
Proto   = require './proto'
lcdObj       = require '/usr/local/lib/node_modules/jsupm_i2clcd'
class Lcd extends Proto
  events:
    Enable    : 'Enable'
    DrawLogo  : 'DrawLogo'
    Disable   : 'Disable'

  initialize: (@config)->
    console.log 'lcd config', @config
    if @config.enabled
      @Bus.emit 'Logger', 'LCD: Init...', 0
      try
        #lcd = new lcdObj.SSD1306 @opt.lcd.i2c_bus, @opt.lcd.i2c_addr
        lcd = new lcdObj.SSD1306 0, 0x3c
      catch e
        return console.log e

    @

  Enable:-> @
  Disable:-> @
  DrawLogo:-> @


module.exports = Lcd
