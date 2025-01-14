import * as Yup from 'yup'

export const therapistSchema = Yup.object({
  first_name: Yup.string()
    .required("First name is required")
    .min(2, "First name must be at least 2 characters"),
  last_name: Yup.string()
    .required("Last name is required")
    .min(2, "Last name must be at least 2 characters"),
  bio: Yup.string(),
  gender: Yup.string().required("Gender is required"),
  username: Yup.string()
    .required("Username is required")
    .min(3, "Username must be at least 3 characters"),
  phone_number: Yup.number().required("Phone number is required"),
  email: Yup.string()
    .required("Email is required")
    .email("Invalid email address"),
  specializations: Yup.array(),
});
