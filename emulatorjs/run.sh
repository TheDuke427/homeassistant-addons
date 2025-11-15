#!/usr/bin/env bash
set -e

echo "=== STARTUP: container $(date) ==="
cd /emulatorjs

echo "Skipping rebuild — using prebuilt dist/www"

# === Generate roms.json dynamically ===
ROM_DIR="/roms"                # mapped folder from HA config
OUTPUT_FILE="/emulatorjs/dist/www/roms.json"  # EmulatorJS expects it here

echo "Generating roms.json from $ROM_DIR ..."

# Make sure the file exists
mkdir -p "$(dirname "$OUTPUT_FILE")"
echo "[" > "$OUTPUT_FILE"

# Loop through system folders (SNES, NES, etc.)
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

# Remove trailing comma and close JSON array
sed -i '$ s/,$//' "$OUTPUT_FILE"
echo "]" >> "$OUTPUT_FILE"

echo "roms.json generated at $OUTPUT_FILE (size: $(stat -c%s "$OUTPUT_FILE") bytes)"

# === Start HTTP server ===
echo "Starting http-server serving ./dist/www on :8080"
npx http-server ./dist -p 8080 -a 0.0.0.0
