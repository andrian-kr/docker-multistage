# Build Stage
FROM ubuntu AS build
WORKDIR /app
RUN apt-get update && apt-get install -y golang-go 
COPY user.go .
RUN CGO_ENABLED=0 go build -o myapp user.go

# Final Stage
FROM alpine
WORKDIR /app
COPY --from=build /app/myapp .
CMD ["./myapp"]