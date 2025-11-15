#!/usr/bin/env bash
set -e

cd /emulatorjs

echo "=== STARTUP: container $(date) ==="

echo "--- Working directory: /emulatorjs ---"
ls -la /emulatorjs || true

echo "--- dist/ ---"
ls -la /emulatorjs/dist || true

echo "--- dist/www/ ---"
ls -la /emulatorjs/dist/www || true

echo "--- data/ (where roms.json will be written) ---"
mkdir -p /emulatorjs/data
ls -la /emulatorjs/data || true

# Generate roms.json dynamically (from mounted /roms)
ROM_DIR="/roms"
OUTPUT_FILE="/emulatorjs/dist/www/roms.json"  # writable location in container

echo "Generating roms.json from $ROM_DIR ..."

# Start JSON array
echo "[" > "$OUTPUT_FILE"

# Loop through systems like SNES, NES
for SYSTEM in "$ROM_DIR"/*; do
  if [ -d "$SYSTEM" ]; then
    SYSTEM_NAME=$(basename "$SYSTEM")
    for ROM in "$SYSTEM"/*.zip "$SYSTEM"/*.nes "$SYSTEM"/*.sfc "$SYSTEM"/*.smc; do
      [ -e "$ROM" ] || continue
      ROM_NAME=$(basename "$ROM")
      echo "  {\"name\": \"$ROM_NAME\", \"system\": \"$SYSTEM_NAME\", \"url\": \"/roms/$SYSTEM_NAME/$ROM_NAME\"}," >> "$OUTPUT_FILE"
    done
  fi
done

# Remove trailing comma safely (only if file has >1 lines)
if [ $(wc -l < "$OUTPUT_FILE") -gt 1 ]; then
  sed -i '$ s/,$//' "$OUTPUT_FILE"
fi
echo "]" >> "$OUTPUT_FILE"

echo "roms.json generated at $OUTPUT_FILE (size: $(stat -c%s "$OUTPUT_FILE") bytes)"
echo "---- roms.json preview ----"
head -n 40 "$OUTPUT_FILE" || true
echo "---- end preview ----"

# If an index exists in dist/www prefer that path, else use dist
if [ -f ./dist/www/index.html ]; then
  SERVE_DIR="./dist/www"
elif [ -f ./dist/index.html ]; then
  SERVE_DIR="./dist"
else
  # fallback: if dist/www exists but index doesn't, still serve dist/www
  SERVE_DIR="./dist/www"
fi

echo "Starting http-server serving $SERVE_DIR on :8080"
npx http-server "$SERVE_DIR" -p 8080 -a 0.0.0.0
