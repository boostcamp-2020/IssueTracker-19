import { issueModel, commentModel, labelModel, assigneeModel } from '@models';
import { issueService } from '@services';

/**
 * GET /api/issues
 */
export const getIssues = async (req, res, next) => {
  try {
    const options = req.query;
    const { nickname } = req.user;

    const filterdIssues = await issueService.getFilterdIssues(options, nickname);
    res.json({ issues: filterdIssues });
  } catch (err) {
    next(err);
  }
};

/**
 * POST /api/issues
 */
export const addIssue = async (req, res, next) => {
  try {
    const { title, assigneeNos, milestoneNo, labelNos, content } = req.body;
    const { no: authorNo } = req.user;

    const [{ insertId: issueNo }] = await issueModel.addIssue({
      title,
      authorNo,
      milestoneNo,
    });

    // TODO :: commentModel의 addComment 호출해서 isHead = 1으로 추가할 것

    if (labelNos && labelNos.length) {
      await labelModel.bulkAddIssueLabel({ labelNos, issueNo });
    }

    if (assigneeNos && assigneeNos.length) {
      await assigneeModel.bulkAddassignee({ assigneeNos, issueNo });
    }
    res.status(201).end();
  } catch (err) {
    next(err);
  }
};
