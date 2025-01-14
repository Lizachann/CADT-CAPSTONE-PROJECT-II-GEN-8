import { UploadFile } from "antd";
import { RcFile } from "antd/es/upload";

export function convertRcFileToUploadFile(rcFiles: RcFile[]): UploadFile[] {
  const fileList: UploadFile[] = [];
  rcFiles.forEach((file) => {
    fileList.push({
      uid: file.uid,
      name: file.name,
      status: "done",
      originFileObj: file,
    });
  });
  return fileList;
}

export const isOkStatusCode = (statusCode: number) => {
  return statusCode >= 200 && statusCode <= 299;
};
