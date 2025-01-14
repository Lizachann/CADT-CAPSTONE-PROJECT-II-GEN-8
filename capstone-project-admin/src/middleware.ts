import { auth } from "./auth";
import { ROUTER_PATH } from "./constants/route-constant";

export default auth(async (req) => {
  const session = req.auth;
  if (!session && req.nextUrl.pathname !== ROUTER_PATH.LOGIN) {
    const redirectUrl = new URL(ROUTER_PATH.LOGIN, req.nextUrl.origin);
    redirectUrl.searchParams.append("callbackUrl", req.nextUrl.pathname);
    return Response.redirect(redirectUrl);
  }
});

export const config = {
  matcher: ["/((?!api|_next/static|_next/image|favicon.ico).*)"],
};
