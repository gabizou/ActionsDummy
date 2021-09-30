FROM golang/alpine:1.15

LABEL maintainer=gabizou

RUN apk add --no-cache gcc musl-dev git

