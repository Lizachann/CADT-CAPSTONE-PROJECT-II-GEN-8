import * as Yup from "yup";

export const creditSchema = Yup.object({
  title: Yup.string()
    .required("Title is required")
    .min(2, "Title must be at least 2 characters"),
  points: Yup.number()
    .typeError("Points must be a number")
    .required("Points is required"),
  price: Yup.number()
    .typeError("Price must be a number")
    .required("Price is required"),
  discount: Yup.number().typeError("Discount must be a number").default(0),
});
