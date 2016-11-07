from flask import Flask, request
import RPi.GPIO as GPIO  
import time  
import json

GPIO.setmode(GPIO.BCM)  
led_pin = 17
GPIO.setup(led_pin, GPIO.OUT)

app = Flask(__name__)
ring_count = 0

sleep_time = 0.4

@app.route('/', methods=['GET'])
def index():
    global ring_count
    ring_count = ring_count + 1
    GPIO.output(led_pin, GPIO.HIGH)
    time.sleep(sleep_time)
    GPIO.output(led_pin, GPIO.LOW)

    time.sleep(sleep_time)

    return json.dumps({"doorbell_rings": str(ring_count)})

if __name__ == '__main__':
    app.run(debug=True, host='0.0.0.0')

