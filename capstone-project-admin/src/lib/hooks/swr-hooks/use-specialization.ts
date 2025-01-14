"use client";
import { API_ROUTE } from "@/constants/api-route-constant";
import { fetcher } from "@/service/fetcher-service";
import useSWR from "swr";

export default function useSpecialization() {
  const { data, isLoading, mutate } = useSWR(
    `${API_ROUTE.GET_ALL_SPECIALIZATIONS}`,
    fetcher
  );

  const specializations = data?.data as Array<string>;

  return {
    specializations,
    isLoading,
    mutate,
  };
}