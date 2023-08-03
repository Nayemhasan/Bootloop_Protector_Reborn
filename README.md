# Bootloop Protector Reborn

## Why is this module?
This module protect's your system from bootloop caused by Magisk modules. In case the data partition is encrypted and you cannot access `/data/adb/modules`, or you don't want to turn off **force encryption** because when your phone with **force encryption** disabled is stolen, thief can copy your `/data` and your private data will be exposed!!! 

## Dependencies
Use the latest [Magisk](https://magiskmanager.com/) manager

## How to use?
<p align="left">
  <img src="https://img.shields.io/github/downloads/Nayemhasan/Bootloop_Protector_Reborn/total?style=social">
</p>

 - flash the latest [release](https://github.com/Nayemhasan/Bootloop_Protector_Reborn/releases)
 - reboot and profit*


## Usage

### Auto detect
Usually, bootloop occurs because zygote doesn't start properly or stuck at restarting. The script run in `late_start` mode. It will check Zygote's Process ID 3 times every 15 seconds.  And if Zygote's Process ID doesn't match for 3 times, check the Process ID for next 15 seconds to make sure and if it's different again, the script will disable all modules and reboot the your device.

### Disable from Custom Recovery
You can boot into **TWRP** and create a dummy file named `disable_magisk` in one of these location to tell the script disable all modules and reboot your device (if **Auto detect** is not working):
- /cache
- /data/unencrypted
- /metadata
- /persist
- /mnt/vendor/persist

## Bonus
How to create a file in TWRP? Open Terminal Emulator in TWRP and type:

```
touch /cache/disable_magisk
```

## Thank You🍉

