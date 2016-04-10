'use restrict'
mraa  = require 'mraa'
debug = true
module.exports =
  ###*
   * [open description]
   * @param  {[type]} config [description]
   * @return {[type]}        [description]
  ###
  info:(@opt) ->
    if !@opt.board_info
      return @
    debug = @opt.debug
    if @opt.debug
      mraa.setLogLevel(7)
    console.log '-------------------------------------------------'
    console.log 'hw: MRAA Version  : ' + mraa.getVersion()
    console.log 'hw: Board name    : ' + mraa.getPlatformName()
    console.log 'hw: Platform type : ' + mraa.getPlatformType()
    #console.log 'hw: Pin count     : ' + mraa.getPinCount()
    console.log 'hw: I2C bus count : ' + mraa.getI2cBusCount()
    console.log '-------------------------------------------------'

    pins = @opt.RF_frontend
    pins.forEach (p,i) ->
      console.log 'RF frontend ' + i + ' pinmaps'
      try
        console.log 'hw: RESET         : ' + mraa.getPinName p.reset
      catch e
        console.log "hw: RESET: can't be used. Please, remap pin: " + p.reset
      try
        console.log 'hw: SPI CS        : ' + mraa.getPinName p.spi_cs
      catch e
        console.log "hw: SPI CS: can't be used. Please, remap pin: " + p.chip_sel
      try
        console.log 'hw: DIO0          : ' + mraa.getPinName p.dio0
      catch e
        console.log "hw: DIO0: can't be used. Please, remap pin: " + p.dio0
      if p.brand == 'NiceRF'
        try
          console.log 'hw: TX_EN         : ' + mraa.getPinName p.tx_en
        catch e
          console.log "hw: TX_EN can't be used. Please, remap pin: " + p.tx_en
        try
          console.log 'hw: RX_EN         : ' + mraa.getPinName p.rx_en
        catch e
          console.log "hw: RX_EN can't be used. Please, remap pin: " + p.rx_en
    console.log '-------------------------------------------------'
    console.log 'SPI bus mapping for this board:'
    p = 0
    while p < mraa.getPinCount()
      try
        pName = mraa.getPinName p
        if /SPI/i.test(pName)
          console.log "hw: pin: " + pName + " " + p
      catch e
      p++
    console.log '-------------------------------------------------'
    @


