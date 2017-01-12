Minio on ARM
============

Minio is an S3 compatible object storage server written in Go. You can store anything you want and it even runs on the Raspberry Pi. I've built a special Dockerfile to enable Docker to bring [Minio](https://minio.io) to the Pi and ARM devices.

**Running the container:**

```
# docker run --name minio -p 9000:9000 -d alexellis2/minio-armhf:latest
# docker logs minio
```

By default objects are stored at /objects/ and you can also use this as a volume. If you want to change the location, edit the Dockerfile.

Remember to use the IP address of the Raspberry Pi, not the Docker container when you use the `mc` Minio Client tool to connect and upload / query files/objects. `docker logs minio` will show you the access key you need to type in on your client.

> Get started on the [Minio website now](https://minio.io).

**Not got Docker on your Pi yet?**

Type in `curl -sSL get.docker.com | sh` and you'll be there in no time. 

![](https://pbs.twimg.com/media/C17cDK4XcAAKLok.png:large)

*My Mac Mini uploading my source-code to my Pi 3*
