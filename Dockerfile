# syntax = docker/dockerfile:1

ARG RUBY_VERSION=3.2.2
FROM ruby:$RUBY_VERSION-slim as base

WORKDIR /app

ENV RAILS_ENV="production" \
    BUNDLE_DEPLOYMENT="1" \
    BUNDLE_PATH="/usr/local/bundle" \
    BUNDLE_WITHOUT="development" \
    PATH="/usr/local/bundle/bin:$PATH"

FROM base as build

RUN apt-get update -qq && \
    apt-get install --no-install-recommends -y \
    build-essential \
    default-libmysqlclient-dev \
    git \
    libvips \
    pkg-config \
    libpq-dev \
    curl \
    && rm -rf /var/lib/apt/lists/*

RUN curl -fsSL https://deb.nodesource.com/setup_16.x | bash - && \
    apt-get install -y nodejs \
    && npm --version

COPY Gemfile /app/Gemfile
COPY Gemfile.lock /app/Gemfile.lock

RUN gem install bundler && bundle install

COPY . /app

COPY node_client/package.json /app/node_client/package.json
RUN cd /app/node_client && npm install

RUN bundle exec bootsnap precompile app/ lib/
#RUN bundle exec rake assets:precompile

FROM base

RUN apt-get update -qq && \
    apt-get install --no-install-recommends -y curl default-mysql-client libvips && \
    rm -rf /var/lib/apt/lists /var/cache/apt/archives

COPY --from=build /usr/local/bundle /usr/local/bundle
COPY --from=build /app /app

RUN mkdir -p /app/db /app/log /app/storage /app/tmp && \
    useradd rails --create-home --shell /bin/bash && \
    chown -R rails:rails /app/db /app/log /app/storage /app/tmp

USER rails:rails

ENTRYPOINT ["./entrypoints/docker-entrypoint.sh"]

EXPOSE 3000
CMD ["bundle", "exec", "rails", "server", "-b", "0.0.0.0"]
