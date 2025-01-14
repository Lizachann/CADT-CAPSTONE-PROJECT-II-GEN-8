import * as Yup from "yup";

export const managePrescriptionSchema = Yup.object({
  note: Yup.string().required("Note is required."),
  prescriptions: Yup.string(),
});
