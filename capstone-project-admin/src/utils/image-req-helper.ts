export const imageReqHelper = (filename: string) => {
  return process.env.NEXT_PUBLIC_API_ROUTE + "/postPhotos/" + filename;
};

export const therapistApplicationPhotosHelper = (filename: string) => {
  return (
    process.env.NEXT_PUBLIC_API_ROUTE +
    "/therapistApplicationPhotos/" +
    filename
  );
};

export const logo =
  "https://raw.githubusercontent.com/Capstone-Project-Two/assets/main/chhantek-logo.png";
