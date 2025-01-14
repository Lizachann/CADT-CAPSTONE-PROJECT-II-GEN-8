import { join } from 'path';

const oneKb = 1024;
const oneMb = oneKb * 1024;
const maxSize = 5 * oneMb;

const baseFilePath = join(__dirname, '..', '..', 'public');

export const PostPhotosPath = '/postPhotos';
export const TherapistApplicationPhotosPath = '/therapistApplicationPhotos';
export const AcitvitiesImagesPath = '/activitiesImages';

export const STATIC_FILE_DESTINATION = baseFilePath;
export const MAX_FILE_SIZE = maxSize;
export const MAX_FILE_COUNT = 10;
