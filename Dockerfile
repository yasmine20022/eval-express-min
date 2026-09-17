FROM node:20-slim AS builder
WORKDIR /app
RUN apt-get update && apt-get install -y --no-install-recommends build-essential python3 make g++ && rm -rf /var/lib/apt/lists/*
COPY . /app
RUN npm install --production

FROM node:20-slim AS runtime
WORKDIR /app
COPY --from=builder /app /app
RUN groupadd -r appuser && useradd -r -g appuser -d /home/appuser -m appuser
USER appuser
EXPOSE 8000
HEALTHCHECK CMD curl -f http://localhost:8000/health || exit 1
CMD ["node","server.js"]
