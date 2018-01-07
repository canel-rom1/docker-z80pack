FROM canelrom1/debian-canel:latest
MAINTAINER Rom1 <rom1@canel.ch> - CANEL - https://www.canel.ch

LABEL date="07/01/1"
LABEL version="1.0"
LABEL description="z80pack: Simulator for Z80, 8080 CP/M(1,2,3) MP/M - http://www.autometer.de/unix4fun/z80pack/"

RUN apt-get update \
 && apt-get upgrade -y -q \
 && apt-get install -y -q --no-install-recommends \
	build-essential \
	git \
	wget

ENV Z80PACK_VERSION 1.36

RUN wget -P /tmp http://www.autometer.de/unix4fun/z80pack/ftp/z80pack-${Z80PACK_VERSION}.tgz \
 && tar -zxvf /tmp/z80pack-${Z80PACK_VERSION}.tgz -C /tmp

WORKDIR /tmp/z80pack-${Z80PACK_VERSION}/z80sim/srcsim
RUN make -f Makefile.linux \
 && cp z80sim /usr/local/bin

WORKDIR /tmp/z80pack-${Z80PACK_VERSION}/z80asm
RUN make \
 && cp z80asm /usr/local/bin

WORKDIR /tmp
COPY ./entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
