FROM debian:buster

RUN apt update \
	&& apt install -y \
		libarchive-tools \
		genisoimage \
		syslinux-utils \
	&& rm -rf /var/lib/apt/lists/*

WORKDIR /app
COPY ./ ./

