FROM alpine:latest
RUN echo "Hello from Jenkins ECR Pipeline!" > /hello.txt
CMD ["cat", "/hello.txt"]
