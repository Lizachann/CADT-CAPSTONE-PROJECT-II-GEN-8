"use client";
import { Table, TableColumnsType, Tag } from "antd";
import { convertDatasource } from "@/utils/antd-data-helper";

type Props = {
  charges: any;
};

interface ChargesReponseDto {
  metadata: {
    patientUsername: string;
    credits: number;
  };
  amount: number;
  payment_method_details: {
    card: {
      brand: string;
    };
  };
  status: string;
}

function ChargesTable({ charges }: Props) {
  const columns: TableColumnsType<ChargesReponseDto> = [
    {
      title: "Index",
      key: "index",
      render: (_, __, index: number) => <p>{index + 1}</p>,
    },
    {
      title: "Purchased by",
      key: "patient_username",
      render: (charge: ChargesReponseDto) => (
        <p>{charge?.metadata?.patientUsername}</p>
      ),
    },
    {
      title: "Point",
      key: "points",
      render: (charge: ChargesReponseDto) => <p>{charge?.metadata?.credits}</p>,
    },
    {
      title: "Amount ($)",
      key: "amount",
      render: (charge: ChargesReponseDto) => (
        <p className="font-semibold">$ {charge?.amount / 100}</p>
      ),
    },
    {
      title: "Method",
      key: "method",
      render: (charge: ChargesReponseDto) => (
        <p className="uppercase">
          {charge?.payment_method_details?.card?.brand}
        </p>
      ),
    },
    {
      title: "Status",
      key: "status",
      render: (charge: ChargesReponseDto) => (
        <>
          {charge?.status === "succeeded" ? (
            <Tag color={"green"}>Success</Tag>
          ) : (
            <Tag color={"red"}>Failed</Tag>
          )}
        </>
      ),
    },
  ];
  return (
    <Table
      pagination={{
        hideOnSinglePage: true,
      }}
      dataSource={convertDatasource(charges)}
      columns={columns}
    />
  );
}

export default ChargesTable;
