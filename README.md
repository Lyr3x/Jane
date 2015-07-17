#Jane

Jane is released in Version 1.2 - Captain America

INFO: Keep in mind that the wiki is outdated. The new documentation is under development!

##What is Jane?
- A system to control home devices e.g.: AVR, TV or other IR devices and computers via SSH
- Jane uses Tasker with AutoVoice to control the system with your voice

##What is working?
- Infrared control code receiving
- Sending commands via the WebUI, Tasker (+ AutoVoice)
- AndroidWear Voice command execution via AutoWear + AutoVoice withour root
- Sinatra Webserver + Caching
- Remote Control Outlets
- Sending commands via SSH
- Sunset -> automatic action at sunsettime
- Homecheck

###Addons
- SSH connection + command execution
- SunSet
- HomeCheck

##Requirements
- Raspberry PI + raspbian
- eurocard or plugboard
- 1x IR-Emitter - TSAL 6200
- 1x IR-Receiver - TSOP4838
- 1x 1 kOhm Resistor 
- 1x 100 Ohm Resistor
- 1x bipolar Transistor NPN - BC547C
- WiFi-stick recommended for more flexibility
- 433 Mhz sender

##Circuit plan

![Alt text](https://github.com/Lyr3x/Jane/blob/master/circuit/Circuit-plan_Steckplatine.png "Circuit Plan")

##Software installation
###LIRC
**Enter the following commands:**
- ```$ sudo apt-get install lirc```
- ```$ sudo vim /etc/modules```
- **Add the following lines:**
- ```lircv_dev```
- ```lirc_rpi gpio_in_pin=22 gpio_out_pin=23```

### With Kernel >= 3.18
**Add the following line into /boot/config.txt:**
- ```dtoverlay=lirc-rpi,gpio_in_pin=22,gpio_out_pin=23```
- After this reboot the Pi

### LIRC configuration 
- ```$ cd /etc/lirc/```
- ```$ sudo vim hardware.conf```
Enter/comment the following line: 
- ```LIRCD_ARGS="--listen"``` TCP Listener at Port 8765
- ```#START_LIRCMD=false```
- ```#START_IREXEC=false```
- ```LOAD_MODULES=true```
- ```DRIVER="default"```
- ```DEVICE="/dev/lirc0"```
- ```MODULES="lirc_rpi"```
Save and quit the file and execute the following
- ```$ sudo /etc/init.d/lirc restart```

##Read key codes

- The standard configuration file is located in ```/etc/lirc/lircd.conf```
- For the first tests, create the file ```~/led.conf```
- LIRC have a lot options for key bindings, to see the options execute:
- ```$ irrecord -list namespace```
- Notice the keys you need
- To test the receiver execute: ```$ sudo irrecord -d /dev/lirc0 ~/led.conf```
- All commands are stored in ~/led.conf now. Copy the whole content in ```/etc/lirc/lircd.conf```
- For each control you have to repeat this procedure

### Send commands

- First restart the lirc daemon ```sudo /etc/init.d/lirc restart```
- To send a command execute: ```$ irsend SEND_ONCE "name of the control" "key"```
- example: ```$ irsend SEND_ONCE TV KEY_POWER```

### Crontab
```
JANE_PATH=/path/to/jane/
# m h  dom mon dow   command
@reboot cd /home/jarvis/Jane/ && nohup ruby jane.rb &
@reboot /home/jarvis/jasper/jasper.py
@reboot gpio export 17 out
# Begin Whenever generated tasks for: /home/jarvis/Jane/config/schedule.rb
4 21 * * * cd /home/jarvis/Jane && RAILS_ENV=production bundle exec rake light_on --silent

0 1 * * * cd /home/jarvis/Jane && RAILS_ENV=production bundle exec rake update_cron --silent
```
### Android App
! No active development for now !
The Android app is located in a seperate repostiroy:
- [Jane-app](https://github.com/Lyr3x/Jane-app)
- 
### Coming Features
- new webinterface, with create config function
- automatic cache deletes when there are some changes
- Android app which uses the jane config


## License
see [LICENSE](https://github.com/Lyr3x/Jarvis/blob/master/LICENSE) files
