/*
 * Author: Victor Brutskiy <4refr0nt@gmail.com>
 * Copyright (c) 2016
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
CoffeeScript = require("coffee-script");
CoffeeScript.register();
// var mraa     = require("mraa");
var debug = true;
var config   = require("./config");
var modem    = require('./lib/modem');

var version = "0.1.0";

console.log('LoRa Gateway Version: ' + version + ' started.');

modem.Bus.on ('Logger', function(msg){
  if (debug) console.log( msg );
});
modem.Bus.on ('Resets', function(){
  console.log ('-> Transceiver RESETs');
});

modem.init(config);       // initialize RF module


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

