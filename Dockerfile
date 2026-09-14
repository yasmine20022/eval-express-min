FROM node:20-slim
WORKDIR /app
COPY . /app
RUN npm install --production
RUN groupadd -r appuser && useradd -r -g appuser appuser
USER appuser
EXPOSE 8000
HEALTHCHECK --interval=30s --timeout=5s CMD curl -f http://localhost:8000/health || exit 1
CMD ["node","server.js"]
