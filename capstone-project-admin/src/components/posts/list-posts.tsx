import { Space } from "antd";
import PaginationUi from "../ui/pagination";
import PostCard from "./post-card";
import { getPosts } from "@/service/get-service";
import EmptyData from "../ui/empty-data";

type Props = {
  searchParams: {
    page: string;
  };
};

async function ListPosts({ searchParams }: Props) {
  const currentPage = Number(searchParams.page) ?? 1;
  const { data: posts, meta } = await getPosts({ page: currentPage });

  if (!posts || posts.length === 0) {
    return <EmptyData />;
  }

  return (
    <Space direction="vertical" size={"middle"} className="w-full">
      <div className="flex flex-col gap-4">
        {posts.map((post) => (
          <PostCard key={post._id} post={post} />
        ))}
      </div>
      <PaginationUi
        className="flex justify-end"
        totalPages={meta?.totalPages}
        totalItems={meta?.totalItems}
        currentPage={Number(searchParams.page) ?? 1}
      />
    </Space>
  );
}

export default ListPosts;
