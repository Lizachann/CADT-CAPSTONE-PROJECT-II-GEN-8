import { Metadata } from "next";
import { BASE_APP_URL } from "../constants/env-constant";

type Props = Metadata & {
  title: string;
  url: string | URL;
  imageUrl?: string;
  description?: string;
};

export const pageMetadata = ({
  title,
  description,
  imageUrl,
}: Partial<Props>): Metadata => {
  return {
    title: title,
    openGraph: {
      title: title,
      type: "website",
      description: description,
      url: `${BASE_APP_URL}`,
      // images: imageUrl
      //   ? `https://og.tailgraph.com/og?bgUrl=${imageUrl}&bgTailwind=bg-white%20bg-no-repeat%20bg-center%20bg-contain`
      //   : `https://og.tailgraph.com/og?bgUrl=${tenboxPrimaryLogo}&bgTailwind=bg-white%20bg-no-repeat%20bg-center%20bg-contain`,
    },
    twitter: {
      card: "summary",
      title: title,
      description: description,
      images: imageUrl,
    },
    appleWebApp: {
      capable: true,
      statusBarStyle: "default",
      title: title,
    },
    formatDetection: {
      telephone: false,
    },
    robots: {
      index: true,
      follow: true,
      nocache: true,
      googleBot: {
        index: true,
        follow: true,
      },
    },
  };
};
