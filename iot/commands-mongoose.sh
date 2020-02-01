
## Build firmware
mos build --platform esp32

## install mongoose on ESP
mos flash esp32

## Copy script 
mos put init.js

## Configure wifi
mos wifi  YOUR_WIFI_SSID  YOUR_WIFI_PASSWORD

## General change configuration
mos config-get
mos config-get wifi
mos config-set wifi.sta.enable=true
mos config-set wifi.sta.enable=false


## Other commands
mos ls


## Configure AWS
mos aws-iot-setup --aws-iot-policy=mos-default

See also: 
https://github.com/mongoose-os-apps/aws-iot-heater


# Note: ADC2 pins cannot be used when Wi-Fi is used. So, if you’re using Wi-Fi and you’re having trouble getting the value from an ADC2 GPIO, you may consider using an ADC1 GPIO instead, that should solve your problem. 