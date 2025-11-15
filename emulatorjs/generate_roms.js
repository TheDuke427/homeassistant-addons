const fs = require('fs');
const path = require('path');

const romDir = '/roms';
const roms = [];

// Scan categories
fs.readdirSync(romDir).forEach(category => {
  const categoryPath = path.join(romDir, category);
  if (fs.statSync(categoryPath).isDirectory()) {
    const files = fs.readdirSync(categoryPath)
      .filter(f => f.endsWith('.zip'))
      .map(f => ({
        name: f.replace('.zip',''),
        path: `/${category}/${f}`,
        system: category
      }));
    roms.push(...files);
  }
});

// Write JSON to dist folder
fs.writeFileSync('/emulatorjs/dist/roms.json', JSON.stringify(roms, null, 2));
console.log('roms.json generated');