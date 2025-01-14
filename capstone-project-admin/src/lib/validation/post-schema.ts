import * as Yup from "yup";

export const postSchema = Yup.object().shape(
  {
    body: Yup.mixed().when(["postPhotos"], {
      is: (postPhotos: []) => {
        return postPhotos.length === 0 || !postPhotos;
      },
      then: (schema) => schema.required("Body is required"),
    }),
    postPhotos: Yup.mixed().when(["body"], {
      is: (body: string) => !body || body.trim()?.length === 0,
      then: (schema) => schema.required(),
    }),
  },
  [
    ["body", "postPhotos"],
    ["postPhotos", "body"],
  ]
);
