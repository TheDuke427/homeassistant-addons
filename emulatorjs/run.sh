#!/usr/bin/env bash
set -e

cd /emulatorjs

echo "Using prebuilt dist/ — skipping rebuild"

# === Generate roms.json dynamically ===
ROM_DIR="/roms"
OUTPUT_FILE="/emulatorjs/data/roms.json"  # writable folder

echo "Generating roms.json from $ROM_DIR ..."

# Start JSON array
echo "[" > "$OUTPUT_FILE"

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

# Remove trailing comma and close array
sed -i '$ s/,$//' "$OUTPUT_FILE"
echo "]" >> "$OUTPUT_FILE"

echo "roms.json generated at $OUTPUT_FILE"

# === Start HTTP server serving original dist/www ===
npx http-server ./dist/www -p 8080 -a 0.0.0.0
