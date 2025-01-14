import CreatePostModal from "@/components/posts/create-post-modal"
import ListPosts from "@/components/posts/list-posts"
import { Space, Spin } from "antd"
import { Suspense } from "react"

type Props = {
  searchParams: {
    page: string;
  }
}

async function PostPage({ searchParams }: Props) {
  return (
    <Space size={"middle"} direction="vertical" className="w-full">
      <h1 className="text-2xl font-bold">Posts</h1>
      <CreatePostModal />
      <Suspense fallback={<Spin />}>
        <ListPosts searchParams={searchParams} />
      </Suspense>
    </Space>
  )
}

export default PostPage