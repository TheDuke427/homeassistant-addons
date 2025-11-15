#!/usr/bin/env bash
cd /emulatorjs

# Build EmulatorJS
npm install
npm run build

# Generate roms.json
node generate_roms.cjs

# Start http-server to serve the UI
npx http-server /emulatorjs/dist -p 8080 -a 0.0.0.0