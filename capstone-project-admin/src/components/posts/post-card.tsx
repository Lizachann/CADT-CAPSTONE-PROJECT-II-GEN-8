"use client";
import { likePost } from "@/actions/post-action";
import useLikePost from "@/lib/hooks/swr-hooks/use-like-post";
import { RelationalPostResponseDto } from "@/service/api-types";
import { Button, Carousel, Divider, Space } from "antd";
import { useTransition } from "react";
import BaseImage from "../ui/base-image";
import dayjs from "dayjs";
import { cn } from "@/lib/utils";
import { imageReqHelper } from "@/utils/image-req-helper";

type Props = {
  post: RelationalPostResponseDto;
};

function PostCard({ post }: Props) {
  const { patient } = post;
  const { likePostData, isLoading, mutate } = useLikePost(post._id);

  const [isPending, startTransition] = useTransition();
  const handleLike = () => {
    startTransition(async () => {
      await likePost({
        patient: "72706f6e670123456789abcd",
        post: post._id,
      }).then(() => {
        mutate();
      });
    });
  };

  return (
    <Space
      direction="vertical"
      className="border rounded-md p-4 lg:max-h-[200px] max-w-[1400px]"
    >
      <div className="lg:flex flex lg:flex-row flex-col w-full gap-2 items-center">
        <Wrapper className="flex items-center">
          <div className="flex xl:flex-row flex-col gap-2">
            <BaseImage
              src={patient.profile_img}
              width={48}
              height={48}
              alt={patient.username}
              className="rounded-full object-contain"
            />
            <div className="flex flex-col">
              <span className="font-bold">{patient.username}</span>
              <span>{dayjs(post.createdAt).format("YYYY-MM-DD")}</span>
            </div>
          </div>
        </Wrapper>

        <Wrapper className="">
          {/** Title */}
          <div className="flex flex-col gap-2 ">
            <WrapperTitle>Caption</WrapperTitle>
            <span
              className={
                post.body.length > 0
                  ? "overflow-ellipsis line-clamp-3"
                  : "italic overflow-ellipsis line-clamp-3"
              }
            >
              {post.body.length > 0 ? post.body : "No Caption"}
            </span>
          </div>
        </Wrapper>

        <Wrapper className="overflow-clip">
          <div className="justify-center flex flex-col gap-2">
            <WrapperTitle>Photos ({post.postPhotos.length})</WrapperTitle>
            <div className="xl:w-[250px] lg:w-[150px] bg-black bg-opacity-20">
              {post.postPhotos.length === 0 ? (
                <BaseImage
                  src={imageReqHelper(post.postPhotos[0]?.filename)}
                  width={250}
                  height={110}
                  alt={"Chantek"}
                  className="object-contain p-2 max-h-[110px]"
                />
              ) : (
                <Carousel arrows infinite>
                  {post.postPhotos.map((photo) => (
                    <BaseImage
                      key={photo._id}
                      src={imageReqHelper(photo?.filename)}
                      width={250}
                      height={110}
                      alt={photo?.filename ?? "Chantek"}
                      className="object-contain max-h-[110px]"
                    />
                  ))}
                </Carousel>
              )}
            </div>
          </div>
        </Wrapper>

        <Wrapper className="">
          <div className="xl:w-[150px] w-[120px] flex flex-col gap-2">
            <WrapperTitle>Post Status</WrapperTitle>
            <div className="flex flex-col">
              <div>
                <span className="font-semibold">Like count:</span>{" "}
                {post.like_count}
              </div>
              <div>
                <span className="font-semibold">Comment count:</span>{" "}
                {post.comment_count}
              </div>
              <div>
                <span className="font-semibold">Save count:</span>{" "}
                {post.save_count}
              </div>
            </div>
          </div>
        </Wrapper>

        <Wrapper noBorder={true}>
          <div className="flex flex-col gap-2">
            <WrapperTitle>Actions</WrapperTitle>
            <div className="flex gap-4">
              <Button type="primary">View More</Button>
              <Button className="bg-red-500 text-white">Ban</Button>
            </div>
          </div>
        </Wrapper>
      </div>
    </Space>
  );
}

const Wrapper = ({
  noBorder,
  className,
  children,
}: {
  noBorder?: boolean;
  className?: string;
  children: React.ReactNode;
}) => {
  return (
    <>
      <div
        className={cn(
          className,
          noBorder ? "border-0" : "lg:border-b-0 border-b-2",
          "w-full md:pr-4 pb-2 lg:min-h-[150px]"
        )}
      >
        {children}
      </div>
      {!noBorder && (
        <Divider
          type="vertical"
          rootClassName="bg-gray-200 md:h-0 lg:h-[120px] w-[2px] h-0"
        />
      )}
    </>
  );
};

const WrapperTitle = ({ children }: { children: React.ReactNode }) => {
  return <div className="font-bold">{children}</div>;
};

export default PostCard;
