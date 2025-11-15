# Base image
FROM alpine:3.19

# Install build dependencies
RUN apk update && apk add --no-cache \
    nodejs \
    npm \
    git \
    python3 \
    make \
    g++ \
    bash \
    p7zip \
    curl \
    wget \
    ca-certificates

# Clone EmulatorJS repository
RUN git clone https://github.com/EmulatorJS/EmulatorJS.git /emulatorjs

# Set working directory
WORKDIR /emulatorjs

# Install Node dependencies
RUN npm install

# Patch build.js to avoid stdout.clearLine errors in Docker (non-TTY)
RUN sed -i 's/process.stdout.clearLine();//g' build.js
RUN sed -i 's/process.stdout.cursorTo(0);//g' build.js

# Build EmulatorJS
RUN npm run build

# Copy add-on startup script
COPY run.sh /run.sh
RUN chmod +x /run.sh

# Expose default port
EXPOSE 80

# Start the server
CMD ["/run.sh"]