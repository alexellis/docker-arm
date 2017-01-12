Minio on ARM
============

This Dockerfile builds a container to run Minio - an S3 compatible object storage server.

Use /objects/ to mount a volume and check docker logs for the access keys.


**Running the container:**

```
# docker run --name minio -p 9000:9000 -d alexellis2/minio-armhf:latest
# docker logs minio
```

Remember to use the IP address of the Raspberry Pi, not the Docker container when you use the `mc` Minio Client tool to connect and upload / query files/objects.

![](https://ton.twitter.com/i/ton/data/dm/819333329728184324/819333280529022977/lU_Bxj5w.png)

*My Mac Mini uploading my source-code to my Pi 3*
