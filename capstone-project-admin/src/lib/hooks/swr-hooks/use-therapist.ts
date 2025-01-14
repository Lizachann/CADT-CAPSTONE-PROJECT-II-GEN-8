"use client";
import { API_ROUTE } from "@/constants/api-route-constant";
import { TherapistResponseDto } from "@/service/api-types";
import { fetcher } from "@/service/fetcher-service";
import useSWR from "swr";

export default function useTherapist(id: string) {
  const { data, isLoading, mutate } = useSWR(
    `${API_ROUTE.BASE_THERAPIST}/${id}`,
    fetcher
  );

  const therapistData = data?.data as TherapistResponseDto;

  return {
    therapistData,
    isLoading,
    mutate,
  };
}