import { BASE_API_URL } from "@/constants/env-constant";

export const fetcher = (url: string) =>
  fetchDefault({ url }).then((res: any) => {
    return res;
  });

export async function fetchDefault({
  url,
  tags,
  revalidate,
}: {
  url: string;
  tags?: Array<string>;
  revalidate?: number;
}) {
  try {
    const res = await fetch(`${BASE_API_URL}${url}`, {
      method: "GET",
      cache: "no-store",
      headers: {
        "Content-type": "application/json",
      },
      next: {
        tags: tags,
        revalidate: revalidate,
      },
    });

    if (!res.ok) {
      const errorRes = await res.json();
      throw errorRes;
    }

    return res.json();
  } catch (e) {
    throw e;
  }
}

export async function fetchPostDefault({
  url,
  method,
  body,
}: {
  url: string;
  method: "POST" | "PATCH" | "DELETE";
  body?: any;
}) {
  try {
    const res = await fetch(`${BASE_API_URL}${url}`, {
      body: JSON.stringify(body),
      method: method,
      headers: {
        "Content-type": "application/json",
      },
    });

    if (!res.ok) {
      const errorRes = await res.json();
      throw errorRes;
    }

    return res.json();
  } catch (e) {
    throw e;
  }
}

export async function fetchPostMultipart({
  url,
  method,
  body,
}: {
  url: string;
  method: "POST" | "PATCH" | "DELETE";
  body?: any;
}) {
  try {
    const res = await fetch(`${BASE_API_URL}${url}`, {
      body: body,
      method: method,
    });

    if (!res.ok) {
      const errorRes = await res.json();
      throw errorRes;
    }

    return res.json();
  } catch (e) {
    throw e;
  }
}
