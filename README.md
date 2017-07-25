# Cool your Raspberry Pi only if is needed.

As you probably know, if you just connect a little fan to 5V and GND pins on your Raspberry Pi, the fan is always going to run full speed
and sometime it will make noise.

If you are looking for a simple solution to controll the fan speed and run the fan just when the Pi gets too hot, I have a solution for you. First of all, you need a NPN transistor and a 1K resistor. Connect your fan to the Raspberry Pi following the schematic bellow (VCC goes to 5V on the Pi, GND to GND on the Pi and the GPIO 26 to GPIO 26 on the Pi.

![Picture](https://raw.githubusercontent.com/e1ioan/CoolPi/master/npn.png "The picure should be here")

After you connected everyting copy ```coolPi.sh``` somewhere on your Raspbery Pi (in this example it will be in ```/home/pi/scripts/coolPi.sh```) and make it executable ```chmod +x /home/pi/scripts/coolPi.sh```

Now, make the script start at boot by running the command:
```crontab -e```

and adding at the bottom of the file:
```@reboot /home/pi/scripts/coolPi.sh```

Reboot your Pi ```sudo reboot``` and you are done!
