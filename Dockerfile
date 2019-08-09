# build
FROM golang:1.12.7-alpine3.10 as build

ENV PORT 8080
EXPOSE 8080

RUN mkdir /app
ADD . /app

ENV GOPROXY https://goproxy.io
ENV GIN_MODE release

WORKDIR  /app
RUN go mod vendor
RUN go build -mod=vendor -tags=jsoniter -o gitlab-hello-world .


# release
FROM alpine:3.10
RUN mkdir /app
COPY --from=build /app/gitlab-hello-world /app/gitlab-hello-world

WORKDIR  /app
CMD ["/app/gitlab-hello-world"]
