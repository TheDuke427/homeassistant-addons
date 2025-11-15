#!/usr/bin/env bash
set -e

cd /emulatorjs

echo "Starting EmulatorJS container..."

# --- Generate roms.json dynamically ---
ROM_DIR="/roms"
DATA_DIR="/emulatorjs/data"
OUTPUT_FILE="$DATA_DIR/roms.json"

mkdir -p "$DATA_DIR"

echo "Generating roms.json from $ROM_DIR ..."

# Start JSON array
echo "[" > "$OUTPUT_FILE"

# Loop through system folders
for SYSTEM in "$ROM_DIR"/*; do
  if [ -d "$SYSTEM" ]; then
    SYSTEM_NAME=$(basename "$SYSTEM")
    for ROM in "$SYSTEM"/*.zip; do
      [ -e "$ROM" ] || continue
      ROM_NAME=$(basename "$ROM")
      echo "  {\"name\": \"$ROM_NAME\", \"system\": \"$SYSTEM_NAME\", \"url\": \"/roms/$SYSTEM_NAME/$ROM_NAME\"}," >> "$OUTPUT_FILE"
    done
  fi
done

# Remove trailing comma
sed -i '$ s/,$//' "$OUTPUT_FILE"
echo "]" >> "$OUTPUT_FILE"

echo "roms.json generated at $OUTPUT_FILE (size: $(stat -c%s "$OUTPUT_FILE") bytes)"

# --- Prepare UI ---
# Copy all top-level dist files (docs, css, js) into www for serving
cp -r dist/docs dist/www/
cp dist/emulator.css dist/www/
cp dist/loader.js dist/www/
cp dist/version.json dist/www/

# Serve complete UI
echo "Starting HTTP server, serving ./dist/www ..."
npx http-server ./dist/www -p 8080 -a 0.0.0.0
