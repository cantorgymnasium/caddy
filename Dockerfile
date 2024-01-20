FROM caddy:2-builder-alpine AS builder

RUN apk add --no-cache brotli-dev gcc musl-dev

RUN CGO_ENABLED=1 \
    xcaddy build \
    --with github.com/caddy-dns/cloudflare \
    --with github.com/dunglas/caddy-cbrotli

FROM caddy:2-alpine

RUN apk add --no-cache brotli brotli-dev

COPY --from=builder /usr/bin/caddy /usr/bin/caddy
