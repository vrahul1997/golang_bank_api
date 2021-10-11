# Define multistage image to reduce the size of the docker image
# build stage
FROM golang:1.16-alpine3.14 AS builder
WORKDIR /app
COPY . .
RUN go build -o main main.go

# run stage
FROM alpine:3.13
WORKDIR /app
COPY --from=builder /app/main .
COPY app.env .

# expose for serving the api in specific port
EXPOSE 8080 
CMD [ "/app/main" ]
