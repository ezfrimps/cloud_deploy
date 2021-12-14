FROM golang:1.17-buster
RUN mkdir /app
ADD . /app
WORKDIR /app
RUN go mod tidy
RUN go build -o main
RUN  go get ./...
EXPOSE  8080
CMD [ "/app/main" ]