#!/bin/sh

HOST=i686-w64-mingw32
#HOST=x86_64-w64-mingw32

docker build -t netsurf/sdk sdk
docker build -t netsurf/$HOST $HOST

# To build NetSurf from the netsurf-all repository:
# docker run -v $(pwd):/opt/netsurf/src -w /opt/netsurf/src -it netsurf/$HOST make HOST=$HOST TARGET=$TARGET $@
