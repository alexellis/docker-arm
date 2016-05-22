### Dockerfile for unicorn HAT and pHAT from Pimoroni

#### Building

```
./build.sh
```

#### Running

```
docker run -d --privileged alexellis2/unicorn-hat
```

This will start up the phat rainbow example, but if you use `FROM alexellis2/unicorn-hat` you can alter the example to one of the others available.

[Live video](https://vine.co/v/iETMIpKgugt)

#### See also:

[Pimoroni/explorerhat code](https://github.com/pimoroni/unicorn-hat)
