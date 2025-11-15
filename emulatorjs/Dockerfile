FROM node:18-alpine

# Install dependencies
RUN apk add --no-cache \
    bash \
    git \
    python3 \
    make \
    g++ \
    p7zip

WORKDIR /emulatorjs

# Clone repo and install dependencies
RUN git clone https://github.com/EmulatorJS/EmulatorJS.git . \
    && npm install

# Expose port
EXPOSE 8080

# Copy run script
COPY run.sh /run.sh
RUN chmod +x /run.sh

CMD ["/run.sh"]