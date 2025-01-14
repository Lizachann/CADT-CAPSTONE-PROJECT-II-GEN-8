// eslint-disable-next-line @typescript-eslint/no-var-requires
const fs = require('fs');

const ENV_MODE = process.env.ENV_MODE;
console.log('🚀 ~ ENV_MODE:', ENV_MODE);

fs.copyFile(`${process.cwd()}/env/${ENV_MODE}.env`, `.env`, (err) => {
  // fs.copyFile(`../env/${ENV_MODE}.env`, `.${ENV_MODE}.env`, (err) => {
  if (err) {
    console.log(`Error while copying ${ENV_MODE}.env`, err);
  } else {
    console.log(`Copied from ${ENV_MODE}.env to .env successfully`);
  }
});
