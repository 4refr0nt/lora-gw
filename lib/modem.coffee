#                      _
#                     | |
#  _ __ ___   ___   __| | ___ _ __ ___
# | '_ ` _ \ / _ \ / _` |/ _ \ '_ ` _ \
# | | | | | | (_) | (_| |  __/ | | | | |
# |_| |_| |_|\___/ \__,_|\___|_| |_| |_|
#
'use restrict'
mraa  = require 'mraa'
sleep = require 'sleep'
#m    = require 'jsupm_sx1276'

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
    @reset()
    @

  ###*
   * [reset description]
   * @return {[type]} [description]
  ###
  reset: ->
    if @opt.dev is 'NiceRF'
      # tx
      @tx = new mraa.Gpio(@opt.tx_en)
      @tx.dir mraa.DIR_OUT
      @tx.write 0
      # rx
      @rx = new mraa.Gpio(@opt.rx_en)
      @rx.dir mraa.DIR_OUT
      @rx.write 0
      console.log '-> NiceRF TX and RX disabled'
    # reset
    @reset = new mraa.Gpio(@opt.reset)
    @reset.dir mraa.DIR_OUT
    @reset.write 0
    sleep.usleep 10000 # 10ms
    @reset.write 1
    sleep.usleep 20000 # 20ms
    console.log '-> Transceiver RESET: Success'

    @

  onRecive:(req)->
    console.log req
    @

  send:(req)->
    @

