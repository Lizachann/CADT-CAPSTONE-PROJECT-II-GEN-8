const { exec } = require('child_process');

function runSeed() {
  console.log('Running Seed...');
  exec(
    'curl --location --request POST http://localhost:8080/seeds',
    (error, stdout, stderr) => {
      if (error) {
        console.error(`Error: ${error}`);
        return;
      }
      if (stderr) {
        console.error(`stderr: ${stderr}`);
        return;
      }
      console.log(`stdout: ${stdout}`);
    },
  );
}

runSeed();
