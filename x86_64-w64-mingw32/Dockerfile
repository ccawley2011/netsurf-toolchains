FROM netsurf/sdk AS sdk

FROM alpine:3.16

# Only add packages needed by the cross-compiler here, to avoid invalidating later layers.
RUN apk add --no-cache gcc g++ make bison flex texinfo zlib-dev wget ca-certificates patch

ENV TOOLCHAIN=x86_64-w64-mingw32

COPY Makefile /opt/netsurf/docker-build/${TOOLCHAIN}/

RUN make -C /opt/netsurf/docker-build/${TOOLCHAIN} && \
    rm -rf /opt/netsurf/docker-build

ENV GCCSDK_INSTALL_CROSSBIN=/opt/netsurf/${TOOLCHAIN}/cross/bin \
    GCCSDK_INSTALL_ENV=/opt/netsurf/${TOOLCHAIN}/env

RUN apk add --no-cache autoconf automake libtool gperf xxd nasm

COPY --from=sdk /opt/netsurf/docker-build/sdk /opt/netsurf/docker-build/sdk/

RUN make -C /opt/netsurf/docker-build/sdk && \
    rm -rf /opt/netsurf/docker-build
