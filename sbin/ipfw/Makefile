# $FreeBSD$

.include <bsd.own.mk>

PROG=	ipfw
SRCS=	ipfw2.c dummynet.c ipv6.c main.c nat.c context.c
WARNS?=	2

.if ${MK_PF} != "no"
SRCS+=	altq.c
CFLAGS+=-DPF
.endif

DPADD=	${LIBUTIL}
LDADD=	-lutil
MAN=	ipfw.8

.include <bsd.prog.mk>
