export function isValidResponse(statusCode: number) {
  return statusCode >= 200 && statusCode <= 299;
}