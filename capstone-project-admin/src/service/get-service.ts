import { API_ROUTE } from "@/constants/api-route-constant";
import { REVALIDATE_TAG_ENUM } from "@/constants/revalidate-tags-constant";
import { URL_PARAM } from "@/constants/url-param-constant";
import {
  AppointmentResponseDto,
  CreditReponseDto,
  LikePostResponseDto,
  RelationalPatientResponseDto,
  RelationalPostResponseDto,
  TherapistResponseDto,
} from "@/service/api-types";
import { fetchDefault } from "@/service/fetcher-service";
import { TMeta } from "@/types/types";
import { isValidResponse } from "@/utils/validate-response";

type TPagination = {
  page?: number;
  limit?: number;
};

type FilterParams = {
  status?: string;
};

export const getPatients = async ({ page = 1, limit = 10 }: TPagination) => {
  const res = await fetchDefault({
    url: `${API_ROUTE.BASE_PATIENT}?${URL_PARAM.PAGE}=${page}&limit=${limit}`,
    tags: [REVALIDATE_TAG_ENUM.PATIENT],
  });

  return {
    error: !isValidResponse(res?.statusCode) && res,
    message: res?.message,
    data: res?.data as Array<RelationalPatientResponseDto>,
    statusCode: res?.statusCode,
    meta: res?.meta as TMeta,
  };
};

export const getPosts = async ({ page = 1, limit = 10 }: TPagination) => {
  const res = await fetchDefault({
    url: `${API_ROUTE.BASE_POSTS}?${URL_PARAM.PAGE}=${page}&limit=${limit}`,
    tags: [REVALIDATE_TAG_ENUM.POST],
  });

  return {
    message: res?.message,
    data: res?.data as Array<RelationalPostResponseDto>,
    statusCode: res?.statusCode,
    meta: res?.meta as TMeta,
  };
};

export const getLikePosts = async () => {
  const res = await fetchDefault({
    url: API_ROUTE.BASE_LIKE_POSTS,
    tags: [REVALIDATE_TAG_ENUM.LIKE_POST],
  });

  return {
    message: res?.message,
    data: res?.data as Array<LikePostResponseDto>,
    statusCode: res?.statusCode,
  };
};

export const getLikePostByPost = async ({ postId }: { postId: string }) => {
  const res = await fetchDefault({
    url: `${API_ROUTE.LIKE_POSTS_BY_POSTS}/${postId}`,
    tags: [REVALIDATE_TAG_ENUM.LIKE_POST],
  });

  return {
    message: res?.message,
    data: res?.data as Array<LikePostResponseDto>,
    statusCode: res?.statusCode,
    meta: res?.meta as TMeta,
  };
};

export const getTherapists = async () => {
  const res = await fetchDefault({
    url: API_ROUTE.BASE_THERAPIST,
    tags: [REVALIDATE_TAG_ENUM.THERAPIST],
  });

  return {
    error: !isValidResponse(res?.statusCode) && res,
    message: res?.message,
    data: res?.data as Array<TherapistResponseDto>,
    statusCode: res?.statusCode,
  };
};

export const getTherapistApplications = async () => {
  const res = await fetchDefault({
    url: `${API_ROUTE.BASE_THERAPIST}/registration`,
    tags: [REVALIDATE_TAG_ENUM.THERAPIST],
  });

  return {
    error: !isValidResponse(res?.statusCode) && res,
    message: res?.message,
    data: res?.data,
    statusCode: res?.statusCode,
  };
};

export const getCredits = async () => {
  const res = await fetchDefault({
    url: API_ROUTE.ALL_CREDIT,
    tags: [REVALIDATE_TAG_ENUM.CREDIT],
  });

  return {
    error: !isValidResponse(res?.statusCode) && res,
    message: res?.message,
    data: res?.data as Array<CreditReponseDto>,
    statusCode: res?.statusCode,
  };
};

export const getCharges = async () => {
  const res = await fetchDefault({
    url: API_ROUTE.ALL_CHARGES,
    tags: [REVALIDATE_TAG_ENUM.STRIPE],
  });

  return {
    error: !isValidResponse(res?.statusCode) && res,
    message: res?.message,
    data: res?.data,
    statusCode: res?.statusCode,
  };
};

export const getBalances = async () => {
  const res = await fetchDefault({
    url: API_ROUTE.BALANCES,
    tags: [REVALIDATE_TAG_ENUM.STRIPE],
  });

  return {
    error: !isValidResponse(res?.statusCode) && res,
    message: res?.message,
    data: res?.data,
    statusCode: res?.statusCode,
  };
};

export const getAppointments = async ({ status }: FilterParams) => {
  const res = await fetchDefault({
    url: `${API_ROUTE.BASE_APPOINTMENTS}?${URL_PARAM.STATUS}=${
      !status ? "" : status
    }`,
    tags: [REVALIDATE_TAG_ENUM.APPOINTMENT],
  });

  return {
    message: res?.message,
    data: res?.data as Array<AppointmentResponseDto>,
    statusCode: res?.statusCode,
  };
};
