FROM golang:1.24.1-alpine AS builder

COPY . /app/
WORKDIR /app/

RUN go mod tidy
RUN go build -o ./bin/chat_server cmd/main.go

FROM alpine:latest

WORKDIR /root/

COPY --from=builder /app/bin/chat_server .

CMD ["./chat_server"]