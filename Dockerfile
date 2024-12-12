# Этап 1: Сборка программного обеспечения
FROM golang:1.20 AS builder

WORKDIR /app

# Клонирование кода из репозитория
RUN git clone https://github.com/username/repository.git .
RUN go build -o server main.go

# Этап 2: Создание минимального образа
FROM alpine:latest

# Добавление сертификатов и необходимого окружения
RUN apk --no-cache add ca-certificates

WORKDIR /root/

# Копирование исполняемого файла из предыдущего этапа
COPY --from=builder /app/server .

# Настройка точки входа
ENTRYPOINT ["./server"]
