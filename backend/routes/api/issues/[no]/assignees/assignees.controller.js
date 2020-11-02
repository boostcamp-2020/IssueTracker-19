import { assigneeModel } from '@models';
import { verify } from '@lib/utils';
import { errorMessage } from '@lib/constants';

/**
 * POST /api/issues/:no/assignees
 */
export const addIssueAssignee = async (req, res, next) => {
  try {
    const { no: issueNo } = req.params;
    const { assigneeNos } = req.body;

    if (verify([assigneeNos])) {
      await assigneeModel.bulkAddassignee({ assigneeNos, issueNo });
      res.status(200).end();
      return;
    }
    res.status(400).json({ message: errorMessage.MISSING_REQUIRED_VALUE });
  } catch (err) {
    next(err);
  }
};

/**
 * DELETE /api/issues/:no/assignees/:assigneeNo
 */
export const deleteIssueAssignee = async (req, res, next) => {
  try {
    const { no: issueNo, assigneeNo } = req.params;

    await assigneeModel.deleteIssueAssignee({ issueNo, assigneeNo });
    res.status(200).end();
  } catch (err) {
    next(err);
  }
};
