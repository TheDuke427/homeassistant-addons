#!/usr/bin/env bash
cd /emulatorjs

# Build EmulatorJS
npm install
npm run build

# Extract the ZIP archive to ./dist/www
unzip -o dist/4.2.3.zip -d dist/www

# Serve the extracted folder
npx http-server dist/www -p 8080 -a 0.0.0.0