FROM swift

MAINTAINER André Roque Matheus <amatheus@mac.com>

VOLUME /app

WORKDIR /app

RUN swift test