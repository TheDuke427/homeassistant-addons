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
COPY index.html /emulatorjs/dist/index.html

# Clone EmulatorJS repo
RUN git clone https://github.com/EmulatorJS/EmulatorJS.git .

# Install npm packages
RUN npm install

# Patch build.js to avoid TTY errors
RUN sed -i 's/process.stdout.clearLine();/if(process.stdout.isTTY) process.stdout.clearLine();/' build.js \
 && sed -i 's/process.stdout.cursorTo(0);/if(process.stdout.isTTY) process.stdout.cursorTo(0);/' build.js


# Copy the run.sh script
COPY run.sh /emulatorjs/run.sh
RUN chmod +x /emulatorjs/run.sh

# Expose default port if needed
EXPOSE 8080

# Start EmulatorJS via run.sh
CMD ["/emulatorjs/run.sh"]
