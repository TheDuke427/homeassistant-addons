#!/usr/bin/env bash
cd /emulatorjs

# Make sure EmulatorJS is built
npm install
npm run build

# Start http-server to serve the UI
npx http-server /emulatorjs/dist -p 8080 -a 0.0.0.0