#!/usr/bin/env bash
cd /emulatorjs

# Make sure EmulatorJS is built
npm install
npm run build

# Start http-server serving the entire /emulatorjs directory
# This includes /dist and /roms
node generate_roms.js
npx http-server /emulatorjs -p 8080 -a 0.0.0.0