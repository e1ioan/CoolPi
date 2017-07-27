#!/bin/bash

temp_db="/home/pi/data/cpu_db.rrd"

/usr/bin/rrdtool graph /home/pi/www/image/cpu.png --slope-mode --full-size-mode --right-axis 1:0 \
	--x-grid MINUTE:1:MINUTE:10:MINUTE:10:0:%H:%M --width 900 --height 400  -s 'now - 1 hours' -e 'now' \
	DEF:TEMP=$temp_db:temp:MAX \
	DEF:CPU=$temp_db:cpu:MAX \
	LINE2:TEMP#0000FF:"CPU Temperature" \
	LINE2:CPU#FF0000:"Load Average"

