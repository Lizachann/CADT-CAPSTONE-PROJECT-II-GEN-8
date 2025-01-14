export function convertDatasource(data: Array<any & { _id: string }>) {
  const list: Array<any & { key: string }> = [];
  data?.forEach((val) => {
    list.push({
      key: val._id,
      ...val,
    });
  });

  return list;
}