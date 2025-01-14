"use client";
import { CreditReponseDto } from "@/service/api-types";
import { Button, Spin, Table, TableColumnsType } from "antd";
import { convertDatasource } from "@/utils/antd-data-helper";
import { useTransition } from "react";
import { updateCreditPackage } from "@/actions/credit-action";

type Props = {
  credits: Array<CreditReponseDto>;
};

function CreditTable({ credits }: Props) {
  const [isPending, startTransition] = useTransition();

  const columns: TableColumnsType<CreditReponseDto> = [
    {
      title: "Title",
      dataIndex: "title",
      key: "title",
    },
    {
      title: "Point",
      dataIndex: "points",
      key: "points",
    },
    {
      title: "Price ($)",
      key: "price",
      render: (credit: CreditReponseDto) => <p>$ {credit.price}</p>,
    },
    {
      title: "Discount (%)",
      dataIndex: "",
      key: "discount",
      render: (credit: CreditReponseDto) => <p>{credit.discount} %</p>,
    },
    {
      title: (
        <div className="flex items-center gap-2">
          Visible {isPending && <Spin />}
        </div>
      ),
      dataIndex: "",
      key: "is_visible",
      render: (credit: CreditReponseDto) => (
        <Button
          disabled={isPending}
          onClick={async () => {
            startTransition(async () => {
              await updateCreditPackage(credit._id, {
                is_visible: !credit?.is_visible,
              });
            });
          }}
        >
          <div>Status: {credit.is_visible ? "Visible" : "Not Visible"}</div>
        </Button>
      ),
      width: "20%",
    },
    {
      title: <div className="flex items-center gap-2">Actions</div>,
      dataIndex: "",
      key: "is_visible",
      render: (credit: CreditReponseDto) => (
        <div className="flex gap-2">
          <Button className="primary-button">
            <div>Edit</div>
          </Button>
          <Button className="danger-button">
            <div>Delete</div>
          </Button>
        </div>
      ),
    },
  ];
  return (
    <Table
      pagination={{
        hideOnSinglePage: true,
      }}
      dataSource={convertDatasource(credits)}
      columns={columns}
    />
  );
}

export default CreditTable;
