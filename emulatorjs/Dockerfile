FROM node:18-bullseye

RUN apt-get update && apt-get install -y \
    bash \
    git \
    python3 \
    make \
    g++ \
    p7zip-full

WORKDIR /emulatorjs

RUN git clone https://github.com/EmulatorJS/EmulatorJS.git . \
    && npm install \
    && npm run build

EXPOSE 8080