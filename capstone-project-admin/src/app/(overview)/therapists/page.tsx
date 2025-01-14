import { pageMetadata } from "@/utils/metadata-helpter";
import { Metadata } from "next";
import { Suspense } from "react";
import { Table } from "antd";
import ListTherapist from "@/components/therapist/list-therapist";
import CreateTherapistModal from "@/components/therapist/create-therapist-modal";

export const metadata: Metadata = pageMetadata({
  title: "Manage Therapist",
});

type Props = {};

async function TherapistsPage({}: Props) {
  return (
    <div className="flex flex-col gap-y-4">
      <h1 className="text-2xl font-bold">Manage Therapist</h1>
      <CreateTherapistModal />
      <Suspense fallback={<Table loading={true} />}>
        <ListTherapist />
      </Suspense>
    </div>
  );
}

export default TherapistsPage;
