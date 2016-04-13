# @authors:
#    Victor Brutskiy <4refr0nt@gmail.com>
#    Alex   Suslov   <suslov@me.com>
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
sx1276       = require 'jsupm_sx1276'

Bus = new EventEmitter()

# module vars
m        = null # TODO m[2?]
rx_timer = null

debug    = true
Lock     = false

# default RX config
rxCfg =
  modem        : sx1276.SX1276.MODEM_LORA,
  bandwidth    : 125000, # for LoRa available values: [125 kHz, 250 kHz, 500 kHz] * 1000
  datarate     : 7,      # for LoRa available values: [6: 64, 7: 128, 8: 256, 9: 512, 10: 1024, 11: 2048, 12: 4096 chips]
  coderate     : 1,      # for LoRa available values: [1: 4/5, 2: 4/6, 3: 4/7, 4: 4/8]
  bandwidthAfc : 0,      # for LoRa always zero
  preambleLen  : 8,      # for LoRa: Length in symbols (the hardware adds 4 more symbols)
  symbTimeout  : 5,      # for LoRa: timeout in symbols
  fixLen       : false,  # Fixed length packets [false: variable, true: fixed]
  payloadLen   : 0,      # Sets payload length when fixed lenght is used or 0 for variable packets length
  crcOn        : true,   # Enables/Disables the CRC [false: OFF, true: ON]
  freqHopOn    : false,  # Freq hop not yet supported
  hopPeriod    : 0,      # Freq hop not yet supported
  iqInverted   : false,  # for LoRa: [false: not inverted, true: inverted]
  rxContinuous : true    # Sets the reception in continuous mode [false: single mode, true: continuous mode]

module.exports =
  # event bus
  # https://nodejs.org/api/events.html
  Bus: Bus
  # events
  events:->
    Bus.on 'Open', @open
    Bus.on 'RX', @receive
    @

  receive: ->
    console.log 'rf: timer: receive'
    setTimeout @receive, 250
    @

  send: (req)->
    @

  ###*
   * [open description]
   * @param  {[type]} config [description]
   * @return {[type]}        [description]
  ###
  open: (@opt) ->
    Bus.emit 'Logger', 'rf: modem open...' # TODO - not working
    console.log 'rf: modem open...'
    @events()
    debug = @opt.debug
    #console.log @opt
    rf = @opt.RF_frontend[0] # TODO several RF frontend
    #console.log  rf.spi_bus, rf.spi_cs, rf.reset, rf.tx_en, rf.rx_en, rf.dio0
    try
      m = new sx1276.SX1276 0x12, 0, 24, 11, 16, 13, 15, 29, 31, 33
    catch e
      console.log e
      process.exit 0
    console.log 'rf: new ok'
    #Bus.emit 'Logger', 'rf: detected chip version: ' + m.getChipVersion()

    if m.getChipVersion() == 0x12
      console.log 'rf: detected chip SX1276'
    else if m.getChipVersion() == 0x22
      console.log 'rf: detected known SX1272 chip, but not supported, exiting...'
      process.exit 0
    else
      console.log 'rf: detected unknown unsupported device, exiting...'
      process.exit 0

    m.setChannel 868100000 # 868.1 MHz
    console.log 'rf: setChannel ok'

    m.setRxConfig rxCfg.modem, rxCfg.bandwidth, rxCfg.datarate, rxCfg.coderate, rxCfg.bandwidthAfc, rxCfg.preambleLen, rxCfg.symbTimeout, rxCfg.fixLen, rxCfg.payloadLen, rxCfg.crcOn, rxCfg.freqHopOn, rxCfg.hopPeriod, rxCfg.iqInverted, rxCfg.rxContinuous
    console.log 'rf: setRxConfig ok'

    Bus.emit 'RX', 'rf: done.'
    @
