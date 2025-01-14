import { getCredits } from "@/service/get-service"
import EmptyData from "../ui/empty-data"
import CreditTable from "./credit-table"

type Props = {}

async function ListCredit({ }: Props) {
  const { data: credits } = await getCredits()

  if (!credits || credits.length === 0) {
    return (
      <EmptyData />
    )
  }

  return (
    <CreditTable credits={credits} />
  )
}

export default ListCredit
