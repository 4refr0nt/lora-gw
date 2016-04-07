#!/usr/bin/env node
/*
 * Author: Victor Brutskiy <4refr0nt@gmail.com>
 * Copyright (c) 2016
 *
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
////////////////////////////////////////////////
var config = require("./config");
var host = config.host;
var port = config.port;
var dev  = config.dev;
var lcd  = config.lcd;
var freq = config.freq;
var gwID = config.gwID;
var rx_en= config.rx;
var tx_en= config.tx;
////////////////////////////////////////////////

var mraa = require('mraa');
var version = "0.1.0";

var t = Object.create(null)

t.reset = function(n) {
  if (dev == 1) {  // NiceRF
    var tx = new mraa.Gpio(tx_en);
    tx.dir(mraa.DIR_OUT);
    tx.write(tx_en, 0);

    var rx = new mraa.Gpio(rx_en);
    rx.dir(mraa.DIR_OUT);
    rx.write(rx_en, 0);
  }
    
}
t.init = function(n) {
        console.log('LoRa Gateway Version: ' + version + ' started.');
        console.log('MRAA Version: ' + mraa.getVersion());
}


/*
x = new mraa.Spi(0)
buf = new Buffer(4)
buf[0] = 0xf4
buf[1] = 0x2e
buf[2] = 0x3e
buf[3] = 0x4e
buf2 = x.write(buf)
console.log("Sent: " + buf.toString('hex') + ". Received: " + buf2.toString('hex'))
*/

t.reset();      // reset RF module
t.init();       // initialize RF module
