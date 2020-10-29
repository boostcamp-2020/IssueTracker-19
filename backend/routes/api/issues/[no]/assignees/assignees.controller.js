import { assigneeModel } from '@models';

/**
 * POST /api/issues/:no/assignees
 */
export const addIssueAssignee = async (req, res, next) => {
  try {
    const { no: issueNo } = req.params;
    const { assigneeNos } = req.body;

    await assigneeModel.bulkAddassignee({ assigneeNos, issueNo });
    res.status(200).end();
  } catch (err) {
    next(err);
  }
};

/**
 * DELETE /api/issues/:no/assignees/:assigneeNo
 */
export const deleteIssueAssignee = (req, res, next) => {
  const { assigneeNo } = req.params;
  // TODO : 로직 작성
  res.status(200).end();
};
