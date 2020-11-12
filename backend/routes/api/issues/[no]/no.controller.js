import { issueService } from '@services';
import { issueModel } from '@models';

/**
 * GET /api/issues/:no
 */
export const getIssue = async (req, res, next) => {
  try {
    const { no } = req.params;
    const issue = await issueService.getIssue({ no });

    res.json({ issue });
  } catch (err) {
    next(err);
  }
};

/**
 * DELETE /api/issues/:no
 */
export const deleteIssue = async (req, res, next) => {
  try {
    const { no } = req.params;
    await issueModel.deleteIssue({ no });

    res.status(200).end();
  } catch (err) {
    next(err);
  }
};
