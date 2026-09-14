FROM node:20-slim
WORKDIR /usr/src/app
RUN groupadd -r app && useradd -r -g app app && mkdir -p /usr/src/app && chown -R app:app /usr/src/app
COPY . /usr/src/app
RUN npm install --production
EXPOSE 8000
HEALTHCHECK --interval=30s --timeout=5s CMD curl -f http://localhost:8000/health || exit 1
USER app
CMD ["node", "server.js"]