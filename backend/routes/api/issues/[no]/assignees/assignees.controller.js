/**
 * POST /api/issues/:no/assignees
 */
export const addIssueAssignee = (req, res, next) => {
  const { assigneeNo } = req.body;
  // TODO : 로직 작성
  res.status(200).end();
};

/**
 * DELETE /api/issues/:no/assignees/:assigneeNo
 */
export const deleteIssueAssignee = (req, res, next) => {
  const { assigneeNo } = req.params;
  // TODO : 로직 작성
  res.status(200).end();
};
