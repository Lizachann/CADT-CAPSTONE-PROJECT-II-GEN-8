import { Model } from 'mongoose';

export const getPaginateMeta = async ({
  model,
  limit,
  page,
  resLength,
}: {
  model: Model<any>;
  limit?: number;
  page?: number;
  resLength: number;
}) => {
  const totalItems = await model.countDocuments();
  const totalPages = Math.floor((totalItems - 1) / limit) + 1;

  return {
    totalItems,
    totalPages,
    itemsPerPage: Number(limit),
    currengPage: Number(page),
    currentPageItems: resLength,
  };
};
