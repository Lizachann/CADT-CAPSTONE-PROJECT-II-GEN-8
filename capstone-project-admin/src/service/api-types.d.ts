import { components } from "@/generators/api-generator";
type GenApi = components["schemas"];

export type AdminResponseDto = GenApi["AdminResponseDto"];
export type PatientResponseDto = GenApi["PatientResponseDto"];
export type CreatePatientDto = GenApi["CreatePatientDto"];
export type UpdatePatientDto = GenApi["UpdatePatientDto"];
export type TherapistResponseDto = GenApi["TherapistResponseDto"];
export type CreateTherapistDto = GenApi["CreateTherapistDto"];
export type UpdateTherapistDto = GenApi["UpdateTherapistDto"];
export type AppointmentResponseDto = GenApi["AppointmentResponseDto"];
export type UpdateAppointmentDto = GenApi["UpdateAppointmentDto"];
export type CreateTherapistDto = GenApi["CreateTherapistDto"];
export type CreateCreditDto = GenApi["CreateCreditDto"];
export type UpdateCreditDto = GenApi["UpdateCreditDto"];
export type CreditReponseDto = GenApi["CreditReponseDto"];
export type RelationalPatientResponseDto =
  GenApi["RelationalPatientResponseDto"];
export type PostResponseDto = GenApi["PostResponseDto"];
export type UpdateLikePostDto = GenApi["UpdateLikePostDto"];
export type LikePostResponseDto = GenApi["LikePostResponseDto"];
export type UpdateTherapistDto = GenApi["UpdateTherapistDto"];
export type CreatePostDto = GenApi["CreatePostDto"];
export type RelationalPostResponseDto = GenApi["RelationalPostResponseDto"];
export type LoginDto = GenApi['LoginDto']
