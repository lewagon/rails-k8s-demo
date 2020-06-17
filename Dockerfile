# https://github.com/lewagon/rails-base-chrome-imagemagick/tree/dev
FROM quay.io/lewagon/rails-base-chrome-imagemagick:dev
ARG BUNDLER_VERSION
ENV BUNDLER_VERSION=${BUNDLER_VERSION:-2.1.4}

COPY ./Aptfile /tmp/Aptfile
RUN apt-get update -qq && DEBIAN_FRONTEND=noninteractive apt-get -yq dist-upgrade && \
  DEBIAN_FRONTEND=noninteractive apt-get install -yq --no-install-recommends \
  $(cat /tmp/Aptfile | xargs) && \
  apt-get clean && \
  rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* && \
  truncate -s 0 /var/log/*log

# Configure bundler
ENV LANG=C.UTF-8 \
  BUNDLE_JOBS=4 \
  BUNDLE_RETRY=3

ENV PATH /app/bin:$PATH

WORKDIR /app

# Upgrade RubyGems and install required Bundler version
RUN gem update --system && \
  gem install bundler -v $BUNDLER_VERSION