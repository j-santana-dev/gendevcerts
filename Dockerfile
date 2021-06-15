
FROM alpine:3.13.5
RUN apk add --no-cache build-base bash openssl
COPY . .
ENTRYPOINT [ "./scripts/runAll.sh"]