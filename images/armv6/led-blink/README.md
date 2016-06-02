## Raspberry PI LED-Blink using GPIO

### Building 

By default this container will toggle and LED on GPIO pin 4. If you want to alter the pin number then edit `run.sh`.

Now build the image:

```
$ ./build.sh
```

### Running the image:

Make sure your LED is connected to the correct GPIO pin with the correct resistor.

```
$ ./start.sh
```


