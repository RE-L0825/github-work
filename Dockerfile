FROM golang:1.22-alpine AS builder

WORKDIR /app

COPY go.mod go.sum ./

RUN go mod download

# Копирование
COPY . .

RUN CGO_ENABLED=0 GOOS=linux go build -o tracker .

FROM alpine:latest

COPY --from=builder /app/tracker /tracker

ENTRYPOINT ["/tracker"]