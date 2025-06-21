From golang:1.22.5 as base

WORKDIR /app

#dependiencies for the app file are stored in go.mod file
COPY go.mod .  

RUN go mod download

#Copy the source code on to the Docker Image
COPY . .

#Artifact called main will be created in Docker image
RUN go build -o main .4

#Final stage - Distroless Image
FROM gcr.io/distroless/base

COPY --from=base /app/main .

#static is outside the binay son we need ot have both static content and binary in distroless image
COPY --from=base /app/static ./static 

EXPOSE 8080

CMD ["./main"] 