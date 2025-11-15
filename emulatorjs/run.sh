#!/usr/bin/env bash
set -e

# Go to EmulatorJS folder
cd /emulatorjs

# Make sure EmulatorJS is built
npm install
npm run build

# === Generate roms.json dynamically ===
ROM_DIR="/roms"  # this is your mapped folder from config.json
OUTPUT_FILE="./dist/www/roms.json"  # where EmulatorJS expects it

echo "Generating roms.json from $ROM_DIR ..."

# Start JSON array
echo "[" > "$OUTPUT_FILE"

# Loop through subfolders (like SNES, NES, etc.)
for SYSTEM in "$ROM_DIR"/*; do
  if [ -d "$SYSTEM" ]; then
    SYSTEM_NAME=$(basename "$SYSTEM")
    # Loop through .zip files
    for ROM in "$SYSTEM"/*.zip; do
      [ -e "$ROM" ] || continue  # skip if no zip files
      ROM_NAME=$(basename "$ROM")
      echo "  {\"name\": \"$ROM_NAME\", \"system\": \"$SYSTEM_NAME\", \"url\": \"/roms/$SYSTEM_NAME/$ROM_NAME\"}," >> "$OUTPUT_FILE"
    done
  fi
done

# Remove trailing comma and close JSON array
sed -i '$ s/,$//' "$OUTPUT_FILE"
echo "]" >> "$OUTPUT_FILE"

echo "roms.json generated with $(jq length "$OUTPUT_FILE") entries."

# === Start HTTP server to serve UI ===
npx http-server ./dist/www -p 8080 -a 0.0.0.0
