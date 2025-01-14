import EmptyData from "../ui/empty-data";
import AppointmentCard from "./appointment-card";
import { getAppointments } from "@/service/get-service";

type Props = {
  searchParams: {
    status: string;
  };
};

async function ListAppointment({ searchParams }: Props) {
  const { data: appointments } = await getAppointments(searchParams);

  if (!appointments || appointments?.length === 0) {
    return <EmptyData />;
  }

  return <AppointmentCard appointments={appointments} />;
}

export default ListAppointment;
