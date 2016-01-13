FROM ukti/alpine-nginx:1.0

#### nodejs
ARG NODE_VERSION=v5.4.1
ARG NPM_VERSION=3.5.3

RUN apk add --update curl make gcc g++ binutils-gold python linux-headers paxctl libgcc libstdc++ && \
  curl -sSL https://nodejs.org/dist/${NODE_VERSION}/node-${NODE_VERSION}.tar.gz | tar -xz && \
  cd /node-${NODE_VERSION} && \
  ./configure --prefix=/usr ${NODE_CONFIG_FLAGS} && \
  make -j$(grep -c ^processor /proc/cpuinfo 2>/dev/null || 1) && \
  make install && \
  paxctl -cm /usr/bin/node && \
  cd / && \
  if [ -x /usr/bin/npm ]; then \
    npm install -g npm@${NPM_VERSION} && \
    find /usr/lib/node_modules/npm -name test -o -name .bin -type d | xargs rm -rf; \
  fi && \
  apk del curl make gcc g++ binutils-gold python linux-headers paxctl ${DEL_PKGS} && \
  rm -rf /etc/ssl /node-${NODE_VERSION} ${NODE_RM_DIRS} \
    /usr/share/man /tmp/* /var/cache/apk/* /root/.npm /root/.node-gyp \
    /usr/lib/node_modules/npm/man /usr/lib/node_modules/npm/doc /usr/lib/node_modules/npm/html
