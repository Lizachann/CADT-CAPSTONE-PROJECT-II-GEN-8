import { pageMetadata } from "@/utils/metadata-helpter";
import { Metadata } from "next";
import { Suspense } from "react";
import { Table } from "antd";
import ListTherapistApplication from "@/components/therapist/list-therapist-application";

export const metadata: Metadata = pageMetadata({
  title: "Therapist Application Form",
});

type Props = {};

async function TherapistApplicationPage({}: Props) {
  return (
    <div className="flex flex-col gap-y-4">
      <h1 className="text-2xl font-bold">Therapist Applications</h1>
      <Suspense fallback={<Table loading={true} />}>
        <ListTherapistApplication />
      </Suspense>
    </div>
  );
}

export default TherapistApplicationPage;
