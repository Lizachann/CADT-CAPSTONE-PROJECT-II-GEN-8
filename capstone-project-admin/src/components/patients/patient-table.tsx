"use client"
import { PatientResponseDto } from "@/service/api-types"
import { Button, Spin, Table, TableColumnsType } from "antd"
import PatientModal from "./patient-modal"
import { useTransition } from "react"
import { convertDatasource } from "@/utils/antd-data-helper"
import { banPatient, unbanPatient } from "@/actions/patient-action"

type Props = {
  patients: Array<PatientResponseDto>
}

function PatientTable({ patients }: Props) {
  const [isPending, startTransition] = useTransition()
  const columns: TableColumnsType<PatientResponseDto> = [
    {
      title: "Email",
      dataIndex: "email",
      key: "email"
    },
    {
      title: "Username",
      dataIndex: "username",
      key: "username",
    },
    {
      title: "Roles",
      dataIndex: "roles",
      key: "roles",
      width: "10%"
    },
    {
      title: 'View',
      dataIndex: '',
      key: 'view_user',
      width: '10%',
      render: (patient: PatientResponseDto) => (
        <div key={patient._id}>
          <PatientModal id={patient._id} />
        </div>
      ),
    },
    {
      title: <div className="flex items-center gap-2">Ban {isPending && <Spin />}</div>,
      dataIndex: '',
      key: 'ban',
      render: (patient: PatientResponseDto) => (
        <Button
          disabled={isPending}
          key={patient._id}
          onClick={async () => {
            if (patient.is_banned) {
              startTransition(async () => {
                await unbanPatient(patient._id)
              })
            } else {
              startTransition(async () => {
                await banPatient(patient._id)
              })
            }
          }}>
          <div>
            Status: {patient.is_banned ? 'Banned' : "Not banned"}
          </div>
        </Button>
      ),
    },
  ]
  return (
    <Table
      pagination={{
        hideOnSinglePage: true
      }}
      className="w-full"
      dataSource={convertDatasource(patients)}
      columns={columns}
    />
  )
}

export default PatientTable
