/**
 * PATCH /api/issues/:no/close
 */
export const closeIssue = (req, res, next) => {
  const { no } = req.params;
  // TODO : 로직 작성
  res.status(200).end();
};
