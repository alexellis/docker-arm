import RPi.GPIO as GPIO  
import time  
GPIO.setmode(GPIO.BCM)  
led_pin = 17
GPIO.setup(led_pin, GPIO.OUT)

while(True):  
    GPIO.output(led_pin, GPIO.HIGH)
    print("1")
    time.sleep(1)
    GPIO.output(led_pin, GPIO.LOW)
    print "0"
    time.sleep(1)

