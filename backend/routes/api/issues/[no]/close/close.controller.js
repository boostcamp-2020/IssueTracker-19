import { issueModel } from '@models';

/**
 * PATCH /api/issues/:no/close
 */
export const closeIssue = async (req, res, next) => {
  try {
    const { no } = req.params;
    await issueModel.closeIssue({ no });
    res.status(200).end();
  } catch (err) {
    next(err);
  }
};
