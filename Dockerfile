FROM ruby:2.5.3-alpine

ENV RUNTIME_PACKAGES="linux-headers libxml2-dev libxslt-dev make gcc libc-dev \
  nodejs imagemagick-dev=6.9.6.8-r1 imagemagick=6.9.6.8-r1 tzdata postgresql-dev postgresql" \
  DEV_PACKAGES="build-base curl-dev" \
  HOME="/yuiyui.com"

WORKDIR $HOME

ADD Gemfile      $HOME/Gemfile
ADD Gemfile.lock $HOME/Gemfile.lock

RUN apk update && \
  apk upgrade

#rmagickはimagemagick 7をサポートしていないのでこれを行います。
RUN echo 'http://dl-cdn.alpinelinux.org/alpine/v3.5/main' >> /etc/apk/repositories

RUN apk add --update --no-cache $RUNTIME_PACKAGES && \
  apk add --update --virtual build-dependencies --no-cache $DEV_PACKAGES && \
  bundle install -j4 && \
  apk del build-dependencies

ADD . $HOME

CMD ["rails", "server", "-b", "0.0.0.0"]
