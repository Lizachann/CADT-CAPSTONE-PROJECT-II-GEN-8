"use server";
import { API_ROUTE } from "@/constants/api-route-constant";
import { REVALIDATE_TAG_ENUM } from "@/constants/revalidate-tags-constant";
import { CreateCreditDto, UpdateCreditDto } from "@/service/api-types";
import { fetchPostDefault } from "@/service/fetcher-service";
import { revalidateTag } from "next/cache";

export async function createCreditPackage(createCredit: CreateCreditDto) {
  const res = await fetchPostDefault({
    url: API_ROUTE.BASE_CREDIT,
    body: createCredit,
    method: "POST",
  }).then((res) => res);

  revalidateTag(REVALIDATE_TAG_ENUM.CREDIT);

  return res;
}

export async function updateCreditPackage(
  id: string,
  updateCredit: UpdateCreditDto
) {
  try {
    const res = await fetchPostDefault({
      url: `${API_ROUTE.BASE_CREDIT}/${id}`,
      body: updateCredit,
      method: "PATCH",
    });

    revalidateTag(REVALIDATE_TAG_ENUM.CREDIT);

    return res;
  } catch (e: any) {
    return e;
  }
}
