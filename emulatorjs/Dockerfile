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

# Copy custom script to generate roms.json
COPY generate_roms.cjs /emulatorjs/generate_roms.cjs

# Install npm packages
RUN npm install

# Patch build.js to avoid TTY errors
RUN sed -i 's/process.stdout.clearLine();/if(process.stdout.isTTY) process.stdout.clearLine();/' build.js

# Build EmulatorJS
RUN npm run build

# Generate roms.json
RUN node generate_roms.cjs

# Expose port
EXPOSE 8080

# Start HTTP server
CMD ["npx", "http-server", "/emulatorjs/dist", "-p", "8080", "-a", "0.0.0.0"]