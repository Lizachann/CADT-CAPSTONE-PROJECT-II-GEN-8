"use client"
import { cn } from "@/lib/utils";
import { imagePlaceholder } from "@/utils/image-placeholder";
import { logo } from "@/utils/image-req-helper";
import Image, { ImageProps, StaticImageData } from "next/image";
import { useEffect, useState } from "react";

type Props = ImageProps & {
  src: string | StaticImageData;
  alt: string;
  width?: number;
  height?: number;
  customFallback?: string | StaticImageData;
}

/** 
 * @description 
 * - Default Next Image.
 * - Handles error when invalid image
 * - Accepts all Next Image props
 * @default 
 * props: {
  * loading: "lazy"
  * quality: 100
  * placeholder: "blur"
 * }
 */
function BaseImage({ src, alt, width, height, customFallback, ...props }: Props) {
  const [imgSrc, setImgSrc] = useState<string | StaticImageData>(src);

  useEffect(() => {
    setImgSrc(src)
  }, [src])

  return (
    <Image
      width={width}
      height={height}
      {...props}
      src={imgSrc}
      // src={props.placeholder ?? imagePlaceholder(width, height)}
      alt={alt}
      loading={!props.priority ? props.loading ?? "lazy" : undefined}
      placeholder={props.placeholder ?? imagePlaceholder(width, height)}
      quality={props.quality ?? 100}
      onError={() => {
        setImgSrc(customFallback ?? logo)
      }}
      onLoad={(res) => {
        if (res.currentTarget.naturalWidth === 0) { // broken image
          setImgSrc(customFallback ?? logo)
        }
      }}
      className={cn(props.className)}
    />
  )
}

export default BaseImage
