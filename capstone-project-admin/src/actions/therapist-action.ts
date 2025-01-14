"use server";
import { API_ROUTE } from "@/constants/api-route-constant";
import { REVALIDATE_TAG_ENUM } from "@/constants/revalidate-tags-constant";
import { CreateTherapistDto, UpdateTherapistDto } from "@/service/api-types";
import { fetchPostDefault } from "@/service/fetcher-service";
import { revalidateTag } from "next/cache";

export async function createTherapist(createTherapist: CreateTherapistDto) {
  const res = await fetchPostDefault({
    url: API_ROUTE.BASE_THERAPIST,
    body: createTherapist,
    method: "POST",
  }).then((res) => res);

  revalidateTag(REVALIDATE_TAG_ENUM.THERAPIST);
  return res;
}

export async function updateTherapist(id: string, updateTherapist: UpdateTherapistDto) {
  const res = await fetchPostDefault({
    url: `${API_ROUTE.BASE_THERAPIST}/${id}`,
    body: updateTherapist,
    method: "PATCH",
  }).then((res) => res);

  revalidateTag(REVALIDATE_TAG_ENUM.THERAPIST);
  return res;
}
