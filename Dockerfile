FROM iron/base

RUN echo '@edge http://nl.alpinelinux.org/alpine/edge/main' >> /etc/apk/repositories
RUN echo '@community http://nl.alpinelinux.org/alpine/edge/community' >> /etc/apk/repositories

RUN apk update && apk upgrade
RUN apk add go@community

RUN rm -rf /var/cache/apk/*

ENV GOPATH /go

ADD . /go/src/github.com/ivancevich/ios-installer
RUN go install github.com/ivancevich/ios-installer
COPY template.html /go/bin/ 
ENTRYPOINT /go/bin/ios-installer

EXPOSE 8080
