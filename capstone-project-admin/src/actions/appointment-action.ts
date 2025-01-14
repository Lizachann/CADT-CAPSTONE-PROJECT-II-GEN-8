"use server";
import { API_ROUTE } from "@/constants/api-route-constant";
import { REVALIDATE_TAG_ENUM } from "@/constants/revalidate-tags-constant";
import { UpdateAppointmentDto } from "@/service/api-types";
import { fetchPostDefault } from "@/service/fetcher-service";
import { revalidateTag } from "next/cache";

export async function updateAppointment(
  id: string,
  updateAppointment: UpdateAppointmentDto
) {
  try {
    const res = await fetchPostDefault({
      url: `${API_ROUTE.BASE_APPOINTMENTS}/${id}`,
      body: updateAppointment,
      method: "PATCH",
    });

    revalidateTag(REVALIDATE_TAG_ENUM.APPOINTMENT);

    return res;
  } catch (e: any) {
    return e;
  }
}
