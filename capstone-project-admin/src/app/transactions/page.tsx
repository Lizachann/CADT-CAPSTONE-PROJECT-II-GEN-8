import { pageMetadata } from "@/utils/metadata-helpter";
import { Metadata } from "next";
import { Suspense } from "react";
import { Card, Table } from "antd";
import ListCredit from "@/components/credit/list-credit";
import CreateCreditModal from "@/components/credit/create-credit-modal";
import ListCharges from "@/components/transactions/list-charges";
import TransactionCards from "@/components/transactions/transaction-cards";

export const metadata: Metadata = pageMetadata({
  title: "Manage Transactions",
});

type Props = {};

async function TransactionPage({}: Props) {
  return (
    <div className="flex flex-col gap-y-4">
      <h1 className="text-2xl font-bold">Transaction Details</h1>
      <TransactionCards />
      <Suspense fallback={<Table loading={true} />}>
        <ListCharges />
      </Suspense>
    </div>
  );
}

export default TransactionPage;
