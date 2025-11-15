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

# Set working directory
WORKDIR /emulatorjs

# Clone EmulatorJS repo
RUN git clone https://github.com/EmulatorJS/EmulatorJS.git .

# Patch build.js to avoid TTY errors
RUN sed -i 's/process.stdout.clearLine();/if(process.stdout.isTTY) process.stdout.clearLine();/' build.js \
 && sed -i 's/process.stdout.cursorTo(0);/if(process.stdout.isTTY) process.stdout.cursorTo(0);/' build.js

# Install npm packages
RUN npm install

# Copy run.sh into the container
COPY run.sh /emulatorjs/run.sh
RUN chmod +x /emulatorjs/run.sh

# Build EmulatorJS
RUN npm run build

# Expose default port
EXPOSE 8080

# Run run.sh as entrypoint
CMD ["bash", "/emulatorjs/run.sh"]
