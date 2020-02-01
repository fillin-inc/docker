#!/bin/sh

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
  rm -f tmp/pids/server.pid
fi

if [ -f "tmp/pids/unicorn.pid" ]; then
  rm -f tmp/pids/unicorn.pid
fi

if [ -f "tmp/pids/puma.pid" ]; then
  rm -f tmp/pids/puma.pid
fi

cd ${WORK_DIR}

if [ -e "bin/rails" ]; then
  bin/rails db:setup
  bin/rails server -p ${RAILS_PORT} -b ${RAILS_IP}
else
  echo "bin/rails が存在しないため bash を起動します"
  bash
fi
