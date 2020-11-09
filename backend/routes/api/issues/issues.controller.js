import { issueModel, commentModel, labelModel, assigneeModel } from '@models';
import { issueService } from '@services';
import { verify } from '@lib/utils';
import { errorMessage } from '@lib/constants';

/**
 * GET /api/issues
 */
export const getIssues = async (req, res, next) => {
  try {
    const options = req.query;
    const { nickname } = req.user;

    const filterdIssues = await issueService.getFilterdIssues(options, nickname);
    res.json({ issues: filterdIssues.reverse() });
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
    if (verify([title, content])) {
      const { no } = req.user;

      const [{ insertId: issueNo }] = await issueModel.addIssue({
        title,
        authorNo: no,
        milestoneNo,
      });

      await commentModel.addComment({ issueNo, userNo: no, content, isHead: 1 });

      if (labelNos && labelNos.length) {
        await labelModel.bulkAddIssueLabel({ labelNos, issueNo });
      }

      if (assigneeNos && assigneeNos.length) {
        await assigneeModel.bulkAddassignee({ assigneeNos, issueNo });
      }
      res.status(201).end();
      return;
    }
    res.status(400).json({ message: errorMessage.MISSING_REQUIRED_VALUE });
  } catch (err) {
    next(err);
  }
};

/**
 * PATCH /api/issues/open
 */
export const openMultipleIssues = async (req, res, next) => {
  try {
    const { issueNos } = req.body;
    if (verify([issueNos]) && issueNos.length) {
      await issueModel.openIssues({ issueNos });
      res.status(200).end();
    }
  } catch (err) {
    next(err);
  }
};

/**
 * PATCH /api/issues/close
 */
export const closeMultipleIssues = async (req, res, next) => {
  try {
    const { issueNos } = req.body;
    if (verify([issueNos]) && issueNos.length) {
      await issueModel.closeIssues({ issueNos });
      res.status(200).end();
    }
  } catch (err) {
    next(err);
  }
};
