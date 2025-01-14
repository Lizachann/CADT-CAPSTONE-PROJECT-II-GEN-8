import { getTherapists } from "@/service/get-service"
import EmptyData from "../ui/empty-data"
import TherapistTable from "./therapist-table"

type Props = {}

async function ListTherapist({ }: Props) {
  const { data: therapists } = await getTherapists()

  if (!therapists || therapists.length === 0) {
    return (
      <EmptyData />
    )
  }

  return (
    <TherapistTable therapists={therapists} />
  )
}

export default ListTherapist