import { issueModel } from '@models';

/**
 * PATCH /api/issues/:no/open
 */
export const openIssue = async (req, res, next) => {
  try {
    const { no } = req.params;
    await issueModel.openIssue({ no });
    res.status(200).end();
  } catch (err) {
    next(err);
  }
};
