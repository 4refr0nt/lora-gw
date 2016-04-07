# LoRa Gateway
For Raspberry Pi

## Networks support
TTN - TheThingsNetwork(http://thethingsnetwork.org/)

## Device support
NiceRF LoRa1276, HopeRF SX1276-based modules

## Install
1. Install MRAA library
```
sudo apt-get update
sudo apt-get install libpcre3 python-dev swig3.0 cmake 
cd ~
git clone https://github.com/intel-iot-devkit/mraa.git
cd mraa/src/spi
```
Comment out the following from /src/spi/spi.c
// if (ioctl(dev->devfd, SPI_IOC_RD_MAX_SPEED_HZ, &speed) != -1) {
// if (speed < hz) {
// dev->clock = speed;
// syslog(LOG_WARNING, "spi: Selected speed reduced to max allowed speed");
// }
```
cd ..\..
md build
cd build
cmake .. -DBUILDSWIGNODE=ON -DBUILDSWIGPYTHON=OFF
make install
```
2. LoRa Gateway
```
cd ~
git clone https://github.com/
cd lora-gw
npm i
```
Ignore all errors, but check for exist node_modules/mraa/build/Release/mraa.node
