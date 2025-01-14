import "@/styles/globals.css";
import { AntdRegistry } from "@ant-design/nextjs-registry";
import AntdProvider from "./antd-provider";
import ProgressProvider from "./progress-bar-provider";
import { SessionProvider } from "next-auth/react";
import { auth } from "@/auth";

type Props = {
  children: React.ReactNode
}

async function AppThemeProvider({ children }: Props) {
  const session = await auth()
  return (
    <SessionProvider session={session}>
      <ProgressProvider>
        <AntdRegistry>
          <AntdProvider>
            {children}
          </AntdProvider>
        </AntdRegistry>
      </ProgressProvider>
    </SessionProvider>
  )
}

export default AppThemeProvider
