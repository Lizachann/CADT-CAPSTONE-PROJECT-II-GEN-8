"use server";

import { signIn, signOut } from "../auth";
import { ROUTER_PATH } from "@/constants/route-constant";
import { fetchDefault } from "./fetcher-service";
import { API_ROUTE } from "@/constants/api-route-constant";
import { LoginDto } from "./api-types";
import { BASE_API_URL } from "@/constants/env-constant";

export const adminLogin = async (loginDto: LoginDto) => {
  const res = await fetch(`${BASE_API_URL}${API_ROUTE.ADMIN_LOGIN}`, {
    body: JSON.stringify(loginDto),
    method: "post",
    headers: {
      "Content-type": "application/json",
    },
  });

  return res.json();
};

export const adminLogout = async () => {
  try {
    const res = await fetchDefault({
      url: API_ROUTE.ADMIN_LOGOUT,
    });

    return res;
  } catch (e) {
    throw e;
  }
};

export const authSignIn = async (
  formData: {
    email: string;
    password: string;
  },
  callbackUrl: string
) => {
  await signIn("credentials", {
    redirectTo: callbackUrl ?? ROUTER_PATH.HOMEPAGE,
    ...formData,
  });
};

export const authSignOut = async () => {
  await signOut({ redirectTo: ROUTER_PATH.LOGIN })
    .then(async () => {
      await adminLogout();
    })
    .catch((err) => {
      throw err;
    });
};
