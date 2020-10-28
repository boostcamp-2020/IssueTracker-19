/**
 * GET /api/issues/:no
 */
export const getIssue = (req, res, next) => {
  const { no } = req.params;

  // TODO : 하나의 이슈를 가져오는 로직 구현. comment도 같이!

  res.json({ issue: {} });
};
