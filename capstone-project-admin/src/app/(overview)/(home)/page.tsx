import { pageMetadata } from "@/utils/metadata-helpter"
import { Metadata } from "next"

export const metadata: Metadata = pageMetadata({
  title: "Home"
})

type Props = {}

function Home({ }: Props) {
  return (
    <div>
      Capstone Admin
    </div>
  )
}

export default Home