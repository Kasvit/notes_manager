#!/bin/sh

set -e

export PATH="/usr/local/bundle/bin:$PATH"

if [ -f tmp/pids/server.pid ]; then
  rm tmp/pids/server.pid
fi

bundle exec rails s -b 0.0.0.0
