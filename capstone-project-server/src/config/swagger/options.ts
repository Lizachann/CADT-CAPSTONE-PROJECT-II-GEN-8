import { DocumentBuilder } from '@nestjs/swagger';
import * as project from 'package.json';

export const documentBuilderOptions = new DocumentBuilder()
  .addServer(process.env.API_BASE_URL)
  .addBearerAuth()
  .setTitle(project.name)
  .setDescription(`API documents (${process.env.ENV_MODE})`)
  .setVersion(project.version)
  .build();
