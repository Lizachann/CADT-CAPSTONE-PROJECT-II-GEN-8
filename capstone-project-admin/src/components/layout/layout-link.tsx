import useUrlParam from "@/lib/hooks/use-url-param";
import { cn } from "@/lib/utils";
import Link from "next/link";

export const LayoutLink = ({
  href,
  className,
  children,
}: {
  href: string;
  className?: string;
  children: React.ReactNode;
}) => {
  const { getFullPath } = useUrlParam()
  return (
    <Link
      href={href}
      className={cn(getFullPath() === href && "text-primary", className, "flex")}
    >
      {children}
    </Link>
  );
};
