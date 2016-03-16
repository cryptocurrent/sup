CC?=gcc
LDD?=ld
DESTDIR?=
PREFIX?=/usr/local
VERSION=0.2
USER=root
GROUP=root

CFLAGS?=-fPIC -fPIE -Wall
LDFLAGS?=-fPIC -fPIE -pie

CFLAGS+=-Os -O2

all: config.h sup

config.h:
	cp config.def.h config.h

sup.o: config.h sup.c
	${CC} ${CFLAGS} -c sup.c -DVERSION=${VERSION}

sup: sup.o
	${CC} ${LDFLAGS} sup.o -o sup

clean:
	rm -f sup.o sup

mrproper: clean
	rm -f config.h

install:
	mkdir -p ${DESTDIR}${PREFIX}/bin
	cp -f sup ${DESTDIR}${PREFIX}/bin
	-chown ${USER}:${GROUP} ${DESTDIR}/${PREFIX}/bin/sup
	-chmod 4111 ${DESTDIR}${PREFIX}/bin/sup
	mkdir -p ${DESTDIR}${PREFIX}/share/man/man1
	sed s,VERSION,${VERSION}, sup.1 \
	  > ${DESTDIR}${PREFIX}/share/man/man1/sup.1
