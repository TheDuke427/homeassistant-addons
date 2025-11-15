#!/bin/bash

# Build EmulatorJS public assets
emulatorjs build

# Start emulatorjs server
emulatorjs server --host 0.0.0.0 --port 80