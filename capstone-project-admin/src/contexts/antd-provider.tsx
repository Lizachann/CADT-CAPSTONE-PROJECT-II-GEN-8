"use client"
import { primary } from "@/styles/colors"
import { StyleProvider } from "@ant-design/cssinjs"
import { ConfigProvider } from "antd"

type Props = {
  children: React.ReactNode
}

function AntdProvider({ children }: Props) {
  return (
    <StyleProvider layer>
      <ConfigProvider
        theme={{
          cssVar: true,
          token: {
            // Seed Token
            colorPrimary: primary,
            borderRadius: 10,

            colorLink: "#000"
          }
        }}
      >
        {children}
      </ConfigProvider>
    </StyleProvider>
  )
}

export default AntdProvider
