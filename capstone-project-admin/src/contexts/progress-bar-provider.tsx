"use client"
import { primary } from '@/styles/colors';
import { AppProgressBar as ProgressBar } from 'next-nprogress-bar';

type Props = {
  children: React.ReactNode
}

export default function ProgressProvider({ children }: Props) {
  return (
    <>
      {children}
      <ProgressBar
        height="4px"
        color={primary}
        options={{ showSpinner: false }}
        shallowRouting />
    </>
  )
}
