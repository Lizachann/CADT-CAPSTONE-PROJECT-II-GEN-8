export enum API_ROUTE {
  //Patient Routes
  BASE_PATIENT = "/patients",
  BAN_PATIENT = "/patients/ban-patient",
  UNBAN_PATIENT = "/patients/unban-patient",

  //Therapist Routes
  BASE_THERAPIST = "/therapists",

  //Credits Routes
  BASE_CREDIT = "/credits",
  ALL_CREDIT = "/credits/all",

  /** Posts */
  BASE_POSTS = "/posts",

  /** Like posts */
  BASE_LIKE_POSTS = "/like-posts",
  LIKE_POSTS_BY_POSTS = "/like-posts/by-post",

  GET_ALL_SPECIALIZATIONS = "/therapists/specializations",

  //Therapist Routes
  BASE_APPOINTMENTS = "/appointments",

  //Stripe Routes
  ALL_CHARGES = "/stripe/charges",
  BALANCES = "/stripe/balance",

  // Auth
  ADMIN_LOGIN = "/auth/admin/login",
  ADMIN_LOGOUT = "/auth/admin/logout",
}
