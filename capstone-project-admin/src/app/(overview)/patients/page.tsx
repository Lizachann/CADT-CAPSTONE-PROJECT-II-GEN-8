import { pageMetadata } from "@/utils/metadata-helpter";
import { Metadata } from "next";
import ListPatients from "../../../components/patients/list-patients";
import { Suspense } from "react";
import { Spin } from "antd";

export const metadata: Metadata = pageMetadata({
  title: "Patients",
});

type Props = {
  searchParams: {
    page: string;
  };
};

function PatientsPage({ searchParams }: Props) {
  return (
    <div className="flex flex-col gap-y-4">
      <h1 className="text-2xl font-bold">Manage Patients</h1>
      <Suspense fallback={<Spin />}>
        <ListPatients searchParams={searchParams} />
      </Suspense>
    </div>
  );
}

export default PatientsPage;
