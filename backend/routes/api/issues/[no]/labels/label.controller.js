/**
 * POST /api/issues/:no/labels
 */
export const addIssueLabel = (req, res, next) => {
  const { no } = req.params;
  const { labelNo } = req.body;
  // TODO : 로직 작성
  res.status(200).end();
};

/**
 * DELETE /api/issues/:no/labels/:labelNo
 */
export const deleteIssueLabel = (req, res, next) => {
  const { labelNo } = req.params;
  // TODO : 로직 작성
  res.status(200).end();
};
