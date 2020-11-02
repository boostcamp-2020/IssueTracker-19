import { issueService } from '@services';

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
