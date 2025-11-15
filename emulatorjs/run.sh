#!/usr/bin/env bash
cd /emulatorjs

# Start http-server on all interfaces
npx http-server /roms -p 8080 -a 0.0.0.0