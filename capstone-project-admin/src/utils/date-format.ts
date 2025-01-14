import dayjs from "dayjs";

export const dateFormat = ({
  date,
  formatType,
  formatTime,
}: {
  date: string;
  formatType?: "DD-MM-YYYY" | "DD/MM/YYYY";
  formatTime?: "hh:mm:ss" | "hh:mm";
}) => {
  const newDate = dayjs(date).format(formatType ?? "DD/MM/YYYY");
  const newTime = dayjs(date).format(`${formatTime} A` ?? "hh:mm:ss");

  return {
    newDate,
    newTime,
  };
};
