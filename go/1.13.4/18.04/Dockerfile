FROM ubuntu:18.04
LABEL maintainer="fillin Inc."
ENV LANG C.UTF-8

ARG GO_VERSION=1.13.4
ARG GO_CHECKSUM=692d17071736f74be04a72a06dab9cac1cd759377bd85316e52b2227604c004c
ARG GO_ROOT=/usr/local/go

ENV WORK_DIR /usr/local/app
WORKDIR ${WORK_DIR}

ENV GOPATH ${WORK_DIR}/go
ENV GOBIN=${GOPATH}/bin \
    PATH=${PATH}:${GOPATH}/bin

ADD https://storage.googleapis.com/golang/go${GO_VERSION}.linux-amd64.tar.gz /tmp

RUN apt-get -qq update \
      && apt-get install -y git make ca-certificates zip \
      && echo "${GO_CHECKSUM} /tmp/go${GO_VERSION}.linux-amd64.tar.gz" > /tmp/checksum.dat \
      && cat /tmp/checksum.dat && sha256sum -c /tmp/checksum.dat \
      && tar xvzf /tmp/go${GO_VERSION}.linux-amd64.tar.gz -C /tmp \
      && mv /tmp/go /usr/local/ \
      && ln -s ${GO_ROOT}/bin/go /usr/local/bin/go \
      && mkdir -p ${GOBIN} \
      && rm -rf ${GO_ROOT}/blog ${GO_ROOT}/api ${GO_ROOT}/doc ${GO_ROOT}/test \
      && rm -rf /tmp/*

RUN apt-get install -y curl gcc mysql-client \
      && curl https://glide.sh/get | sh \
      && go get -u github.com/golang/dep/cmd/dep \
      && go get bitbucket.org/liamstask/goose/cmd/goose \
      && go get -u golang.org/x/lint/golint \
      && rm -rf /var/lib/apt/lists/*

EXPOSE 80 443 8000

CMD ["/bin/bash"]
