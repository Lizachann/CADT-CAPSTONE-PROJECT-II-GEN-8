import React, { Suspense } from 'react';
import { Layout, Spin } from 'antd';
import Sidebar from '@/components/layout/sidebar';

type Props = {
  children: React.ReactNode
}

function LayoutProvider({ children }: Props) {
  return (
    <Layout className='h-screen overflow-hidden'>
      <Suspense fallback={<Spin />}>
        <Sidebar>
          {children}
        </Sidebar>
      </Suspense>
    </Layout>
  )
}

export default LayoutProvider
