Minio on ARM
============

This Dockerfile builds a container to run Minio - an S3 compatible object storage server.

Use /objects/ to mount a volume and check docker logs for the access keys.


**Running the container:**

```
# docker run --name minio -p 9000:9000 -d alexellis2/minio-armhf:latest
# docker logs minio

```
