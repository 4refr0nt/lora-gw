﻿# @authors:
#    Victor Brutskiy <4refr0nt@gmail.com>
#    Alex   Suslov   <alexsuslov@me.com>
#    Copyright (c) 2016
#
# @license: MIT
#
# M""MMMMMMMM MM'""""'YMM M""""""'YMM
# M  MMMMMMMM M' .mmm. `M M  mmmm. `M
# M  MMMMMMMM M  MMMMMooM M  MMMMM  M
# M  MMMMMMMM M  MMMMMMMM M  MMMMM  M
# M  MMMMMMMM M. `MMM' .M M  MMMM' .M
# M         M MM.     .dM M       .MM
# MMMMMMMMMMM MMMMMMMMMMM MMMMMMMMMMM
#
'use restrict'
EventEmitter = require 'events'
lcdObj       = require 'jsupm_i2clcd'
img          = require './images/image'

# module vars
lcd        = null
lcd_enable = false;

debug      = true

Bus = new EventEmitter()

module.exports =
  # event bus
  # https://nodejs.org/api/events.html
  Bus: Bus
  # events
  events:->
    Bus.on 'Open',     @open
    Bus.on 'Enable',   @enable
    Bus.on 'Disable',  @disable
    Bus.on 'DrawLogo', @drawLogo
    Bus.on 'Draw'    , @draw
    @

  ###*
   * [open description]
   * @param  {[type]} config [description]
   * @return {[type]}        [description]
  ###
  open:(@opt) ->
    if !@opt.lcd.enabled
      return
    @events()
    # TODO: Logger event on mainBus
    console.log 'LCD: Init...'
    debug = @opt.debug
    lcd_enabled = false
    try
      lcd_enabled = @opt.lcd.enabled
    catch e
      Bus.emit 'Disable'
    if lcd_enabled
      Bus.emit 'Enable'
    else
      Bus.emit 'Disable'
    @

  ###*
   * [enable description]
   * @param  {[type]} config [description]
   * @return {[type]}        [description]
  ###
  enable:->
    console.log 'LCD: Enabled'
    lcd_enabled = true
    # TODO: resolve @opt.lcd undefined
    #if @opt.lcd.type == 'I2C_LCD_SSD1306'
    if true
      console.log 'LCD: Set driver to SSD1306'
      try
        #lcd = new lcdObj.SSD1306 @opt.lcd.i2c_bus, @opt.lcd.i2c_addr
        lcd = new lcdObj.SSD1306 0, 0x3c
      catch e
        console.log e
        Bus.emit 'Disable'
    else
      console.log 'LCD: Unknown LCD type ' + @opt.lcd.type + ' in config!'
      Bus.emit 'Disable'
    # TODO: resolve isLCD undefined
    #if isLCD()
    if true
      Bus.emit 'DrawLogo'
      setTimeout ->
        Bus.emit 'Draw'
      , 2000 # 2s
    @

  ###*
   * [disable description]
   * @param  {[type]} config [description]
   * @return {[type]}        [description]
  ###
  disable:->
    console.log 'LCD: Disabled'
    lcd_enabled = false
    @

  ###*
   * [isLCD description]
   * @param  {[type]} config [description]
   * @return {[type]}        [description]
  ###
  isLCD:->
    # TODO check returned value
    lcd_enabled

  ###*
   * [drawLogo description]
   * @param  {[type]} config [description]
   * @return {[type]}        [description]
  ###
  drawLogo:->
    # TODO lora logo from lora-alliance.com. See: lib/images
    logo = new lcdObj.uint8Array img.logo_img.length
    x = 0
    while x < img.logo_img.length
      logo.setitem x, img.logo_img[x]
      x++
    lcd.stopscroll()
    lcd.clear()
    lcd.draw logo, 1024
    @

  ###*
   * [draw description]
   * @param  {[type]} config [description]
   * @return {[type]}        [description]
  ###
  draw:->
    # TODO LCD data design
    lcd.stopscroll()
    lcd.clear();
    lcd.setCursor(0, 0);
    lcd.write("Hello,");
    lcd.setCursor(1,0);
    lcd.write("World!");
    @

