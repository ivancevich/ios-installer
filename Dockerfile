FROM iron/base

RUN echo '@edge http://nl.alpinelinux.org/alpine/edge/main' >> /etc/apk/repositories
RUN echo '@community http://nl.alpinelinux.org/alpine/edge/community' >> /etc/apk/repositories

RUN apk update && apk upgrade
RUN apk add go@community

RUN rm -rf /var/cache/apk/*

ENV GOPATH /go
ENV TEMPLATE_PATH /go/src/github.com/ivancevich/ios-installer/template.html

ADD . /go/src/github.com/ivancevich/ios-installer
RUN go install github.com/ivancevich/ios-installer 

ENTRYPOINT /go/bin/ios-installer

EXPOSE 8080
