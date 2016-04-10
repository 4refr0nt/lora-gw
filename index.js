/*
 * @authors:
 *    Victor Brutskiy <4refr0nt@gmail.com>
 *    Alex   Suslov   <AlexSuslov@me.com>
 *    Copyright (c) 2016
 *
 * @license: MIT
 * _           _____    __          __     _   _             _
 *| |         |  __ \   \ \        / /\   | \ | |           | |
 *| |     ___ | |__) |__ \ \  /\  / /  \  |  \| |   __ _  __ _| |_ _____      ____ _ _   _
 *| |    / _ \|  _  // _` \ \/  \/ / /\ \ | . ` |  / _` |/ _` | __/ _ \ \ /\ / / _` | | | |
 *| |___| (_) | | \ \ (_| |\  /\  / ____ \| |\  | | (_| | (_| | ||  __/\ V  V / (_| | |_| |
 *|______\___/|_|  \_\__,_| \/  \/_/    \_\_| \_|  \__, |\__,_|\__\___| \_/\_/ \__,_|\__, |
 *                                                  __/ |                             __/ |
 *                                                 |___/                             |___/
 * Permission is hereby granted, free of charge, to any person obtaining
 * a copy of this software and associated documentation files (the
 * "Software"), to deal in the Software without restriction, including
 * without limitation the rights to use, copy, modify, merge, publish,
 * distribute, sublicense, and/or sell copies of the Software, and to
 * permit persons to whom the Software is furnished to do so, subject to
 * the following conditions:
 *
 * The above copyright notice and this permission notice shall be
 * included in all copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
 * EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
 * MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
 * NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE
 * LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION
 * OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION
 * WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
 */
"use restrict";
////////////////////////////////////////////////
CoffeeScript     = require("coffee-script");
CoffeeScript.register();
var EventEmitter = require('events')
var config       = require("./config");
var hardware     = require('./lib/hardware');
var modem        = require('./lib/modem');
var lcd          = require('./lib/lcd');

// TODO 'net' module for UDP send to NetworkServer and DebugServer
// TODO 'mqtt' module for send to monitoring MQTTserver
// TODO index.js -> index.coffee + gulp tasks

mainBus = new EventEmitter()

var version           = "0.1.0";
var debug             = config.debug;

function events () {
  mainBus.on ('Logger', function(msg, always){
    always = typeof always !== 'undefined' ? always : false;
    if (always) console.log('');
    if (debug || always) console.log( msg );
  });

  mainBus.on ('Exit', function(msg){
    mainBus.emit('Logger', msg, true)
    // TODO destroy
    process.exit(0);
  });

  modem.Bus.on ('Resets', function(){
    console.log ('-> Transceiver RESETs');
  });
}
process.on('SIGINT', function() {
  /*
    TODO: 'destroy' and cb 'destroyed' events for lcd and modem
    lcd = null;
    lcdObj.cleanUp();
    lcdObj = null;
    console.log("Exiting...");
    */
  process.exit(0); // TODO move to last 'destroyed' cb
});

function check_config (cfg) {
  // TODO more checks
  if (!cfg) {
    mainBus.emit('Exit','Config data not found in config.js. Exiting...', true)
  }
  var RF_frontend_count = 0;
  config.RF_frontend.forEach( function(element) {
    if (element.enabled)
      if (element.type == 'SPI_SX1276')
        if (element.brand == 'NiceRF' || element.brand == 'HopeRF')
          ++RF_frontend_count;
        else
          mainBus.emit('Exit','Unknown RF frontend brand ' + element.brand + ' in config.js. Exiting...', true)
      else
        mainBus.emit('Exit','Unknown RF frontend type ' + element.type + ' in config.js. Exiting...', true)
  })
  if (RF_frontend_count == 0) {
    mainBus.emit('Exit','No configured RF frontend device found in config.js. Exiting...', true)
  }
}
function main () {

  events();

  mainBus.emit('Logger','LoRa Gateway Version: ' + version + ' started.', true)

  check_config(config);        // check config

  hardware.info(config);       // get board info
  lcd.open(config);            // initialize LCD module
  modem.open(config);          // initialize RF  module
}

main(); // entry point

//var myDigitalPin = new mraa.Gpio(11); //setup digital read on pin 6
//myDigitalPin.dir(mraa.DIR_IN); //set the gpio direction to input

// x = new mraa.Spi(0)
// buf = new Buffer(4)
// buf[0] = 0xf4
// buf[1] = 0x2e
// buf[2] = 0x3e
// buf[3] = 0x4e
// buf2 = x.write(buf)
// console.log("Sent: " + buf.toString('hex') + ". Received: " + buf2.toString('hex'))

/*
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


*/
