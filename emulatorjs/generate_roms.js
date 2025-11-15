// generate_roms.js
const fs = require('fs');
const path = require('path');

const romsDir = '/roms'; // mapped folder
const outputFile = path.join(__dirname, 'dist', 'roms.json');

function scanRoms(dir) {
  const roms = {};
  const systems = fs.readdirSync(dir, { withFileTypes: true });
  systems.forEach((system) => {
    if (system.isDirectory()) {
      const systemPath = path.join(dir, system.name);
      const files = fs.readdirSync(systemPath)
        .filter(f => f.endsWith('.zip'))
        .map(f => ({
          name: f,
          url: `/roms/${system.name}/${f}`
        }));
      roms[system.name] = files;
    }
  });
  return roms;
}

const romsData = scanRoms(romsDir);

// Make sure dist folder exists
if (!fs.existsSync(path.join(__dirname, 'dist'))) {
  fs.mkdirSync(path.join(__dirname, 'dist'));
}

fs.writeFileSync(outputFile, JSON.stringify(romsData, null, 2));
console.log(`roms.json created at ${outputFile}`);