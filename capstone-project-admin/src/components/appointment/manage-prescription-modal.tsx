"use client";
import { updateAppointment } from "@/actions/appointment-action";
import { STATUS } from "@/constants/status-constant";
import { managePrescriptionSchema } from "@/lib/validation/manage-prescription-schema";
import { Button, Input, Modal } from "antd";
import { Form, Formik } from "formik";
import { Stethoscope } from "lucide-react";
import React, { useState, useTransition } from "react";

type Props = {
  appointmentId: string;
};

function ManagePrescriptionModal({ appointmentId }: Props) {
  const [isOpened, setIsOpened] = useState(false);

  const [isPending, startTransition] = useTransition();

  const showModal = () => {
    setIsOpened(true);
  };

  const handleCancel = () => {
    setIsOpened(false);
  };

  const handleUpdateAppointment = async (values: any, resetForm: any) => {
    startTransition(async () => {
      await updateAppointment(appointmentId, {
        note: values.note,
        prescriptions: values.prescriptions,
        status: STATUS.COMPLETED,
      })
        .then(() => {
          resetForm();
          setIsOpened(false);
        })
        .catch((error) => {
          console.log(error);
        });
    });
  };

  return (
    <>
      <Button
        disabled={isPending}
        // onClick={async () => {
        //   startTransition(async () => {
        //     await updateAppointment(appointmentId, {
        //       status: STATUS.COMPLETED,
        //     });
        //   });
        // }}
        onClick={showModal}
        className="primary-button"
      >
        Complete
      </Button>
      <Modal
        width={700}
        centered={true}
        footer={[]}
        open={isOpened}
        onCancel={handleCancel}
      >
        <Formik
          initialValues={{
            note: "",
            prescriptions: "",
          }}
          validationSchema={managePrescriptionSchema}
          onSubmit={(values, { resetForm }) =>
            handleUpdateAppointment(values, resetForm)
          }
        >
          {({ values, handleChange }) => (
            <Form>
              <div className="mb-4 flex gap-x-4">
                <Stethoscope size={50} />
                <div>
                  <h1 className="text-xl font-semibold">Patient Report</h1>
                  <p className="text-sm">Give advices to patient</p>
                </div>
              </div>

              <div className="mb-4">
                <label
                  htmlFor="note"
                  className="block mb-2 text-sm font-medium "
                >
                  Note<span className="text-red-500 text-sm ml-1">*</span>
                </label>
                <Input.TextArea
                  name="note"
                  value={values.note}
                  onChange={handleChange}
                />
              </div>
              <div className="mb-4">
                <label
                  htmlFor="prescriptions"
                  className="block mb-2 text-sm font-medium "
                >
                  Prescriptions
                </label>
                <Input.TextArea
                  name="prescriptions"
                  value={values.prescriptions}
                  onChange={handleChange}
                />
              </div>
              <div className="grid grid-cols-2 gap-x-8">
                <Button
                  className="danger-button"
                  onClick={() => setIsOpened(false)}
                >
                  Cancel
                </Button>
                <Button
                  disabled={isPending}
                  htmlType="submit"
                  className="primary-button"
                >
                  Submit
                </Button>
              </div>
            </Form>
          )}
        </Formik>
      </Modal>
    </>
  );
}

export default ManagePrescriptionModal;
