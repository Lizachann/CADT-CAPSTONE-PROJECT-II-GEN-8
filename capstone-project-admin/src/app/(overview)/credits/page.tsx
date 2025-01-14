import { pageMetadata } from "@/utils/metadata-helpter";
import { Metadata } from "next";
import { Suspense } from "react";
import { Table } from "antd";
import ListCredit from "@/components/credit/list-credit";
import CreateCreditModal from "@/components/credit/create-credit-modal";

export const metadata: Metadata = pageMetadata({
  title: "Manage Credits",
});

type Props = {};

async function CreditPage({}: Props) {
  return (
    <div className="flex flex-col gap-y-4">
      <h1 className="text-2xl font-bold">Manage Credit Package</h1>
      <CreateCreditModal />
      <Suspense fallback={<Table loading={true} />}>
        <ListCredit/>
      </Suspense>
    </div>
  );
}

export default CreditPage;
