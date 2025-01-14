import { INestApplication } from '@nestjs/common';

export async function renderLogs(
  app: INestApplication<any>,
  swaggerRoutePrefix: string,
) {
  console.log(
    `(${process.env.ENV_MODE}) Api is running on: ${(await app.getUrl()).toString()}`,
  );
  console.log(
    `(${process.env.ENV_MODE}) Swagger is running on: ${(await app.getUrl()).toString()}/${swaggerRoutePrefix}`,
  );
}
