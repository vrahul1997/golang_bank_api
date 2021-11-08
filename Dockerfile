# Define multistage image to reduce the size of the docker image
# build stage
FROM golang:1.16-alpine3.14 AS builder
WORKDIR /app
COPY . .
RUN go build -o main main.go 
# add curl coz alpine image does nt have curl installed
RUN apk add curl 
RUN curl -L https://github.com/golang-migrate/migrate/releases/download/v4.15.0/migrate.linux-amd64.tar.gz | tar xvz

# run stage
FROM alpine:3.13
WORKDIR /app
COPY --from=builder /app/main .
COPY --from=builder /app/migrate ./migrate
COPY app.env .
COPY start.sh .
COPY wait-for.sh .
COPY db/migration ./migration

# expose for serving the api in specific port
# This is added after creating sh file
# golang binary can be executed only via this entry point
EXPOSE 8080 
CMD [ "/app/main" ]
ENTRYPOINT [ "/app/start.sh" ]
