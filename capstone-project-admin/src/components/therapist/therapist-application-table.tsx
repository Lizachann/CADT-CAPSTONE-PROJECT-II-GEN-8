"use client";
import { TherapistResponseDto } from "@/service/api-types";
import { Table, TableColumnsType } from "antd";
import { convertDatasource } from "@/utils/antd-data-helper";
import TherapistModal from "./therapist-modal";

type Props = {
  therapistApplications: any;
};

function TherapistApplicationTable({ therapistApplications }: Props) {
  const columns: TableColumnsType = [
    {
      title: "First name",
      dataIndex: "first_name",
      key: "first_name",
    },
    {
      title: "Last name",
      dataIndex: "last_name",
      key: "last_name",
    },
    {
      title: "Email",
      dataIndex: "email",
      key: "email",
    },
    // {
    //   title: "Username",
    //   dataIndex: "username",
    //   key: "username",
    // },
    // {
    //   title: "Phone number",
    //   dataIndex: "phone_number",
    //   key: "phone_number",
    //   width: "20%",
    // },
    // {
    //   title: "Roles",
    //   dataIndex: "roles",
    //   key: "roles",
    //   width: "10%",
    //   className: "font-medium uppercase",
    // },
    // {
    //   title: "View",
    //   dataIndex: "",
    //   key: "view_user",
    //   width: "10%",
    //   render: (therapist: TherapistResponseDto) => (
    //     <div key={therapist._id}>
    //       <TherapistModal id={therapist._id} />
    //     </div>
    //   ),
    // },
  ];
  return (
    <Table
      pagination={{
        hideOnSinglePage: true,
      }}
      dataSource={convertDatasource(therapistApplications)}
      columns={columns}
    />
  );
}

export default TherapistApplicationTable;
