"use client";
import { Button, Divider, Space, Tag } from "antd";
import { useTransition } from "react";
import BaseImage from "../ui/base-image";
import { cn } from "@/lib/utils";
import {
  imageReqHelper,
  logo,
  therapistApplicationPhotosHelper,
} from "@/utils/image-req-helper";

type Props = {
  therapistApplication: any;
};

function TherapistApplicationCard({ therapistApplication }: Props) {
  const [isPending, startTransition] = useTransition();
  const handleUpdate = (status: string) => {
    // startTransition(async () => {
    //   console.log(therapistApplication.id);
    //   await updateRegistration(status, therapistApplication._id);
    // });
  };

  return (
    <Space
      direction="vertical"
      className="border rounded-md p-4 lg:max-h-[200px] max-w-[1400px]"
    >
      <div className="lg:flex flex lg:flex-row flex-col w-full gap-2 items-center">
        <Wrapper className="">
          {/** Title */}
          <div className="flex flex-col gap-2 ">
            <WrapperTitle>First name</WrapperTitle>
            <div>{therapistApplication?.first_name}</div>
          </div>
        </Wrapper>
        <Wrapper className="">
          {/** Title */}
          <div className="flex flex-col gap-2 ">
            <WrapperTitle>Last name</WrapperTitle>
            <div>{therapistApplication?.last_name}</div>
          </div>
        </Wrapper>
        <Wrapper className="">
          <div className="xl:w-[150px] w-[120px] flex flex-col gap-2">
            <WrapperTitle>Email</WrapperTitle>
            <div className="flex flex-col">
              <div>{therapistApplication?.email}</div>
            </div>
          </div>
        </Wrapper>

        <Wrapper className="overflow-clip">
          <div className="justify-center flex flex-col gap-2">
            <WrapperTitle>
              Photos ({therapistApplication.therapistApplicationPhotos.length})
            </WrapperTitle>
            <div className="xl:w-[250px] lg:w-[150px] bg-black bg-opacity-20">
              {therapistApplication.therapistApplicationPhotos.length === 0 ? (
                <BaseImage
                  src={logo}
                  width={250}
                  height={110}
                  alt={"Chantek"}
                  className="object-contain p-2 max-h-[110px]"
                />
              ) : (
                <BaseImage
                  src={logo}
                  width={250}
                  height={110}
                  alt={"Chantek"}
                  className="object-contain p-2 max-h-[110px]"
                />
              )}
            </div>
          </div>
        </Wrapper>

        <Wrapper className="">
          <div className="xl:w-[150px] w-[120px] flex flex-col gap-2">
            <WrapperTitle>Application Status</WrapperTitle>
            <div className="flex flex-col">
              <div className="uppercase font-semibold">
                {therapistApplication?.status === "accepeted" && (
                  <Tag color="green">{therapistApplication?.status}</Tag>
                )}
                {therapistApplication?.status === "requested" && (
                  <Tag color="blue">{therapistApplication?.status}</Tag>
                )}
                {therapistApplication?.status === "rejected" && (
                  <Tag color="red">{therapistApplication?.status}</Tag>
                )}
              </div>
            </div>
          </div>
        </Wrapper>

        <Wrapper noBorder={true}>
          <div className="flex flex-col gap-2">
            <WrapperTitle>Actions</WrapperTitle>
            <div className="flex gap-4">
              <Button type="primary" onClick={() => handleUpdate("accepeted")}>
                Accept
              </Button>
              <Button
                onClick={() => handleUpdate("rejected")}
                className="bg-red-500 text-white"
              >
                Reject
              </Button>
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

export default TherapistApplicationCard;
