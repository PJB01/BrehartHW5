#!/bin/bash
# A small Bash script to set up User LED3 to be turned on or off from 
#  Linux console. Written by Derek Molloy (derekmolloy.ie) for the 
#  book Exploring BeagleBone.
#Modified by Phil Brehart
#Should be able to accept 2 command line arguments, "blink" and an integer n and blink every second.
#Blink amount is designated by n

LED3_PATH=/sys/class/leds/beaglebone:green:usr3

# Example bash function
function removeTrigger
{
  echo "none" >> "$LED3_PATH/trigger"
}

blink = $2
n = $3
counter = 0

echo "Starting the LED Bash Script"
if [ $# -eq 0 ]; then
  echo "There are no arguments. Usage is:"
  echo -e " bashLED Command \n  where command is one of "
  echo -e "   on, off, flash or status  \n e.g. bashLED on "
  exit 2
fi
echo "The LED Command that was passed is: $1"
if [ "$1" == "on" ]; then
  echo "Turning the LED on"
  removeTrigger
  echo "1" >> "$LED3_PATH/brightness"
elif [ "$1" == "off" ]; then
  echo "Turning the LED off"
  removeTrigger
  echo "0" >> "$LED3_PATH/brightness"
elif [ "$1" == "flash" ]; then
  echo "Flashing the LED"
  removeTrigger
  echo "timer" >> "$LED3_PATH/trigger"
  sleep 1
  echo "100" >> "$LED3_PATH/delay_off"
  echo "100" >> "$LED3_PATH/delay_on"
elif [ "$1" == "status" ]; then
  cat "$LED3_PATH/trigger";
elif [ "$1" == "blink" ]; then
  removeTrigger
  n=$(($2))
  while [ $n -gt 0 ]
    do
    echo "1" >> "$LED3_PATH/brightness"
    echo "timer" >> "$LED3_PATH/trigger"
    echo "1000" >> "$LED3_PATH/delay_off"
    echo "0" >> "$LED3_PATH/brightness"
    echo "100" >> "$LED3_PATH/delay_on"
    ((n--))
  done

fi

echo "End of the LED Bash Script"



