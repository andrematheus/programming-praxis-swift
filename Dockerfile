FROM swift

MAINTAINER André Roque Matheus <amatheus@mac.com>

VOLUME /app

WORKDIR /app

COPY . /app

CMD swift test --enable-test-discovery
