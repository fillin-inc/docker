#!/bin/bash

set -ex

if [ -f "Gemfile" ]; then
  bundle install
fi
if [ -f "yarn.lock" ]; then
  yarn install
fi

if [ -f "package-lock.json" ]; then
  npm install
fi

if [ -f "tmp/pids/server.pid" ]; then
  rm tmp/pids/server.pid
fi

if [ -e "bin/rails" ]; then
  bin/rails server -b 0.0.0.0
else
  echo 'bin/rails コマンドが見つからなかったので bash を起動します'
  bash
fi
