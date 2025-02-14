FROM golang:alpine AS builder

RUN apk update && apk add --no-cache git

COPY . /app
WORKDIR /app

RUN CGO_ENABLED=0 GOOS=linux GOARCH=amd64 go build -a -tags netgo -ldflags '-w' -o /go/bin/websub ./cmd/websub

FROM scratch

COPY --from=builder /go/bin/websub /go/bin/websub
ENTRYPOINT ["/go/bin/websub"]