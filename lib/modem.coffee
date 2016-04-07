#                      _
#                     | |
#  _ __ ___   ___   __| | ___ _ __ ___
# | '_ ` _ \ / _ \ / _` |/ _ \ '_ ` _ \
# | | | | | | (_) | (_| |  __/ | | | | |
# |_| |_| |_|\___/ \__,_|\___|_| |_| |_|
#
'use restrict'
mraa = require 'mraa'
upm  = require 'upm'
m    = require 'jsupm_sx1276'
debug = true

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
    @reset @opt
    @

  ###*
   * [reset description]
   * @return {[type]} [description]
  ###
  reset: ->
    if @opt.dev is 'NiceRF'
      # tx
      @tx = mraa.Gpio @opt.tx_en
      @tx.dir mraa.DIR_OUT
      @tx.write @opt.tx_en, 0
      # rx
      @rx = mraa.Gpio @opt.rx_en
      @rx.dir mraa.DIR_OUT
      @rx.write @opt.rx_en, 0
    # reset
    @reset = mraa.Gpio @opt.reset
    @reset.dir mraa.DIR_OUT
    @reset.write @opt.reset, 0
    delay 10
    @reset.write @opt.reset, 1
    delay 20


    @

  onRecive:(req)->
    console.log req
    @

  send:(req)->
    @

