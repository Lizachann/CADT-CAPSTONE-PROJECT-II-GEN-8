export const wait = async (duration: number) => {
  return await new Promise((res) => setTimeout(res, duration));
};
