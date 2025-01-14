import { ENV_MODE } from "@/constants/env-constant";
import AppThemeProvider from "@/contexts/app-theme-provider";
import { logo } from "@/utils/image-req-helper";
import { Metadata } from "next";

type Props = {
  children: React.ReactNode
}

export const metadata: Metadata = {
  icons: logo,
  title: {
    template: `%s | Capstone Admin - ${ENV_MODE !== 'production' && ENV_MODE}`,
    default: `Capstone Admin - ${ENV_MODE !== 'production' && ENV_MODE}`
  }
}

async function RootLayout({ children }: Props) {
  return (
    <html lang="en" suppressHydrationWarning>
      <body>
        <AppThemeProvider>
          {children}
        </AppThemeProvider>
      </body>
    </html>
  )
}

export default RootLayout
