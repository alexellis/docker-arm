Minio on ARM
============

This Dockerfile builds a container to run [Minio](https://minio.io) - an S3 compatible object storage server.

Use /objects/ to mount a volume and check docker logs for the access keys.


**Running the container:**

```
# docker run --name minio -p 9000:9000 -d alexellis2/minio-armhf:latest
# docker logs minio
```

Remember to use the IP address of the Raspberry Pi, not the Docker container when you use the `mc` Minio Client tool to connect and upload / query files/objects. Get started on the [Minio website now](https://minio.io).

**Not got Docker on your Pi yet?**

Type in `curl -sSL get.docker.com | sh` and you'll be there in no time. 

![](https://pbs.twimg.com/media/C17cDK4XcAAKLok.png:large)

*My Mac Mini uploading my source-code to my Pi 3*
