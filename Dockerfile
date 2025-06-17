FROM --platform=x86_64 ubuntu:24.04
LABEL maintainer="Sunnyvale S.r.l."
LABEL description="Docker image for the Atlantis Land PowerMaster Plus 1.2.2"

ARG PACKAGE_NAME=pmasterp122-linux-x86_x64.sh

WORKDIR /tmp

COPY ${PACKAGE_NAME} ./${PACKAGE_NAME}
COPY response.varfile ./response.varfile

RUN apt update && apt install -y \
    usbutils \
    libusb-1.0-0 \
    libhidapi-hidraw0 \
    && apt clean

RUN chmod 755 ./${PACKAGE_NAME} && \
    ./${PACKAGE_NAME} \
    -q \
    -varfile response.varfile

WORKDIR /

EXPOSE 3052

ENTRYPOINT ["/usr/local/PMasterP/pmasterpd", "run"]