import { getTherapistApplications } from "@/service/get-service";
import EmptyData from "../ui/empty-data";
import TherapistTable from "./therapist-table";
import TherapistApplicationTable from "./therapist-application-table";
import PostCard from "../posts/post-card";
import TherapistApplicationCard from "./therapist-application-card";

type Props = {};

async function ListTherapistApplication({}: Props) {
  const { data: therapistApplications } = await getTherapistApplications();

  if (!therapistApplications || therapistApplications.length === 0) {
    return <EmptyData />;
  }

  return (
    <div className="flex flex-col gap-4">
      {therapistApplications.map((therapistApplication: any) => (
        <TherapistApplicationCard
          key={therapistApplication._id}
          therapistApplication={therapistApplication}
        />
      ))}
    </div>
  );
}

export default ListTherapistApplication;
