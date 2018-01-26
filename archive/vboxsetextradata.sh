#! /bin/bash
VM_NAME="WinXP" # Name of your Virtual Machine
VSETED="VBoxManage setextradata $VM_NAME"
CFG_PATH="VBoxInternal/Devices/pcbios/0/Config"
$VSETED $CFG_PATH/DmiBIOSVendor       "Dell Inc."
$VSETED $CFG_PATH/DmiBIOSVersion      "A00"
$VSETED $CFG_PATH/DmiBIOSReleaseDate  "09/26/2008"
$VSETED $CFG_PATH/DmiBIOSReleaseMajor  2
$VSETED $CFG_PATH/DmiBIOSReleaseMinor  5
$VSETED $CFG_PATH/DmiBIOSFirmwareMajor 2
$VSETED $CFG_PATH/DmiBIOSFirmwareMinor 5
$VSETED $CFG_PATH/DmiSystemVendor     "Dell Inc."
$VSETED $CFG_PATH/DmiSystemProduct    "OptiPlex 760"
#$VSETED $CFG_PATH/DmiSystemVersion    "<EMPTY>"
$VSETED $CFG_PATH/DmiSystemSerial     "HWY264J"
$VSETED $CFG_PATH/DmiSystemUuid       "44454C4C-5700-1059-8032-C8C04F36344A"
#$VSETED $CFG_PATH/DmiSystemFamily     "<EMPTY>"
