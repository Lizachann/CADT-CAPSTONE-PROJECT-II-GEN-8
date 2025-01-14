import { type DefaultSession } from "next-auth";
declare module "next-auth" {
  interface Session {
    user: {
      _id: string;
      username: string;
      roles: Array<string>;
      credential: {
        email?: string;
        password?: string;
      };
      refresh_token: string;
    } & DefaultSession["user"];
  }

  interface User {
    _id: string;
    profile_img: string;
    username: string;
    credential: {
      email: string;
      password: string;
    };
    roles: Array<string>;
  }
}

export type TMeta = {
  totalItems: number;
  totalPages: number;
  itemsPerPage: number;
  currentPage: number;
  currentPageItems: number;
};

export type TError = {
  statusCode: number;
  timeStamp: Date;
  path: String;
  errorType: String;
  validationMessages: Array<string>;
  messages: Array<string>;
};
