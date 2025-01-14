"use client"

import { URL_PARAM } from "@/constants/url-param-constant";
import useUrlParam from "@/lib/hooks/use-url-param";
import { cn } from "@/lib/utils";
import { LeftOutlined, RightOutlined } from "@ant-design/icons";
import { Pagination, PaginationProps } from "antd";
import Link from "next/link";
import { usePathname } from "next/navigation";

type Props = {
  totalItems: number
  currentPage: number
  totalPages: number;
  className?: string;
}

function PaginationUi({ totalItems, currentPage, totalPages, className }: Props) {
  const pathname = usePathname()
  const { updateUrlParam, getAllParams } = useUrlParam()
  const onChange: PaginationProps['onChange'] = (page) => {
    updateUrlParam({
      paramName: URL_PARAM.PAGE,
      paramValue: page.toString()
    })
  };


  if (totalPages > 1)
    return (
      <Pagination
        className={cn(className, 'w-full')}
        showQuickJumper
        defaultCurrent={1}
        showTotal={(total) => `Total ${total} items`}
        showSizeChanger={false}
        total={totalItems}
        current={currentPage ?? 1}
        onChange={onChange}
        itemRender={(page, type) => {
          if (type === 'prev') {
            return (
              <Link href={'#'}>
                <LeftOutlined />
              </Link>
            )
          }
          if (type === 'next') {
            return (
              <Link href={'#'}>
                <RightOutlined />
              </Link>
            )
          }
          if (type === 'jump-prev') {
            return (
              <Link href={'#'}>
                ...
              </Link>
            )
          }
          if (type === 'jump-next') {
            return (
              <Link href={'#'}>
                ...
              </Link>
            )
          }
          return (
            <Link href={`${pathname}?${URL_PARAM.PAGE}=${page}${getAllParams().length > 0 ? `&${getAllParams()}` : ''}`}>
              {page}
            </Link>
          )
        }}
      />
    )
}

export default PaginationUi
