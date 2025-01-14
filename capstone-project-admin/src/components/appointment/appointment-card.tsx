"use client";
import { updateAppointment } from "@/actions/appointment-action";
import { STATUS } from "@/constants/status-constant";
import { AppointmentResponseDto } from "@/service/api-types";
import { dateFormat } from "@/utils/date-format";
import { Button, Spin, Tag } from "antd";
import { useTransition } from "react";
import ManagePrescriptionModal from "./manage-prescription-modal";

type Props = {
  appointments: Array<AppointmentResponseDto>;
};

function AppointmentCard({ appointments }: Props) {
  const [isPending, startTransition] = useTransition();

  return (
    <>
      {appointments?.map((appointment, index) => (
        <div
          key={index}
          className="shadow-md border border-gray-200 rounded-lg p-4 flex justify-between items-center"
        >
          <div className="w-full grid grid-cols-4 gap-y-4">
            <div>
              <p className="font-semibold">Patient</p>
              <p>{appointment?.patient?.username}</p>
            </div>
            <div>
              <p className="font-semibold">Scheduled Date</p>
              <p>
                {
                  dateFormat({
                    date: appointment?.scheduleDate,
                    formatType: "DD-MM-YYYY",
                  }).newDate
                }
              </p>
            </div>
            <div>
              <p className="font-semibold">Therapist</p>
              <p>{appointment?.patient?.username}</p>
            </div>
            <div>
              <p className="font-semibold">Status</p>
              <Tag
                className="uppercase"
                color={
                  appointment?.status === STATUS.REQUESTED
                    ? "gold"
                    : appointment?.status === STATUS.SCHEDULED
                    ? "blue"
                    : appointment?.status === STATUS.COMPLETED
                    ? "green"
                    : "red"
                }
              >
                {appointment?.status}
              </Tag>
            </div>
            <div>
              <p className="font-semibold">Symptom</p>
              <p>{appointment?.symptoms}</p>
            </div>
            <div>
              <p className="font-semibold">Note</p>
              <p>{appointment?.note}</p>
            </div>
            <div>
              <p className="font-semibold">Start time</p>
              <p>{appointment?.start_time}</p>
            </div>
            <div>
              <p className="font-semibold">End time</p>
              <p>{appointment?.end_time}</p>
            </div>
          </div>
          {isPending && <Spin />}
          {appointment?.status === STATUS.REQUESTED && !isPending && (
            <div className="flex gap-x-4">
              <Button
                disabled={isPending}
                onClick={async () => {
                  startTransition(async () => {
                    await updateAppointment(appointment?._id, {
                      status: STATUS.SCHEDULED,
                    });
                  });
                }}
                className="primary-button"
              >
                Accept
              </Button>
              <Button
                disabled={isPending}
                onClick={async () => {
                  startTransition(async () => {
                    await updateAppointment(appointment?._id, {
                      status: STATUS.REJECTED,
                    });
                  });
                }}
                className="danger-button"
              >
                Reject
              </Button>
            </div>
          )}
          {appointment?.status === STATUS.SCHEDULED && !isPending && (
            <div className="flex gap-x-4">
              <ManagePrescriptionModal appointmentId={appointment?._id} />
            </div>
          )}
        </div>
      ))}
    </>
  );
}

export default AppointmentCard;
