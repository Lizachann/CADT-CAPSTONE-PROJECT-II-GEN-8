import { fontsans } from "@/utils/fonts";
import { cn } from "@/lib/utils";
import LayoutProvider from "@/contexts/layout-provider";

export default function RootLayout({
  children,
}: Readonly<{
  children: React.ReactNode;
}>) {
  return (
    <main className={cn(
      "min-h-screen bg-background font-sans antialiased",
      fontsans.variable
    )}>
      <LayoutProvider>
        {children}
      </LayoutProvider>
    </main>
  );
}
