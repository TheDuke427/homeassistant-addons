#!/usr/bin/env bash
cd /emulatorjs

# Make sure EmulatorJS is built
npm install
npm run build

# Extract archives to dist/www if not already extracted
mkdir -p dist/www
unzip -o dist/4.2.3.zip -d dist/www

# Start http-server to serve the UI
npx http-server dist/www -p 8080 -a 0.0.0.0
