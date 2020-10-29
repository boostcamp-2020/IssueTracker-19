/**
 * PATCH /api/issues/:no/title
 */
export const changeTitle = (req, res, next) => {
  const { no } = req.params;
  const { title } = req.body;
  // TODO : title 변경 로직 구현

  res.status(200).end();
};
