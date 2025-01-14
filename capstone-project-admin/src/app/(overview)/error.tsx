'use client'

import { Button } from 'antd'
import { useEffect } from 'react'

export default function Error({
  error,
  reset,
}: {
  error: Error & { digest?: string }
  reset: () => void
}) {
  useEffect(() => {
    console.error(error)
  }, [error])

  return (
    <div className='flex flex-col items-start gap-4 h-[70vh]'>
      <h2 className='font-bold text-2xl text-primary'>Something went wrong!</h2>
      <Button
        type='primary'
        size='large'
        className='font-semibold'
        onClick={
          // Attempt to recover by trying to re-render the segment
          () => reset()
        }
      >
        Try again
      </Button>
    </div>
  )
}