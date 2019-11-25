
## Build firmware
mos build --platform esp32

## install mongoose on ESP
mos flash esp32

## Copy script 
mos put init.js

## Configure wifi
mos wifi  YOUR_WIFI_SSID  YOUR_WIFI_PASSWORD

## Configure AWS
mos aws-iot-setup --aws-iot-policy=mos-default

See also: 
https://github.com/mongoose-os-apps/aws-iot-heater


