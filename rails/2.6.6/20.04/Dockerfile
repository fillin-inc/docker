FROM fillininc/ruby:2.6.6-20.04
LABEL maintainer="fillin Inc."

ENV NODE_MAJOR_VERSION 12
ENV RAILS_PORT 3000
ENV RAILS_IP 0.0.0.0

# Install ChromeDriver
RUN apt-get update -qq \
  && apt-get upgrade -y \
  && apt-get install -y vim less silversearcher-ag \
  && apt-get install -y curl gnupg zip libappindicator1 fonts-liberation fonts-ipaexfont \
  && apt-get install -y curl imagemagick libvips \
  && CHROME_DRIVER_VERSION=`curl -sS chromedriver.storage.googleapis.com/LATEST_RELEASE` \
  && cd /tmp \
  && curl -O https://chromedriver.storage.googleapis.com/${CHROME_DRIVER_VERSION}/chromedriver_linux64.zip \
  && unzip chromedriver_linux64.zip \
  && mv chromedriver /usr/local/bin/ \
  && chown root:root /usr/local/bin/chromedriver \
  && chmod 0755 /usr/local/bin/chromedriver

# Install Google Chrome
RUN curl https://dl.google.com/linux/linux_signing_key.pub | apt-key add - \
  && echo 'deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main' | tee /etc/apt/sources.list.d/google-chrome.list \
  && apt-get update -qq \
  && apt-get install -y google-chrome-stable

# Install Node & Yarn
RUN curl -sL https://deb.nodesource.com/setup_${NODE_MAJOR_VERSION}.x | bash - \
      && curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - \
      && echo 'deb https://dl.yarnpkg.com/debian/ stable main' | tee /etc/apt/sources.list.d/yarn.list \
      && apt-get -qq update \
      && apt-get install -y nodejs yarn \
      && apt-get install -y gcc g++ make # development tools to build native addons

COPY startup.sh /root/startup.sh

RUN chmod +x /root/startup.sh \
  && rm -rf /var/lib/apt/lists/* \
  && rm -rf /tmp/*

EXPOSE ${RAILS_PORT}

CMD '/root/startup.sh'
