FROM golang:1.15-alpine

LABEL maintainer=gabizou

RUN apk add --no-cache gcc musl-dev git

