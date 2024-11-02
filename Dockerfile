FROM golang:1.22 as base

WORKDIR /app

COPY go.mod .   
#just like requiremnts.txt

RUN go mod download
#pip install -r requirements.txt

COPY . .

RUN go build -o main .

#Final stage using distroless image
FROM gcr.io/distroless/base

COPY --from=base /app/main .

COPY --from=base /app/static ./static

EXPOSE 8080

CMD [ "./main" ]