# Use official Node 18 image
FROM node:18-bullseye

# Install dependencies
RUN apt-get update && apt-get install -y \
    bash \
    git \
    python3 \
    make \
    g++ \
    p7zip-full \
 && rm -rf /var/lib/apt/lists/*

WORKDIR /emulatorjs

# Clone source & install
RUN git clone https://github.com/EmulatorJS/EmulatorJS.git .
RUN npm install

# Patch build.js to avoid TTY errors in build environment
RUN sed -i 's/process.stdout.clearLine();/if(process.stdout.isTTY) process.stdout.clearLine();/' build.js \
 && sed -i 's/process.stdout.cursorTo(0);/if(process.stdout.isTTY) process.stdout.cursorTo(0);/' build.js

# Build EmulatorJS (creates dist/)
RUN npm run build

# Ensure destination directories exist
RUN mkdir -p /emulatorjs/dist /emulatorjs/dist/www /emulatorjs/dist/www/assets

# Copy custom UI (your repo must contain index.html at repo root)
COPY index.html /emulatorjs/dist/index.html
COPY index.html /emulatorjs/dist/www/index.html

# Copy run script
COPY run.sh /emulatorjs/run.sh
RUN chmod +x /emulatorjs/run.sh

# Expose port and start via run.sh
EXPOSE 8080
CMD ["/emulatorjs/run.sh"]
