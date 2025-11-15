#!/usr/bin/env bash
set -e

cd /emulatorjs

echo "Skipping rebuild — using prebuilt dist/www"

# Generate roms.json dynamically from /roms
ROM_DIR="/roms"
OUTPUT_FILE="/emulatorjs/dist/www/roms.json"  # <- inside www

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

sed -i '$ s/,$//' "$OUTPUT_FILE"
echo "]" >> "$OUTPUT_FILE"

echo "roms.json generated at $OUTPUT_FILE (size: $(stat -c%s "$OUTPUT_FILE") bytes)"

# Start HTTP server serving the full UI
echo "Starting http-server on ./dist/www"
npx http-server ./dist/www -p 8080 -a 0.0.0.0
