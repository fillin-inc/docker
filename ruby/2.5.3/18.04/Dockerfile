FROM ubuntu:18.04
LABEL maintainer="fillin Inc."

ARG RUBY_VERSION=2.5.3
ARG RUBY_CHECKSUM=9828d03852c37c20fa333a0264f2490f07338576734d910ee3fd538c9520846c

ENV GEM_HOME /usr/local/bundle
ENV BUNDLE_PATH="$GEM_HOME" \
	BUNDLE_SILENCE_ROOT_WARNING=1 \
	BUNDLE_APP_CONFIG="$GEM_HOME"

ENV WORK_DIR /opt/app
WORKDIR $WORK_DIR
VOLUME $WORK_DIR

RUN apt-get -qq update \
      && apt-get install -y curl build-essential \
                        libbison-dev \
                        libffi-dev \
                        libgdbm-dev \
                        libmysqlclient-dev \
                        libncurses5-dev \
                        libpq-dev \
                        libreadline6-dev \
                        libssl-dev \
                        libxml2-dev \
                        libxslt1-dev \
                        libyaml-dev \
                        ruby-dev \
                        zlib1g-dev \
      && DEBIAN_FRONTEND=noninteractive apt-get install -y tzdata \
      && curl -o /tmp/ruby-$RUBY_VERSION.tar.gz https://cache.ruby-lang.org/pub/ruby/`echo $RUBY_VERSION | sed -e 's/\.[0-9]*$//'`/ruby-$RUBY_VERSION.tar.gz \
      && echo "$RUBY_CHECKSUM /tmp/ruby-$RUBY_VERSION.tar.gz" > /tmp/checksum.dat \
      && cat /tmp/checksum.dat && sha256sum -c /tmp/checksum.dat \
      && tar xvzf /tmp/ruby-$RUBY_VERSION.tar.gz -C /tmp \
      && cd /tmp/ruby-$RUBY_VERSION/; ./configure --prefix=/usr/local/ruby/$RUBY_VERSION && make && make test && make install \
      && echo 'gem: --no-ri --no-rdoc' > ~/.gemrc \
      && mkdir -p $GEM_HOME && chmod 777 $GEM_HOME \
      && /usr/local/ruby/$RUBY_VERSION/bin/gem install bundler pry pry-byebug pry-doc rake --no-ri --no-rdoc \
      && apt-get remove -y --auto-remove curl build-essential \
      # for nokogiri
      && apt-get install -y make gcc \
      && rm -rf /tmp/* \
      && rm -rf /var/lib/apt/lists/* \
      && rm -rf /root/.gem

ENV RUBY_BIN /usr/local/ruby/$RUBY_VERSION/bin
ENV PATH $RUBY_BIN:$BUNDLE_PATH/bin:$PATH
EXPOSE 3000 4567

CMD $BUNDLE_PATH/bin/pry
