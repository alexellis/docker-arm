#!/bin/bash

# A build-step in the Dockerfile prepares the swarm binary at /go/bin
# We mount a volume from the host to /tmp/binary so that we can copy
# the binary out of the container.

cp /go/bin/swarm /tmp/binary/
