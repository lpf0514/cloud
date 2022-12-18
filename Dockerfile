FROM golang:1.16-alpine AS builder
# COPY复制文件或目录到容器指定目录
COPY main /src 
# 切换容器中当前执行的工作目录
WORKDIR /app
RUN GOPROXY=https://goproxy.cn CGO_ENABLE=0 GOOS=linux go build -o http_server ./main.go

## 
FROM alpine:latest as final
# 从builder中复制编译好的可执行文件
COPY --from=builder /app/http-server /app/
WORKDIR /app/
# 暴露9000端口
EXPOSE 9000
CMD ["./http_server"]
