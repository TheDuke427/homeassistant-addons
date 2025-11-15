#!/usr/bin/env bash
cd /emulatorjs

# Make sure EmulatorJS is built
npm install
npm run build

# Extract archive to dist
7z x 4.2.3.7z -o./dist

# Start http-server to serve the UI
npx http-server ./dist -p 8080 -a 0.0.0.0