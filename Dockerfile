FROM "library/ubuntu:17.04"

ARG UID
ARG GID
ARG USERNAME

RUN apt-get update \
 && apt-get install -y sudo git tmux vim python3 \
 && echo "%sudo ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers \
 && useradd -u $UID -g $GID -G sudo -m $USERNAME

##RUN apk add --no-cache -X http://nl.alpinelinux.org/alpine/edge/main \
##    python3>3.5 \
##    python3-dev \
##    py-pip \
##    uwsgi \
##    uwsgi-python3 \
## && apk add --no-cache \
##    nginx \
##    redis \
##    gcc \
##    musl-dev \
##    linux-headers \
##    nodejs \
##    make \
## && pip3 install --upgrade \
##    pip \
##    flask \
##    flask-restful \
##    redis \
##    hiredis \
##    requests \
##    pytest \
##    netifaces \
##    python-jose \
##    websocket-client \
##    asyncio_redis \
##    autobahn \
##    "construct>=2.8.7" \
##    pyyaml \
##    pyelftools \
##    pylint \
##    cpplint \
## && mkdir /run/nginx
