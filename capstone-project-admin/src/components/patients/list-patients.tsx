import { getPatients } from "@/service/get-service"
import PatientTable from "./patient-table"
import EmptyData from "../ui/empty-data"
import PaginationUi from "../ui/pagination"

type Props = {
  searchParams: {
    page: string
  }
}

async function ListPatients({ searchParams }: Props) {
  const { data: patients, meta } = await getPatients({ page: Number(searchParams.page) })

  if (!patients || patients.length === 0) {
    return (
      <EmptyData />
    )
  }

  return (
    <div className="flex flex-col gap-4 items-end">
      <PatientTable patients={patients} />
      <PaginationUi
        totalPages={meta?.totalPages}
        totalItems={meta?.totalItems}
        currentPage={Number(searchParams.page) ?? 1}
      />
    </div>
  )
}

export default ListPatients