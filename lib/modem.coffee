###*
  **     **  *******  ********  ******** **     **
  ***   *** **     ** **     ** **       ***   ***
  **** **** **     ** **     ** **       **** ****
  ** *** ** **     ** **     ** ******   ** *** **
  **     ** **     ** **     ** **       **     **
  **     ** **     ** **     ** **       **     **
  **     **  *******  ********  ******** **     **
 * @author Victor Brutskiy <4refr0nt@gmail.com>
 * @author Alex Suslov <suslov@me.com>
 * @copyright 2016
 * @license MIT
###
'use restrict'
Proto   = require './proto'
mraa    = require 'mraa'
jsupm   = require 'jsupm_sx1276'

class Modem extends Proto
  events:
    open:'open'
    rx:'rx'

  ###*
   * [open description]
   * @param  {Object} @opt [Modem Config]
   * @return @
  ###
  open:(@opt)->
    @Bus.emit 'Logger', 'rf: modem open...', 10
    try
      m = new jsupm.SX1276 0x12, 0, 24, 11, 16, 13, 15, 29, 31, 33
    catch e
      console.log e
      process.exit 0
    @


  rx:->
    @


module.exports = Modem
