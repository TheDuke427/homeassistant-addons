FROM node:20-alpine

# Install dependencies
RUN apk add --no-cache bash git python3 make g++ p7zip

# Internal working directory for EmulatorJS
WORKDIR /emulatorjs

# Clone EmulatorJS source and install dependencies
RUN git clone https://github.com/EmulatorJS/EmulatorJS.git . \
    && npm install \
    && npm run build

# Expose port
EXPOSE 8080

# Copy run script
COPY run.sh /run.sh
RUN chmod +x /run.sh

# Run add-on
CMD ["/run.sh"]