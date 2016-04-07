// modems
"use restrict";
module.exports = {}

var reset = function(n) {
  if (dev == 1) {  // NiceRF
    var tx = new mraa.Gpio(tx_en);
    tx.dir(mraa.DIR_OUT);
    tx.write(tx_en, 0);

    var rx = new mraa.Gpio(rx_en);
    rx.dir(mraa.DIR_OUT);
    rx.write(rx_en, 0);
  }

}
var init = function(n) {
        console.log('LoRa Gateway Version: ' + version + ' started.');
        console.log('MRAA Version: ' + mraa.getVersion());
}
