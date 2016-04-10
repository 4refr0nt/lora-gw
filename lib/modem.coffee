# @authors:
#    Victor Brutskiy <4refr0nt@gmail.com>
#    Alex   Suslov   <alexsuslov@me.com>
#    Copyright (c) 2016
#
# @license: MIT       ___
#  _ __ ___   ___   __| | ___ _ __ ___
# | '_ ` _ \ / _ \ / _` |/ _ \ '_ ` _ \
# | | | | | | (_) | (_| |  __/ | | | | |
# |_| |_| |_|\___/ \__,_|\___|_| |_| |_|
#
'use restrict'
EventEmitter = require 'events'
mraa         = require 'mraa'
sx1276       = require 'jsupm_sx1276_NiceHope'

Bus = new EventEmitter()

# module vars
m        = null # TODO m[2?]
rx_timer = null

debug    = true
Lock     = false

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
      Bus.emit 'Resets'
      cb() if typeof cb is "function"
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
  # event bus
  # https://nodejs.org/api/events.html
  Bus: Bus
  # events
  events:->
    Bus.on 'reset', @reset
    @


  ###*
   * [open description]
   * @param  {[type]} config [description]
   * @return {[type]}        [description]
  ###
  open:(@opt) ->
    @events()
    debug = @opt.debug # TODO check value
    Bus.emit 'Logger', 'MRAA Version: ' + mraa.getVersion()
    m = new sx1276.SX1276_NiceHope
    m.setChannel 868100000 # 868.1 MHz
    # TODO All LoRa RF parameters in config
    # LORA configuration (rx and tx must be configured the same):
    # Tx output power = 14 dBm
    # LORA bandwidth = 125000 (can also be 250K and 500K)
    # LORA spreading factor = 7
    # LORA coding rate = 1 (4/5)
    # LORA preamble len = 8
    # LORA symbol timeout = 5
    # LORA fixed payload = false
    # LORA IQ inversion = false
    # LORA (rx) continuous Rx mode = true
    #sensor.setTxConfig(sensorObj.SX1276.MODEM_LORA, 14, 0, 125000,
    #                7, 1, 8, false, true, false, 0, false);
    #m.setRxConfig sx1276.SX1276.MODEM_LORA, 125000, 7, 1, 0, 8, 5, false, 0, true, false, 0, false, true
    rx_timer = setInterval ->
      # TODO receive is underfined
      #receive m
      return
    , 250
    # call reset first
    #@reset()
    @

  ###*
   * [reset description]
   * @return {[type]} [description]
  ###
  reset:->
    if @opt.dev is 'NiceRF'
      # tx rx disable
      ['tx_en', 'rx_en' ].forEach (n)=> @[n] =  gpio @opt[n],  mraa.DIR_OUT, 0
      Bus.emit 'Logger', '-> NiceRF TX and RX disabled'
    # reset
    resetModule @opt.reset, ->
      Bus.emit 'Logger', '-> Transceiver RESET: Success'
    @

  ###*
   * [receive description]
   * @return {[type]} [description]
  ###
  receive:(m)->
    console.log m
    @

  send:(req)->
    @
