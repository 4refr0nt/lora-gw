# modems
# js2.coffee
'use restrict'
debug = true
# init = (n) ->
  # console.log 'LoRa Gateway Version: ' + version + ' started.'
  # console.log 'MRAA Version: ' + mraa.getVersion()
  # return
# nicerf

Spi =
  inOut: (data)->
    @

  register:(reg, val)->
    if val is undefined
    else
      'a'


  burstRead:(address, pointer, len)->

  burstWrite:(address, pointer, len)->

reg = 1
val = 0

console.log Spi.register( reg, val)

module.exports =
  ###*
   * [init description]
   * @param  {[type]} config [description]
   * @return {[type]}        [description]
  ###
  init: (@opt) ->
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
      @tx.write @opt.tx_en, 0
      # rx
      @rx = new mraa.Gpio(@opt.rx_en)
      @rx.dir mraa.DIR_OUT
      @rx.write @opt.rx_en, 0



    @

  onRecive:(req)->
    console.log req
    @

  send:(req)->
    @

