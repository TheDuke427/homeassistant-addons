FROM node:18-bullseye

RUN apt-get update && apt-get install -y bash git python3 make g++ p7zip
WORKDIR /emulatorjs
RUN git clone https://github.com/EmulatorJS/EmulatorJS.git . \
    && npm install \
    && npm run build
EXPOSE 8080
COPY run.sh /run.sh
RUN chmod +x /run.sh
CMD ["/run.sh"]