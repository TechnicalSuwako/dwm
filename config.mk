# dwm version
VERSION = 6.5

# Customize below to fit your system

# paths
PREFIX = /usr/local
MANPREFIX = ${PREFIX}/share/man

# OS
UNAME != uname -s

.if "${UNAME}" == "FreeBSD"
INC = /usr/local/include
LIB = /usr/local/lib
.endif

X11INC = /usr/X11R6/include
X11LIB = /usr/X11R6/lib

# Xinerama, comment if you don't want it
XINERAMALIBS  = -lXinerama
XINERAMAFLAGS = -DXINERAMA

# freetype
FREETYPELIBS = -lfontconfig -lXft
# OpenBSD (uncomment)
.if "${UNAME}" == "OpenBSD"
FREETYPEINC = ${X11INC}/freetype2
MANPREFIX = ${PREFIX}/man
.else
FREETYPEINC = ${INC}/freetype2
.endif

# includes and libs
.if "${UNAME}" == "OpenBSD"
INCS = -I${X11INC} -I${FREETYPEINC}
LIBS = -L${X11LIB} -lX11 ${XINERAMALIBS} ${FREETYPELIBS} -lXrender
.elif "${UNAME}" == "FreeBSD"
INCS = -I${INC} -I${FREETYPEINC}
LIBS = -L${LIB} \
       -static \
       -lX11 -lXinerama -lfontconfig -lXft -lXrender -lc -lxcb -lXext \
       -lfreetype -lpng16 -lexpat -lintl -lXau -lXdmcp -lbz2 \
       -lbrotlidec -lz -lm -lbrotlicommon
.endif

# flags
CPPFLAGS = -D_DEFAULT_SOURCE -D_BSD_SOURCE -D_XOPEN_SOURCE=700L -DVERSION=\"${VERSION}\" ${XINERAMAFLAGS}
#CFLAGS   = -g -std=c99 -pedantic -Wall -O0 ${INCS} ${CPPFLAGS}
CFLAGS   = -std=c99 -pedantic -Wall -Wno-deprecated-declarations -Os ${INCS} ${CPPFLAGS}
LDFLAGS  = ${LIBS}

# Solaris
#CFLAGS = -fast ${INCS} -DVERSION=\"${VERSION}\"
#LDFLAGS = ${LIBS}

# compiler and linker
CC = cc
