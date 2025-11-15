FROM node:18-bullseye

RUN apt-get update && apt-get install -y bash git python3 make g++ p7zip-full \
 && rm -rf /var/lib/apt/lists/*

WORKDIR /emulatorjs

COPY run.sh /emulatorjs/run.sh
RUN chmod +x /emulatorjs/run.sh

# Build EmulatorJS
RUN npm install
RUN sed -i 's/process.stdout.clearLine();/if(process.stdout.isTTY) process.stdout.clearLine();/' build.js \
 && sed -i 's/process.stdout.cursorTo(0);/if(process.stdout.isTTY) process.stdout.cursorTo(0);/' build.js
RUN npm run build

EXPOSE 8080

CMD ["bash", "/emulatorjs/run.sh"]
