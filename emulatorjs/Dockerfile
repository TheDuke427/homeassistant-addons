FROM alpine:3.19

# Install dependencies
RUN apk update && apk add --no-cache \
    nodejs \
    npm \
    git \
    python3 \
    make \
    g++ \
    bash

# Clone EmulatorJS from GitHub
RUN git clone https://github.com/EmulatorJS/EmulatorJS.git /emulatorjs

# Install dependencies and build backend/frontend
WORKDIR /emulatorjs
RUN npm install
RUN npm run build

# Copy startup script
COPY run.sh /run.sh
RUN chmod +x /run.sh

EXPOSE 80

CMD ["/run.sh"]