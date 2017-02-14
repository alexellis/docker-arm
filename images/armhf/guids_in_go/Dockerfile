FROM alexellis2/go-armhf:1.7.4
WORKDIR /go/src/github.com/alexellis/guidsingo

COPY main.go .
RUN go get
RUN go install

EXPOSE 9000

CMD ["guidsingo"]
