# Use Node 18 LTS on Alpine
FROM node:18-alpine

# Install dependencies
RUN apk add --no-cache \
    bash \
    git \
    python3 \
    make \
    g++ \
    p7zip

# Set working directory
WORKDIR /emulatorjs

# Clone EmulatorJS repo and build
RUN git clone https://github.com/EmulatorJS/EmulatorJS.git . \
    && npm install \
    && npm run build

# Expose port for HA add-on
EXPOSE 8080

# Copy startup script
COPY run.sh /run.sh
RUN chmod +x /run.sh

CMD ["/run.sh"]