import { getCharges } from "@/service/get-service";
import EmptyData from "../ui/empty-data";
import ChargesTable from "./charges-table";

type Props = {};

async function ListCharges({}: Props) {
  const { data: charges } = await getCharges();

  if (!charges || charges.length === 0) {
    return <EmptyData />;
  }

  return <ChargesTable charges={charges} />;
}

export default ListCharges;
