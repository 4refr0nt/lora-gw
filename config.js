/*
 *  ######   #######  ##    ## ######## ####  ######
 * ##    ## ##     ## ###   ## ##        ##  ##    ##
 * ##       ##     ## ####  ## ##        ##  ##
 * ##       ##     ## ## ## ## ######    ##  ##   ####
 * ##       ##     ## ##  #### ##        ##  ##    ##
 * ##    ## ##     ## ##   ### ##        ##  ##    ##
 *  ######   #######  ##    ## ##       ####  ######
 *
 * User defined section
 */

module.exports = {
  host : 'croft.thethings.girovito.nl',
  port : 1700,
  // dev: 1 - NiceRF, 2 - HopeRF
  dev  : 1,             
  // lcd: 1 - i2c, 0 - no LCD
  lcd  : 1, 
  freq : 868.1,
  // gwID will be added to MAC address
  gwID : 0x0001,
  // RX_EN and TX_EN pins used only for NiceRF
  tx   : 2, // GPIO2 IO27
  rx   : 3  // GPIO3 IO22
}
