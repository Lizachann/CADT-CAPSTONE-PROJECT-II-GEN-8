import { ROUTER_PATH } from "@/constants/route-constant";
import { adminLogin } from "@/service/auth-service";
import NextAuth, { NextAuthConfig } from "next-auth";
import Credentials from "next-auth/providers/credentials";
import { isOkStatusCode } from "./utils/helper";

export const authConfig = {
  debug: process.env.ENV_MODE === "development",
  pages: {
    signIn: ROUTER_PATH.LOGIN,
  },
  providers: [
    Credentials({
      credentials: {
        email: {},
        password: {},
      },
      authorize: async (credentials) => {
        try {
          const user = await adminLogin({
            email: credentials.email as string,
            password: credentials.password as string,
          });

          if (!isOkStatusCode(user?.statusCode) || !user.data?.admin) {
            // return null;
            throw user;
          }

          return user.data?.admin;
        } catch (err) {
          return null;
        }
      },
    }),
  ],
  session: {
    strategy: "jwt",
  },
  callbacks: {
    async jwt({ token, user }) {
      if (user) {
        token.id = user._id;
        token.username = user.username;
        token.email = user.credential.email;
        token.roles = user.roles;
        token.profile_img = user.profile_img;
      }
      return token;
    },
    async session({ session, token }) {
      if (token) {
        session.user.name = token.username as string;
        session.user.image = token.profile_img as string;
        session.user.id = token.id as string;
        session.user.username = token.username as string;
        session.user.roles = token.roles as Array<string>;
      }
      return session;
    },
  },
} satisfies NextAuthConfig;

export const { handlers, signIn, signOut, auth } = NextAuth(authConfig);
