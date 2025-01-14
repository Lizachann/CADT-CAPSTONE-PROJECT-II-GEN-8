import { getBalances } from "@/service/get-service";

type Props = {};

async function TransactionCards({}: Props) {
  const { data: balances } = await getBalances();

  const available = balances?.available[0]?.amount / 100;
  const pending = balances?.pending[0]?.amount / 100;
  const total = available + pending;

  return (
    <div className="grid-cols-3 gap-8 grid">
      <div className="bg-white border border-gray-300 p-4 rounded-lg flex-col flex gap-y-5 min-w-[300px]">
        <p className="text-2xl font-semibold">Total: </p>
        <p className="text-4xl text-green-500 font-bold ">$ {total}</p>
      </div>
      <div className="bg-white border border-gray-300 p-4 rounded-lg flex-col flex gap-y-5 min-w-[300px]">
        <p className="text-2xl font-semibold">Pending: </p>
        <p className="text-4xl text-green-500 font-bold "> $ {pending}</p>
      </div>
      <div className="bg-white border border-gray-300 p-4 rounded-lg flex-col flex gap-y-5 min-w-[300px]">
        <p className="text-2xl font-semibold">Success: </p>
        <p className="text-4xl text-green-500 font-bold "> $ {available}</p>
      </div>
    </div>
  );
}

export default TransactionCards;
