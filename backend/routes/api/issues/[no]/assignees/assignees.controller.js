import { assigneeModel } from '@models';

/**
 * POST /api/issues/:no/assignees
 */
export const addIssueAssignee = async (req, res, next) => {
  try {
    const { no } = req.params;
    const { assigneeNo } = req.body;
    // TODO : 로직 작성

    // 더미데이터 사용
    await assigneeModel.bulkAddassignee({ assigneeNos: [1, 2], issueNo: no });
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
