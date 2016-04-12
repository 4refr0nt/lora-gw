```
 _           _____        _____       _
| |         |  __ \      / ____|     | |
| |     ___ | |__) |__ _| |  __  __ _| |_ _____      ____ _ _   _
| |    / _ \|  _  // _` | | |_ |/ _` | __/ _ \ \ /\ / / _` | | | |
| |___| (_) | | \ \ (_| | |__| | (_| | ||  __/\ V  V / (_| | |_| |
|______\___/|_|  \_\__,_|\_____|\__,_|\__\___| \_/\_/ \__,_|\__, |
                                                             __/ |
(c) 2016 4refr0nt                                           |___/
```

# LoRa Gateway
Node.js LoRa Gateway For Raspberry Pi

## 1. Supported LoRaWAN Networks
[The Things Network](http://thethingsnetwork.org/)

## 2. Supported devices
* List of [supported board](https://github.com/intel-iot-devkit/mraa#supported-boards)
* Supported transceivers (without MCU): NiceRF LoRa1276, HopeRF SX1276-based modules
* I2C LCD SSD1306-based

## 3. Features
* multiplatforms
* objects-based model
* coffee-script fast and easy developing
* 2 UDP servers supporting (main and debug)
* MQTT monitoring server supporting
* unlimited RF frontend devices supported
* display statistics on I2C LCD
* receiving unconfirmed messages from nodes
* periodically send statistics info to servers

## 4. TODO
* receiving messages from nodes with confirmation
* mobile app for monitoring

## 5. Pre-Requirements & Build on Raspberri Pi
* 5.1 Dependencies
```
sudo apt-get update
sudo apt-get -y install build-essential
sudo apt-get -y install libpcre3 libpcre3-dev cmake autotools-dev nodejs-dev automake python-dev bison
cd ~
mkdir -p src
```
* 5.2 Install latest SWIG from source code
```
cd ~/src
git clone https://github.com/swig/swig.git
cd swig
./autogen.sh
./configure
make
sudo make install
```
* 5.3 Build hardware level MRAA library from source code
```
cd ~
git clone https://github.com/intel-iot-devkit/mraa.git
cd mraa/src/spi
```

for Raspberri Pi comment out the following from /src/spi/spi.c
* // if (ioctl(dev->devfd, SPI_IOC_RD_MAX_SPEED_HZ, &speed) != -1) {
* // if (speed < hz) {
* // dev->clock = speed;
* // syslog(LOG_WARNING, "spi: Selected speed reduced to max allowed speed");
* // }
```
cd ~/mraa
md build
cd build
cmake .. -DBUILDSWIGNODE=ON
make install
```
* 5.4 Build UPM library from source code (build may be more than 1 hrs)
```
cd ~
git clone https://github.com/intel-iot-devkit/upm.git
cd upm
md build
cd build
cmake .. -DCMAKE_CXX_FLAGS::STRING=-march=native -DCMAKE_C_FLAGS:STRING=-march=native
make install
```
## 6. Install
```
cd ~
git clone https://github.com/4refr0nt/lora-gw.git
cd lora-gw
npm i
```
Ignore all errors, but check for existing file node_modules/mraa/build/Release/mraa.node
## 7. Config
```
cd ~/lora-gw
cp ./config-distr.js ./config.js
```
Edit config.js and check settings
## 8. Run
```
node index.js
```
## 9. Connections
See [MRAA pin numbers for Raspberri Pi](http://iotdk.intel.com/docs/master/mraa/rasppi.html)

Raspberry Pi | Transceiver
| :---:| :---: | :---: |
MOSI | 19 | MOSI
MISO | 21 | MISO
CLK  | 23 | SCK
CS0  | 24 | NSS
