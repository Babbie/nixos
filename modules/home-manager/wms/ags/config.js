const entry = App.configDir + '/ts/main.ts';
const outDir = '/tmp/ags/js';
const cssDir = App.configDir + '/css';
const mainCssFile = cssDir + '/style.css';

try {
  await Utils.execAsync([
    'bun', 'build', entry,
    '--outdir', outDir,
    '--external', 'resource://*',
    '--external', 'gi://*',
  ]);
  Utils.monitorFile(cssDir, () => {
    App.resetCss();
    App.applyCss(mainCssFile);
  });
  await import(`file://${outDir}/main.js`);
} catch (error) {
  console.error(error);
}

export {}
