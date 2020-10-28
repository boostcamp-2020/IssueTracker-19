/**
 * PATCH /api/issues/:no/open
 */
export const openIssue = (req, res, next) => {
  const { no } = req.params;
  // TODO : 로직 작성
  res.status(200).end();
};
