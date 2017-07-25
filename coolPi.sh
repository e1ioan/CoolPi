#!/bin/bash

# Get a Pi cooling fan, 5V - 200mA and follow the schematic from here:
# https://github.com/e1ioan/CoolPi


#https://www.quora.com/How-can-we-control-the-speed-of-the-fan-using-Raspberry-pi-2
#To generate a hardware pwm

#pwmFrequency in Hz = 19.2e6 Hz / pwmClock / pwmRange

#To generate a 50 hz signal
#50 Hz = 19.2e6 Hz / 1920 / 200

GPIO_PWM=26

#set gpio 26 as pwm
gpio mode $GPIO_PWM pwm  
gpio pwm-ms
#pwm clock
gpio pwmc 1920
#pwm range
gpio pwmr 200
# generate pwm on gpio 26 of 1/4 th duty cycle cause 50/200=1/4
# gpio pwm 26 50

# CPU temperature lower than 80'C? keep the fan off
# CPU temperature between 80'C and 100'C? run the fan at 50% speed
# CPU temperature bigger than 100'C? run fan at full speed

while true
do
	temp=$(cat /sys/class/thermal/thermal_zone0/temp)
	cpuTemp=$(($temp/1000))
	if [[ $cpuTemp -lt 80 ]]; then
		# stop fan
		gpio pwm $GPIO_PWM 0
	elif [ $cpuTemp -ge 80 ] && [ $cpuTemp -lt 100 ]; then
		# fan at 50% speed
		gpio pwm $GPIO_PWM 100
	elif [[ $cpuTemp -ge 100 ]]; then
		# fan at full speed
        	gpio pwm $GPIO_PWM 200
	fi
	# wait 10 seconds
	sleep 10
done
