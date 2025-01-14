import { BadRequestException } from '@nestjs/common';
import { diskStorage } from 'multer';
import {
  STATIC_FILE_DESTINATION,
  MAX_FILE_COUNT,
  MAX_FILE_SIZE,
} from 'src/constants/multer-file-constant';

export type TFile = {
  fieldname: string;
  originalname: string;
  encoding: string;
  mimetype: string;
  size: number;
  destination: string;
  filename: string;
  path: string;
  buffer: Buffer;
};

const fileName = (
  _: any,
  file: TFile,
  callback: (error: Error | null, filename: string) => void,
) => {
  const uniquePrefix =
    'cp' + '-' + Date.now() + '-' + Math.round(Math.random() * 1e9);

  callback(null, uniquePrefix + '_' + file.originalname);
};

const fileFilter = (
  _: any,
  file: TFile,
  callback: (error: Error, acceptFile: boolean) => void,
) => {
  const validImageReg = new RegExp(/\.(jpg|jpeg|png|webp|svg)$/);
  if (!file.originalname || !file.originalname.match(validImageReg)) {
    return callback(
      new BadRequestException('File must be of type jpg|jpeg|png|webp|svg'),
      false,
    );
  }
  callback(null, true);
};

export const multerOptions = (path: string) => {
  return {
    dest: STATIC_FILE_DESTINATION + path,
    fileFilter: fileFilter,
    limits: {
      files: MAX_FILE_COUNT,
      fileSize: MAX_FILE_SIZE,
    },
    storage: diskStorage({
      filename: fileName,
      destination: STATIC_FILE_DESTINATION + path,
    }),
  };
};
