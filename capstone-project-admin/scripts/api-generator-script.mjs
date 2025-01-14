import { exec } from "child_process";
import { series } from "async";

if (process.env.NEXT_PUBLIC_GEN_API_URL === undefined) {
  throw new Error("Missing GEN_API_URL");
}

const interfaceGeneratorScripts = () => {
  console.log(
    `Generating swagger-json from ${process.env.NEXT_PUBLIC_GEN_API_URL}`
  );
  series([
    () => {
      exec(
        `yarn openapi-typescript ${process.env.NEXT_PUBLIC_GEN_API_URL} --output src/generators/api-generator.d.ts`,
        (error, stdout, stderr) => {
          if (error) {
            console.error(`exec error: ${error}`);
            return;
          }
          console.log(`stdout: ${stdout}`);
          if (stderr) {
            console.error(`stderr: ${stderr}`);
          }
        }
      );
    },
  ]);
};

interfaceGeneratorScripts();
