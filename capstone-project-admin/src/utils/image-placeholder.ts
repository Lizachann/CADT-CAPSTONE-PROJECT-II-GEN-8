export const shimmer = (w?: number, h?: number) => `
<svg width="${w ?? 700}" height="${
  h ?? 475
}" version="1.1" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink">
  <defs>
    <linearGradient id="g">
      <stop stop-color="#EBEBEB" offset="20%" />
      <stop stop-color="#D9D9D9" offset="50%" />
      <stop stop-color="#EBEBEB" offset="70%" />
    </linearGradient>
  </defs>
  <rect width="${w ?? 700}" height="${h ?? 475}" fill="#EBEBEB" />
  <rect id="r" width="${w ?? 700}" height="${h ?? 475}" fill="url(#g)" />
  <animate xlink:href="#r" attributeName="x" from="-${w ?? 700}" to="${
  w ?? 700
}" dur="1s" repeatCount="indefinite"  />
</svg>`;

export const toBase64 = (str: string) =>
  typeof window === 'undefined'
    ? Buffer.from(str).toString('base64')
    : window.btoa(str);

export const imagePlaceholder = (
  width?: number,
  height?: number
): `data:image/${string}` => {
  return `data:image/svg+xml;base64,${toBase64(shimmer(width, height))}`;
};
