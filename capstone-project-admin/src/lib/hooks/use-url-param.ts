"use client";

import { URL_PARAM } from "@/constants/url-param-constant";
import { useRouter } from "next-nprogress-bar";
import { usePathname, useSearchParams } from "next/navigation";
import { useEffect } from "react";

type TUpdateUrlParam = {
  paramName: URL_PARAM;
  paramValue: string;
};

export default function useUrlParam() {
  const router = useRouter();
  const searchParams = useSearchParams();
  const pathname = usePathname();

  useEffect(() => {
    updateUrlParam({
      paramName: URL_PARAM.PAGE,
      paramValue: searchParams.get(URL_PARAM.PAGE) ?? "1",
    });
    // eslint-disable-next-line react-hooks/exhaustive-deps
  }, []);

  const updateUrlParam = ({ paramName, paramValue }: TUpdateUrlParam) => {
    const params = new URLSearchParams(searchParams);

    if (paramValue.trim() === "" || paramValue) {
      params.delete(paramName);
    }

    params.delete("page");
    params.set(paramName, paramValue);

    router.push(`${pathname}?${params.toString()}`);
  };

  const getAllParams = () => {
    const params = new URLSearchParams(searchParams);
    return params.toString();
  };

  const getParamValue = ({ paramName }: { paramName: string }) => {
    return searchParams.get(paramName)?.toString();
  };

  const removeUrlParam = ({ paramName }: { paramName: Array<string> }) => {
    const params = new URLSearchParams(searchParams);
    paramName.forEach((name) => {
      params.delete(name);
    });

    router.push(`${pathname}?${params.toString()}`);
  };

  const getFullPath = (): string => {
    const params = new URLSearchParams(searchParams);
    params.delete("page");

    const path = `${pathname}?${params.toString()}`;
    return path;
  };

  return {
    getFullPath,
    updateUrlParam,
    getAllParams,
    removeUrlParam,
    getParamValue,
  };
}
