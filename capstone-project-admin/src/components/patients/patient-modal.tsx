"use client"
import usePatient from "@/lib/hooks/swr-hooks/use-patient";
import { Button, Modal, Spin } from "antd";
import { useState } from "react";

type Props = {
  id: string;
}

function PatientModal({ id }: Props) {
  const { userData, isLoading } = usePatient(id)
  const [isOpened, setIsOpened] = useState(false)

  const showModal = () => {
    setIsOpened(true)
  }

  const handleCancel = () => {
    setIsOpened(false)
  }

  if (isLoading) {
    return <Spin />
  }

  return (
    <>
      <Button type="primary" onClick={showModal}>
        View
      </Button>
      <Modal
        footer={[]}
        title={userData?.username} open={isOpened}
        onCancel={handleCancel}
      >
        <p>{userData._id}</p>
        <p>{userData?.email}</p>
        <p>{userData?.username}</p>
        <p>{userData?.phone_number}</p>
        <p>{userData?.gender}</p>
        {userData.roles.map((role, index) => (
          <p key={index}>{role}</p>
        ))}
      </Modal>
    </>
  )
}

export default PatientModal