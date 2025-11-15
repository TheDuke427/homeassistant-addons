#!/usr/bin/env bash
set -e

cd /emulatorjs

# Ensure EmulatorJS is built
npm install
npm run build

# Create ROMs folder inside dist/www if it doesn't exist
mkdir -p dist/www/roms

# Copy mapped ROMs into the web UI folder
cp -r /roms/* dist/www/roms/ 2>/dev/null || true

# Start http-server to serve the UI
npx http-server dist/www -p 8080 -a 0.0.0.0