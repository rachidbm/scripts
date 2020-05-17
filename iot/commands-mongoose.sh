
## Build firmware
mos build --platform esp32

## Build locally (in Docker container)
mos build --local --platform esp32
# mos build --local --repo . --platform esp32

## Build with specific Docker image
mos build --local --platform esp32 --build-image mgos/esp32-build:3.3-r3


## install mongoose on ESP
mos flash esp32

# mos flash esp32  --firmware ./build/fw.zip 		##  This is default

## Erase the chip before flashing




## Copy script 
mos put init.js

## Configure wifi
mos wifi  YOUR_WIFI_SSID  YOUR_WIFI_PASSWORD

## General change configuration
mos config-get
mos config-get wifi
mos config-set wifi.sta.enable=false

## Disable wifi and bluetooth
mos config-set wifi.sta.enable=false
mos config-set bt.enable=false
mos config-set mqtt.enable=false


## Enable debug logging
mos config-get debug

mos config-set debug.level=2

##  The default level is 2.  Level -1 means no log. Level 
##  0 is ERROR, 
##  1 is WARN, 
##  2 is INFO, 
##  3 is DEBUG, 
##  4 is VERBOSE_DEBUG. Level 4 means log everything possible, it is very verbose. Start with increasing to level 3.



## Other commands
mos ls


## Configure AWS
mos aws-iot-setup --aws-iot-policy=mos-default

See also: 
https://github.com/mongoose-os-apps/aws-iot-heater


# Note: ADC2 pins cannot be used when Wi-Fi is used. So, if you’re using Wi-Fi and you’re having trouble getting the value from an ADC2 GPIO, you may consider using an ADC1 GPIO instead, that should solve your problem. 


####################################
##     Other commands
####################################


## Debuggin the ESP32 'hardware'
esptool.py read_flash_status --bytes 2


## Erase the entire flash chip
esptool.py erase_flash

## Other serial monitor, shipped with esptool.py
miniterm.py /dev/cu.SLAB_USBtoUART 115200

