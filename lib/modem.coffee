#                      _
#                     | |
#  _ __ ___   ___   __| | ___ _ __ ___
# | '_ ` _ \ / _ \ / _` |/ _ \ '_ ` _ \
# | | | | | | (_) | (_| |  __/ | | | | |
# |_| |_| |_|\___/ \__,_|\___|_| |_| |_|
#
'use restrict'
mraa  = require 'mraa'
#m    = require 'jsupm_sx1276'

debug = true
Lock = false
###*
 * @param {Number} pin [real pin on pcb]
 * @param {Number} dir [pin direction]
 * @param {Number} val [value]
 * @return rmaa Pin object
###
gpio = (pin, dir, val)->
  try
    Pin = new mraa.Gpio pin
  catch e
    throw new Error "wrong pin", e

  Pin.dir dir
  Pin.write val if val isnt undefined
  Pin


###*
 * [resetModule description]
 * @param  {Function} cb [description]
 * @return {[type]}      [description]
###
resetModule = (pin, cb)->
  Lock = true
  Reset = gpio pin, mraa.DIR_OUT, 0
  setTimeout ->
    Reset.write 1
    setTimeout ->
      Lock = false
      cb()
    , 20 # 20ms
  , 10 # 10ms


###*
 * [Spi description]
 * @type {[type]}
###
Spi =
  inOut: (data)->
    @

  register:(reg, val)->
    if val is undefined
    else
      'a'

  burstRead:(address, pointer, len)->

  burstWrite:(address, pointer, len)->
    @

module.exports =
  ###*
   * [init description]
   * @param  {[type]} config [description]
   * @return {[type]}        [description]
  ###
  init:(@opt) ->
    # call reset first
    @reset()
    @



  ###*
   * [reset description]
   * @return {[type]} [description]
  ###
  reset: ->
    if @opt.dev is 'NiceRF'
      # tx
      @tx_en = gpio @opt.tx_en,  mraa.DIR_OUT, 0
      # rx
      @rx_en = gpio @opt.rx_en,  mraa.DIR_OUT, 0
      console.log '-> NiceRF TX and RX disabled'
    # reset
    resetModule @opt.reset, ->
      console.log '-> Transceiver RESET: Success'
    @

  onRecive:(req)->
    console.log req
    @

  send:(req)->
    @
