FROM alpine:3.19

# Install dependencies
RUN apk update && \
    apk add --no-cache \
        nodejs \
        npm \
        git \
        bash

# Install EmulatorJS from NPM (frontend + backend)
RUN npm install -g emulatorjs

# Create working directory
WORKDIR /app

# Copy start script
COPY run.sh /app/run.sh
RUN chmod +x /app/run.sh

EXPOSE 80

CMD ["/app/run.sh"]