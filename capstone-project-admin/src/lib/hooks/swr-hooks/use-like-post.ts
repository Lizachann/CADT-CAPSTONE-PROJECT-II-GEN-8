"use client";
import { API_ROUTE } from "@/constants/api-route-constant";
import { LikePostResponseDto } from "@/service/api-types";
import { fetcher } from "@/service/fetcher-service";
import useSWR from "swr";

export default function useLikePost(postId: string) {
  const { data, isLoading, mutate } = useSWR(
    `${API_ROUTE.LIKE_POSTS_BY_POSTS}/${postId}`,
    fetcher
  );

  const likePostData = data?.data as Array<LikePostResponseDto>;

  return {
    likePostData,
    isLoading,
    mutate,
  };
}
