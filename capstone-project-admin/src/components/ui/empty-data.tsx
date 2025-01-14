import { Empty } from "antd"

type Props = {}

function EmptyData({ }: Props) {
  return (
    <div className="flex h-[70vh] items-center justify-center">
      <Empty />
    </div>
  )
}

export default EmptyData